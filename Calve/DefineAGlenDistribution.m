function [UserVar,AGlen,n]=DefineAGlenDistribution(UserVar,CtrlVar,MUA,time,s,b,h,S,B,rho,rhow,GF)
persistent AmeryF_AGlen
n  = 3;
if isempty(AmeryF_AGlen)
    fprintf('Define AGlen Distribution: loading file: %-s ', UserVar.Inverse_AGlen_C)
    load(UserVar.Inverse_AGlen_C, 'AmeryF_AGlen');
    fprintf(' done \n')
end
AGlen = AmeryF_AGlen(MUA.coordinates(:,1), MUA.coordinates(:,2));
end
