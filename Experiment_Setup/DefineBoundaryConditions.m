function  [UserVar,BCs]=DefineBoundaryConditions(UserVar,CtrlVar,MUA,BCs,time,s,b,h,S,B,ub,vb,ud,vd,GF)
persistent AmeryVelocityFu AmeryVelocityFv
GroundedBoundaryNodes=MUA.Boundary.Nodes(GF.node(MUA.Boundary.Nodes)>0.5);
BCs.vbFixedNode = GroundedBoundaryNodes; 
BCs.ubFixedNode = GroundedBoundaryNodes; 
x = MUA.coordinates(:,1);
y = MUA.coordinates(:,2);
% [BCs.ubFixedValue,BCs.vbFixedValue]=EricVelocities(CtrlVar,...
%     [x(GroundedBoundaryNodes), y(GroundedBoundaryNodes)]);

%% To set velocities at all grounded nodes along the boundary to zero:
% BCs.ubFixedValue = zeros(numel(GroundedBoundaryNodes),1);
% BCs.vbFixedValue = zeros(numel(GroundedBoundaryNodes),1);
%% To set velocities at all grounded nodes along the boundary to MEaSUREs-v2:

if isempty(AmeryVelocityFu)
    fprintf('Define Boundary Velocity: loading file: %-s ',UserVar.SurfaceVelocityInterpolant)
    load(UserVar.SurfaceVelocityInterpolant,'AmeryVelocityFu', 'AmeryVelocityFv');
    fprintf(' done \n')
end

BCs.ubFixedValue = AmeryVelocityFu(x(GroundedBoundaryNodes), y(GroundedBoundaryNodes));
BCs.vbFixedValue = AmeryVelocityFv(x(GroundedBoundaryNodes), y(GroundedBoundaryNodes));
BCMissingData=isnan(BCs.ubFixedValue) | isnan(BCs.vbFixedValue) ;
BCs.ubFixedValue(BCMissingData)=0 ;  BCs.vbFixedValue(BCMissingData)=0 ;
end