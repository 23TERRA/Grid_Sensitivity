function [UserVar,C,m]=DefineSlipperyDistribution(UserVar,CtrlVar,MUA,time,s,b,h,S,B,rho,rhow,GF)
m=3;
%     C=0.0145300017528364;
%     C=C+zeros(MUA.Nnodes,1);
ub=100;
tau=80; 
% units meters, year, kPa
C = ub/tau^m;
end
