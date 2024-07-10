function RunUa(varargin)

% parpool(1);

UserVar.CalvingDistance=varargin{1}*1000;
CtrlVar.NameOfRestartFiletoWrite=sprintf('Calving-Any-%03ikm-Restart.mat',UserVar.CalvingDistance/1000);
    
% Call Ua with the inputs given
Ua(UserVar,CtrlVar);

end
