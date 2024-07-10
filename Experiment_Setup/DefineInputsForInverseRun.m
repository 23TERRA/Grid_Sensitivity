function [UserVar,InvStartValues,Priors,Meas,BCsAdjoint,RunInfo]=...
    DefineInputsForInverseRun(UserVar,CtrlVar,MUA,BCs,F,l,GF,InvStartValues,Priors,Meas,BCsAdjoint,RunInfo)

persistent AmeryVelocityFu AmeryVelocityFv AmeryVelocityFuErr AmeryVelocityFvErr
%% get measurments and define error covariance matrices
if isempty(AmeryVelocityFu)
    fprintf('Loading interpolants for surface velocity data: %-s ',UserVar.SurfaceVelocityInterpolant)
    load(UserVar.SurfaceVelocityInterpolant,'AmeryVelocityFu','AmeryVelocityFv','AmeryVelocityFuErr','AmeryVelocityFvErr')
    fprintf(' done.\n')
end

Meas.us = AmeryVelocityFu(MUA.coordinates(:,1), MUA.coordinates(:,2));
Meas.vs = AmeryVelocityFv(MUA.coordinates(:,1), MUA.coordinates(:,2));

usError = AmeryVelocityFuErr(MUA.coordinates(:,1), MUA.coordinates(:,2));
vsError = AmeryVelocityFvErr(MUA.coordinates(:,1), MUA.coordinates(:,2));

MissingData=isnan(Meas.us) | isnan(Meas.vs) | isnan(usError) | (usError==0)| isnan(vsError) | (vsError==0);
Meas.us(MissingData)=0 ;  Meas.vs(MissingData)=0 ; usError(MissingData)=1e10; vsError(MissingData)=1e10;

AmeryUBO = scatteredInterpolant(MUA.coordinates(:,1), MUA.coordinates(:,2), Meas.us);
AmeryVBO = scatteredInterpolant(MUA.coordinates(:,1), MUA.coordinates(:,2), Meas.vs);
save_name = 'AmeryObserve_ub_vb.mat';
save(save_name, 'AmeryUBO', 'AmeryVBO');
Meas.usCov=sparse(1:MUA.Nnodes, 1:MUA.Nnodes, usError.^2, MUA.Nnodes, MUA.Nnodes);
Meas.vsCov=sparse(1:MUA.Nnodes, 1:MUA.Nnodes, vsError.^2, MUA.Nnodes, MUA.Nnodes);

%% after discussion in 20190808, set dhdt = 0 in Amery (well-behaved)
Meas.dhdt = zeros(numel(MUA.coordinates(:,1)), 1);
dhdtError = 1;
% dhdtError = 0.1;
% dhdtError = 0.01;
Meas.dhdtCov = sparse(1:MUA.Nnodes, 1:MUA.Nnodes, dhdtError.^2, MUA.Nnodes, MUA.Nnodes);
%% Define Start Values of Inversion
[UserVar,InvStartValues.C,InvStartValues.m]=DefineSlipperyDistribution(UserVar,CtrlVar,MUA,CtrlVar.time,F.s,F.b,F.s-F.b,F.S,F.B,F.rho,F.rhow,GF);
[UserVar,InvStartValues.AGlen,InvStartValues.n]=DefineAGlenDistribution(UserVar,CtrlVar,MUA,CtrlVar.time,F.s,F.b,F.s-F.b,F.S,F.B,F.rho,F.rhow,GF);
%% Define Priors
Priors.AGlen=AGlenVersusTemp(-10);
Priors.n=3;
Priors.m=3;

ub=10;
tau=80 ; % units meters, year , kPa
C0=ub/tau^Priors.m;
Priors.C=C0;
Priors.rho=F.rho;
Priors.rhow=F.rhow;
InvStartValues.C=Priors.C ;
end