path = 'C:\Users\TERRA\Documents\MATLAB\WQX\反演\网格敏感性实验\ADD_Experiment\不规则格网';
path1= 'C:\Users\TERRA\Desktop\results';
X=load(fullfile(path, 'AmeryObserve_ub_vb.mat'));
OBub=X.AmeryUBO.Values;
OBvb=X.AmeryVBO.Values;

Y=load(fullfile(path, 'AmeryInverse_ub_vb.mat'));
Inverseub=Y.AmeryUB.Values;
Inversevb=Y.AmeryVB.Values;

load(fullfile(path, 'GroundingLines.mat'),'CtrlVar','MUA','GF','yGL','xGL');

% WQXA=OBub-Inverseub;
% WQXB=OBvb-Inversevb;
% % WQXA=OBub;
% % WQXB=OBvb;
% % WQXA=Inverseub;
% % WQXB=Inversevb;
% speed=sqrt(WQXA.*WQXA+WQXB.*WQXB);
% CtrlVar.MinPlottedSpeed=0;
% CtrlVar.MaxPlottedSpeed=max(speed);
% CtrlVar.VelPlotIntervalSpacing='log10';
% CtrlVar.RelativeVelArrowSize=3;
% N=1;
% x=MUA.coordinates(:,1);  y=MUA.coordinates(:,2);
% % 绘制流速有效值在0-1500范围内的箭头  %20230424这里最大值才768
% % valid_idx = find(speed >= 0 & speed <= 1500);
% % QuiverColorGHG(x(valid_idx(1:N:end)),y(valid_idx(1:N:end)),ub(valid_idx(1:N:end)),vb(valid_idx(1:N:end)),CtrlVar);
% QuiverColorGHG(x(1:N:end),y(1:N:end),WQXA(1:N:end),WQXB(1:N:end),CtrlVar);
% 
% hold on;
% [xGL,yGL,GLgeo]=PlotGroundingLines(CtrlVar,MUA,GF,GLgeo,xGL,yGL,'k');
% PlotMuaBoundary(CtrlVar,MUA,'b')
% title(sprintf('(ub,vb)观测-模拟差值 t=%-g ',CtrlVar.time)) ; xlabel('x (km)') ; ylabel('y (km)')
% print(gcf, '观测-模拟差值.png', '-dpng', '-r600');
% % title(sprintf('(ub,vb)观测 t=%-g ',CtrlVar.time)) ; xlabel('x (km)') ; ylabel('y (km)')
% % print(gcf, '观测.png', '-dpng', '-r600');
% % title(sprintf('(ub,vb)模拟 t=%-g ',CtrlVar.time)) ; xlabel('x (km)') ; ylabel('y (km)')
% % print(gcf, '模拟.png', '-dpng', '-r600');

%% 20230831 标量流速差值绘制

Ob_speed=sqrt(OBub.*OBub+OBvb.*OBvb);
Invers_speed=sqrt(Inverseub.*Inverseub+Inversevb.*Inversevb);
C=Invers_speed-Ob_speed;
figure
set(gcf,'color','w','position',[500 200 650 600]);
PlotMeshScalarVariable(CtrlVar,MUA,C);
hold on
% AA=5832;
% plot(xGL(1:AA)/CtrlVar.PlotXYscale,yGL(1:AA)/CtrlVar.PlotXYscale,'k','LineWidth',2) ;  %绘制主接地线
AA=5832;
plot(xGL(1:AA)/CtrlVar.PlotXYscale,yGL(1:AA)/CtrlVar.PlotXYscale,'k','LineWidth',2) ;  %绘制主接地线
PlotMuaBoundary(CtrlVar,MUA,'k');
% title('log10(C)' ); xlabel('x (km)') ; ylabel('y (km)')
% title(colorbar,'log_{10}(m yr^{-1})')
xlabel('xps (km)','FontSize', 15,'fontname','time news roman')
ylabel('yps (km)','FontSize', 15,'fontname','time news roman')
% 将 colorbar 放在新的绘图区域中
% colormap jet; % 设置颜色映射
% caxis([-150 150]); % 设置颜色映射范围

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
% box on
% print(gcf, fullfile(path1, '反演-观测流速.png'), '-dpng', '-r1000');

%% 20230902 流速矢量绘制

Ob_speed=sqrt(OBub.*OBub+OBvb.*OBvb);
Invers_speed=sqrt(Inverseub.*Inverseub+Inversevb.*Inversevb);
C=Invers_speed;
figure
set(gcf,'color','w','position',[500 200 650 600]);
PlotMeshScalarVariable(CtrlVar,MUA,log10(C));
hold on
AA=5832;
plot(xGL(1:AA)/CtrlVar.PlotXYscale,yGL(1:AA)/CtrlVar.PlotXYscale,'k','LineWidth',2) ;  %绘制主接地线
PlotMuaBoundary(CtrlVar,MUA,'k')
% title('log10(C)' ); xlabel('x (km)') ; ylabel('y (km)')
% title(colorbar,'log_{10}(m yr^{-1})')
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
PlotMeshScalarVariable(CtrlVar,MUA,log10(C));
hold on
AA=5832;
plot(xGL(1:AA)/CtrlVar.PlotXYscale,yGL(1:AA)/CtrlVar.PlotXYscale,'k','LineWidth',2) ;  %绘制主接地线
PlotMuaBoundary(CtrlVar,MUA,'k')
% title('log10(C)' ); xlabel('x (km)') ; ylabel('y (km)')
% title(colorbar,'log_{10}(m yr^{-1})')
xlabel('xps (km)','FontSize', 15,'fontname','time news roman')
ylabel('yps (km)','FontSize', 15,'fontname','time news roman')
% 将 colorbar 放在新的绘图区域中
set(gca, 'FontSize', 15,'fontname','time news roman'); % 将字体大小设置为12或你想要的大小
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
title(colorbar, 'log(Speed)\newline/(m a^{-1})', 'FontSize', 15)

caxis([-4, 4]);
box on
print(gcf, fullfile(path1, '观测流速.png'), '-dpng', '-r1000');

% % 没什么太大的意义
% % C=Invers_speed-Ob_speed;
% % C=abs(C);
% % figure
% % PlotMeshScalarVariable(CtrlVar,MUA,log10(C));
% % hold on
% % GLgeo=GLgeometry(MUA.connectivity,MUA.coordinates,GF,CtrlVar);
% % [xGL,yGL,GLgeo]=PlotGroundingLines(CtrlVar,MUA,GF,GLgeo,xGL,yGL,'r');
% % PlotMuaBoundary(CtrlVar,MUA,'k')
% % % title('log10(C)' ); xlabel('x (km)') ; ylabel('y (km)')
% % % title(colorbar,'log_{10}(m yr^{-1})')
% % title('log10(反演流速-观测流速)','FontSize',20 ); xlabel('x (km)') ; ylabel('y (km)')
% % title(colorbar,'m yr^{-1}')
% % caxis([-4, 4]);

