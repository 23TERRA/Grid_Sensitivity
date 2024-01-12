function [UserVar,AGlen,n]=DefineAGlenDistribution(UserVar, CtrlVar, MUA, time, s, b,h,S,B,rho,rhow,GF)
n = 3;
% kPa year about -10 degrees Celcius
AGlen = AGlenVersusTemp(-10) + zeros(MUA.Nnodes, 1);  % AGlen 是 Glen流动规律中的常数
%AGlen = A_0 * exp(-Q/(R*T)) 阿伦尼乌斯定律 其中，A_0、Q、R分别是与冰性质相关的常数。该函数的输入为温度（单位为°C），输出为AGlen的值（单位为Pa^{-3} year^{-1}）。
end