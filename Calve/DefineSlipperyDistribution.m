function [UserVar,C,m]=DefineSlipperyDistribution(UserVar,CtrlVar,MUA,time,s,b,h,S,B,rho,rhow,GF) 
% ScatteredInterpolated from inverse run
persistent AmeryF_C
m = 3;
if isempty(AmeryF_C)
    fprintf('Define Slipperiness Distribution: loading file: %-s ', UserVar.Inverse_AGlen_C)
    load(UserVar.Inverse_AGlen_C, 'AmeryF_C');
    fprintf(' done \n')
end
C = AmeryF_C(MUA.coordinates(:,1), MUA.coordinates(:,2));
end