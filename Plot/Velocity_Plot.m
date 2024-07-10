% x=MUA.coordinates(:,1);  y=MUA.coordinates(:,2);
% AmeryUB = scatteredInterpolant(x, y, F.ub);
% AmeryVB = scatteredInterpolant(x, y, F.vb);
% save_name = 'AmeryInverse_ub_vb.mat';
% save(save_name, 'AmeryUB', 'AmeryVB');
%%
path='E:\MATLAB\WQX\Project1\UnstructuredMesh';
path1= 'E:\MATLAB\WQX\Project1\出图代码\原图直出';
load(fullfile(path, 'InverseRestart.mat'))
X=load(fullfile(path, 'AmeryObserve_ub_vb.mat'));
OBub=X.AmeryUBO.Values;
OBvb=X.AmeryVBO.Values;

Y=load(fullfile(path, 'AmeryInverse_ub_vb.mat'));
Inverseub=Y.AmeryUB.Values;
Inversevb=Y.AmeryVB.Values;

%% 20230831 标量流速差值绘制

Ob_speed=sqrt(OBub.*OBub+OBvb.*OBvb);
Invers_speed=sqrt(Inverseub.*Inverseub+Inversevb.*Inversevb);
C=Invers_speed-Ob_speed;
figure
set(gcf,'color','w','position',[500 200 650 600]);
PlotMeshScalarVariable(CtrlVarInRestartFile,MUA,C);
hold on
[GF,GLgeo,~,~]=IceSheetIceShelves(CtrlVarInRestartFile,MUA,GF);
[xGL,yGL]=ArrangeGroundingLinePos(CtrlVarInRestartFile,GLgeo,1);
plot(xGL/CtrlVarInRestartFile.PlotXYscale,yGL/CtrlVarInRestartFile.PlotXYscale,'k','LineWidth',2) ;  %绘制主接地线
hold on
PlotMuaBoundary(CtrlVarInRestartFile,MUA,'k');
xlabel('xps (km)','FontSize', 15,'fontname','time news roman')
ylabel('yps (km)','FontSize', 15,'fontname','time news roman')

% 定义自定义颜色映射
num_colors = 256; % 颜色数量

% 创建自定义颜色映射
cmap = zeros(num_colors, 3);

% 定义渐变的三个阶段的颜色
blue_color = [0, 0, 1];
white_color = [1, 1, 1];
red_color = [1, 0, 0];

% 计算每个阶段的颜色数量
blue_to_white = round(num_colors / 2);
white_to_red = num_colors - blue_to_white;

for i = 1:num_colors
    if i <= blue_to_white
        % 在蓝色到白色之间渐变
        t = (i - 1) / (blue_to_white - 1);
        cmap(i, :) = (1 - t) * blue_color + t * white_color;
    else
        % 在白色到红色之间渐变
        t = (i - blue_to_white - 1) / (white_to_red - 1);
        cmap(i, :) = (1 - t) * white_color + t * red_color;
    end
end

% 设置颜色映射
colormap(cmap);

% 设置颜色映射范围
caxis([-150, 150]);

h = colorbar;
ylabel(h, 'Speed (m a^{-1})','FontSize', 15);
set(gca, 'FontSize', 15,'fontname','time news roman'); % 将字体大小设置为12或你想要的大小
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
box on
print(gcf, fullfile(path1, '反演-观测流速.png'), '-dpng', '-r1000');

%% 20230902 流速矢量绘制

Ob_speed=sqrt(OBub.*OBub+OBvb.*OBvb);
Invers_speed=sqrt(Inverseub.*Inverseub+Inversevb.*Inversevb);
C=Invers_speed;
figure
set(gcf,'color','w','position',[500 200 650 600]);
PlotMeshScalarVariable(CtrlVarInRestartFile,MUA,log10(C));
hold on
[GF,GLgeo,~,~]=IceSheetIceShelves(CtrlVarInRestartFile,MUA,GF);
[xGL,yGL]=ArrangeGroundingLinePos(CtrlVarInRestartFile,GLgeo,1);
plot(xGL/CtrlVarInRestartFile.PlotXYscale,yGL/CtrlVarInRestartFile.PlotXYscale,'k','LineWidth',2) ;  %绘制主接地线
hold on
PlotMuaBoundary(CtrlVarInRestartFile,MUA,'k');
xlabel('xps (km)','FontSize', 15,'fontname','time news roman')
ylabel('yps (km)','FontSize', 15,'fontname','time news roman')
% 将 colorbar 放在新的绘图区域中
set(gca, 'FontSize', 15,'fontname','time news roman'); % 将字体大小设置为12或你想要的大小
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
title(colorbar, 'log(Speed)\newline/(m a^{-1})', 'FontSize', 15)

caxis([-4, 4]);
box on
print(gcf, fullfile(path1, '反演流速.png'), '-dpng', '-r1000');

C=Ob_speed;
figure
set(gcf,'color','w','position',[500 200 650 600]);
PlotMeshScalarVariable(CtrlVarInRestartFile,MUA,log10(C));
hold on
[GF,GLgeo,~,~]=IceSheetIceShelves(CtrlVarInRestartFile,MUA,GF);
[xGL,yGL]=ArrangeGroundingLinePos(CtrlVarInRestartFile,GLgeo,1);
plot(xGL/CtrlVarInRestartFile.PlotXYscale,yGL/CtrlVarInRestartFile.PlotXYscale,'k','LineWidth',2) ;  %绘制主接地线
hold on
PlotMuaBoundary(CtrlVarInRestartFile,MUA,'k');
xlabel('xps (km)','FontSize', 15,'fontname','time news roman')
ylabel('yps (km)','FontSize', 15,'fontname','time news roman')
% 将 colorbar 放在新的绘图区域中
set(gca, 'FontSize', 15,'fontname','time news roman'); % 将字体大小设置为12或你想要的大小
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
title(colorbar, 'log(Speed)\newline/(m a^{-1})', 'FontSize', 15)

caxis([-4, 4]);
box on
print(gcf, fullfile(path1, '观测流速.png'), '-dpng', '-r1000');
