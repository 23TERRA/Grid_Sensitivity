% 20181209 copied and modified from ../Example/PIG-TWG
function  [UserVar,rho,rhow,g]=DefineDensities(UserVar,CtrlVar,MUA,time,s,b,h,S,B)
% persistent Fr
% if isempty(Fr)
%     fprintf('DefineIceDensity: loading file: %-s ',UserVar.DensityInterpolant)
%     load(UserVar.DensityInterpolant,'Fr')
%     fprintf(' done \n')
% end
% ice/firn density: kg/m3
% rho=Fr(MUA.coordinates(:,1), MUA.coordinates(:,2));
rho=910;

% water density: kg/m3
rhow=1028;
% gravitational acceleration
g=9.81/1000;

end