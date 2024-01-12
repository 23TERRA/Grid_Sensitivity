function [UserVar,s,b,S,B,alpha]=DefineGeometry(UserVar,CtrlVar,MUA,time,FieldsToBeDefined)
persistent AmerySurfaceBMAV3
persistent AmeryBedBMAV3 AmeryBedYang_BMAV3
persistent AmeryThicknessBMAV3
if nargin<5
    FieldsToBeDefined='sbSB';
end

fprintf('DefineGeometry %s \n', FieldsToBeDefined)
%%
if isempty(AmerySurfaceBMAV3) 
    %locdir=pwd;
    %AntarcticGlobalDataSets=getenv('AntarcticGlobalDataSets');
    %cd(AntarcticGlobalDataSets)
    fprintf('DefineGeometry: loading file: %-s ', UserVar.GeometryInterpolant)
    load(UserVar.GeometryInterpolant,'AmeryBedYang_BMAV3','AmerySurfaceBMAV3','AmeryBedBMAV3','AmeryThicknessBMAV3')
    fprintf(' done \n')
    %cd(locdir)
end
x=MUA.coordinates(:,1);
y=MUA.coordinates(:,2);
alpha=0 ;

if contains(FieldsToBeDefined,'S')
    S=x*0;
else
    S=NaN;
end

if contains(FieldsToBeDefined,'s')
    s=AmerySurfaceBMAV3(x,y);
else
    s=NaN;
end

b=NaN;
B=NaN;

if contains(FieldsToBeDefined,'b')  || contains(FieldsToBeDefined,'B')
    B = AmeryBedBMAV3(x, y);
    b = s - AmeryThicknessBMAV3(x, y);
    % Thickness = AmeryThicknessWQX(x, y);
    % make sure that interpolation errors don't create a situation where b<B
    I = b<B;
    b(I) = B(I);
%     UserVar.SurfaceVelocityInterpolant='C:\Users\TERRA\Documents\MATLAB\WQX\AmeryVelocityInterpolantWQX.mat';
%     load(UserVar.SurfaceVelocityInterpolant,'AmeryVelocityFu')
%     AmeryVX = AmeryVelocityFu(x,y);

%     figure, PlotMeshScalarVariable(CtrlVar, MUA, AmeryVX);
%     title('AmeryVX (m/yr)')
%     print(gcf, 'AmeryVX.png', '-dpng', '-r600');

%     %绘制散点图
%     scatter3(x(:),y(:),B(:),'o','filled');
%     hold on;
%     scatter3(x(:),y(:),Q(:),'^','filled');
% 
%     %计算插值误差
%     error=norm(B-Q,'fro')/norm(B,'fro');
%     fprintf('插值误差为%f\n',error);

%  figure, PlotMeshScalarVariable(CtrlVar, MUA, s);
%  title('AmerySurfaceBM2WQX (m)')
%  print(gcf, 'AmerySurfaceBM2WQX.png', '-dpng', '-r600');
% 
%  figure, PlotMeshScalarVariable(CtrlVar, MUA, b);
%  title('AmeryLowerSurfaceWQX (m)')
%  print(gcf, 'AmeryLowerSurfaceWQX.png', '-dpng', '-r600');
% 
%  figure, PlotMeshScalarVariable(CtrlVar, MUA, B);
%  title('AmeryBedWQX (m)')
%  print(gcf, 'AmeryBedWQX.png', '-dpng', '-r600');
% 
%  figure, PlotMeshScalarVariable(CtrlVar, MUA, Thickness);
%  title('AmeryThicknessWQX (m)')
%  print(gcf, 'AmeryThicknessWQX.png', '-dpng', '-r600');

    

end
end