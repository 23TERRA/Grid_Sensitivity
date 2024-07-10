function [UserVar,C,m]=DefineSlipperyDistribution(UserVar,CtrlVar,MUA,time,s,b,h,S,B,rho,rhow,GF)
m=3;
ub=100;
tau=80; 
C = ub/tau^m;
end
