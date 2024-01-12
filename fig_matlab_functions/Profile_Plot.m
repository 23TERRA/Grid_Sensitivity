% 读取数据
path = 'C:\Users\TERRA\Desktop\results';
path1 = 'C:\Users\TERRA\Documents\MATLAB\WQX\反演\网格敏感性实验\ADD_Experiment\不规则格网';
load(fullfile(path1, '不规则格网\IR-Inverse-UaOptimization-Nod3-I-Adjoint-Cga0k000010-Cgs0k010000-Aga0k000010-Ags0k010000-m3--logA-logC-.mat'),'MUA','GF','BCs','F');
load(fullfile(path1, '不规则格网\GroundingLines.mat'),'MUA','CtrlVar','xGL','yGL');
X1=load(fullfile(path1,'不规则格网\AmeryInverse_ub_vb.mat'));
X2=load(fullfile(path1,'2km\AmeryInverse_ub_vb.mat'));
X3=load(fullfile(path1,'4km\AmeryInverse_ub_vb.mat'));
X4=load(fullfile(path1,'5km\AmeryInverse_ub_vb.mat'));
X5=load(fullfile(path1,'8km\AmeryInverse_ub_vb.mat'));
X6=load(fullfile(path1,'10km\AmeryInverse_ub_vb.mat'));
X7=load(fullfile(path1,'16km\AmeryInverse_ub_vb.mat'));
X8=load(fullfile(path1,'20km\AmeryInverse_ub_vb.mat'));
X9=load(fullfile(path1,'25km\AmeryInverse_ub_vb.mat'));
X10=load(fullfile(path1,'30km\AmeryInverse_ub_vb.mat'));

%% 绘制流线

figure
set(gcf,'color','w','position',[500 200 650 600]);
PlotMuaMesh(CtrlVar,MUA);
xA=1450000;
yA=650000;
hold on
flowline(xA,yA,8000,'plotxy','color','c','LineWidth', 2);

% 
% xB=1910000;
% yB=897000;
% hold on
% flowline(xB,yB,8000,'plotxy','r');   %原本支流的流线

XX = ones(180000,1) * 2080;
YY = linspace(625, 840, 180000);
YY=YY';

hold on;
plot(XX, YY, 'color','y', 'LineWidth', 2);

AA=5832;
plot(xGL(1:AA)/CtrlVar.PlotXYscale,yGL(1:AA)/CtrlVar.PlotXYscale,'r','LineWidth',2);  %绘制主接地线
PlotMuaBoundary(CtrlVar,MUA,'k');
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
box on
print(gcf, fullfile(path, 'Mesh.png'), '-dpng', '-r1000');
% legend('Amery1Long','Amery1Tran','Location', 'southeast','fontsize',13);

%%
figure ;  
set(gcf,'color','w','position',[500 200 650 600]);
[lat,lon]=flowline(xA,yA,8000,'plotxy','r');
[x,y] = ll2ps(lat,lon);

% sfz = bedmachine_interp('surface',x,y);

% Calculate distance along the flowline in kilometers:
d = pathdistps(x,y,'km');

% 从流速场中提取流速值
ub_values1 = X1.AmeryUB(x, y);
vb_values1 = X1.AmeryVB(x, y);
speed1=sqrt(ub_values1.*ub_values1+vb_values1.*vb_values1);

ub_values2 = X2.AmeryUB(x, y);
vb_values2 = X2.AmeryVB(x, y);
speed2=sqrt(ub_values2.*ub_values2+vb_values2.*vb_values2);

ub_values3 = X3.AmeryUB(x, y);
vb_values3 = X3.AmeryVB(x, y);
speed3=sqrt(ub_values3.*ub_values3+vb_values3.*vb_values3);

ub_values4 = X4.AmeryUB(x, y);
vb_values4 = X4.AmeryVB(x, y);
speed4=sqrt(ub_values4.*ub_values4+vb_values4.*vb_values4);

ub_values5 = X5.AmeryUB(x, y);
vb_values5 = X5.AmeryVB(x, y);
speed5=sqrt(ub_values5.*ub_values5+vb_values5.*vb_values5);

ub_values6 = X6.AmeryUB(x, y);
vb_values6 = X6.AmeryVB(x, y);
speed6=sqrt(ub_values6.*ub_values6+vb_values6.*vb_values6);

ub_values7 = X7.AmeryUB(x, y);
vb_values7 = X7.AmeryVB(x, y);
speed7=sqrt(ub_values7.*ub_values7+vb_values7.*vb_values7);

ub_values8 = X8.AmeryUB(x, y);
vb_values8 = X8.AmeryVB(x, y);
speed8=sqrt(ub_values8.*ub_values8+vb_values8.*vb_values8);

ub_values9 = X9.AmeryUB(x, y);
vb_values9 = X9.AmeryVB(x, y);
speed9=sqrt(ub_values9.*ub_values9+vb_values9.*vb_values9);

ub_values10 = X10.AmeryUB(x, y);
vb_values10 = X10.AmeryVB(x, y);
speed10=sqrt(ub_values10.*ub_values10+vb_values10.*vb_values10);

figure
% 使用左侧竖轴绘制地形图
yyaxis left;
bedmachine_profile(x,y);
ylabel('Elevation (m)','FontSize', 15);
% plot(d, sfz, 'b', 'linewidth', 2, 'DisplayName', 'Surface Elevation');
% legend('-DynamicLegend'); % 创建动态图例


% 使用右侧竖轴绘制流速图
yyaxis right;

% 选择一种预定义的颜色映射
colormap_name = 'parula';

% 获取颜色映射中的颜色
cmap = colormap(colormap_name);
plot(d, speed10, 'color', cmap(round((9 / 9) * size(cmap, 1)), :), 'LineStyle','-', 'linewidth', 2,'Marker','none', 'DisplayName', '30 km');
plot(d, speed9, 'color', cmap(round((8 / 9) * size(cmap, 1)), :), 'LineStyle','-', 'linewidth', 2,'Marker','none', 'DisplayName', '25 km');
plot(d, speed8, 'color', cmap(round((7 / 9) * size(cmap, 1)), :), 'LineStyle','-', 'linewidth', 2,'Marker','none', 'DisplayName', '20 km');
plot(d, speed7, 'color', cmap(round((6 / 9) * size(cmap, 1)), :), 'LineStyle','-', 'linewidth', 2,'Marker','none', 'DisplayName', '16 km');
plot(d, speed6, 'color', cmap(round((5 / 9) * size(cmap, 1)), :), 'LineStyle','-', 'linewidth', 2,'Marker','none', 'DisplayName', '10 km');
plot(d, speed5, 'color', cmap(round((4 / 9) * size(cmap, 1)), :), 'LineStyle','-', 'linewidth', 2,'Marker','none', 'DisplayName', '8 km');
plot(d, speed4, 'color', cmap(round((3 / 9) * size(cmap, 1)), :), 'LineStyle','-', 'linewidth', 2,'Marker','none', 'DisplayName', '5 km');
plot(d, speed3, 'color', cmap(round((2 / 9) * size(cmap, 1)), :), 'LineStyle','-', 'linewidth', 2,'Marker','none', 'DisplayName', '4 km');
plot(d, speed2, 'color', cmap(round((1 / 9) * size(cmap, 1)), :), 'LineStyle','-', 'linewidth', 2,'Marker','none','DisplayName', '2 km');
plot(d, speed1, 'color', 'r', 'LineStyle','-','linewidth', 2,'DisplayName', 'Nonuniform');

ylabel('Flow velocity (m a^{-1})','FontSize', 15);
% 设置 x 轴标签
xlabel('Distance along the ice flow (km)','FontSize', 15);

% 标题
title('Along the ice flow', 'FontSize', 17); % 将字体大小设置为16

% set(gca, 'FontSize', 15,'fontname','time news roman'); % 将字体大小设置为12或你想要的大小
% set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% % 最终显示图例
% legend('show');
box on
print(gcf, fullfile(path, 'Profile.png'), '-dpng', '-r1000');

%%
figure
set(gcf,'color','w','position',[500 200 650 600]);
x=XX*1000; y=YY*1000;
% sfz = bedmachine_interp('surface',x,y);

% Calculate distance along the flowline in kilometers:
d = pathdistps(x,y,'km');

% 从流速场中提取流速值
ub_values1 = X1.AmeryUB(x, y);
vb_values1 = X1.AmeryVB(x, y);
speed1=sqrt(ub_values1.*ub_values1+vb_values1.*vb_values1);

ub_values2 = X2.AmeryUB(x, y);
vb_values2 = X2.AmeryVB(x, y);
speed2=sqrt(ub_values2.*ub_values2+vb_values2.*vb_values2);

ub_values3 = X3.AmeryUB(x, y);
vb_values3 = X3.AmeryVB(x, y);
speed3=sqrt(ub_values3.*ub_values3+vb_values3.*vb_values3);

ub_values4 = X4.AmeryUB(x, y);
vb_values4 = X4.AmeryVB(x, y);
speed4=sqrt(ub_values4.*ub_values4+vb_values4.*vb_values4);

ub_values5 = X5.AmeryUB(x, y);
vb_values5 = X5.AmeryVB(x, y);
speed5=sqrt(ub_values5.*ub_values5+vb_values5.*vb_values5);

ub_values6 = X6.AmeryUB(x, y);
vb_values6 = X6.AmeryVB(x, y);
speed6=sqrt(ub_values6.*ub_values6+vb_values6.*vb_values6);

ub_values7 = X7.AmeryUB(x, y);
vb_values7 = X7.AmeryVB(x, y);
speed7=sqrt(ub_values7.*ub_values7+vb_values7.*vb_values7);

ub_values8 = X8.AmeryUB(x, y);
vb_values8 = X8.AmeryVB(x, y);
speed8=sqrt(ub_values8.*ub_values8+vb_values8.*vb_values8);

ub_values9 = X9.AmeryUB(x, y);
vb_values9 = X9.AmeryVB(x, y);
speed9=sqrt(ub_values9.*ub_values9+vb_values9.*vb_values9);

ub_values10 = X10.AmeryUB(x, y);
vb_values10 = X10.AmeryVB(x, y);
speed10=sqrt(ub_values10.*ub_values10+vb_values10.*vb_values10);

figure
% 使用左侧竖轴绘制地形图

yyaxis left;
bedmachine_profile(x,y);
ylabel('Elevation (m)','FontSize', 15);
% plot(d, sfz, 'b', 'linewidth', 2, 'DisplayName', 'Surface Elevation');
% legend('-DynamicLegend'); % 创建动态图例


% 使用右侧竖轴绘制流速图
yyaxis right;

% 选择一种预定义的颜色映射
colormap_name = 'parula';

% 获取颜色映射中的颜色
cmap = colormap(colormap_name);

plot(d, speed10, 'color', cmap(round((9 / 9) * size(cmap, 1)), :), 'LineStyle','-', 'linewidth', 2,'Marker','none', 'DisplayName', '30 km');
plot(d, speed9, 'color', cmap(round((8 / 9) * size(cmap, 1)), :), 'LineStyle','-', 'linewidth', 2,'Marker','none', 'DisplayName', '25 km');
plot(d, speed8, 'color', cmap(round((7 / 9) * size(cmap, 1)), :), 'LineStyle','-', 'linewidth', 2,'Marker','none', 'DisplayName', '20 km');
plot(d, speed7, 'color', cmap(round((6 / 9) * size(cmap, 1)), :), 'LineStyle','-', 'linewidth', 2,'Marker','none', 'DisplayName', '16 km');
plot(d, speed6, 'color', cmap(round((5 / 9) * size(cmap, 1)), :), 'LineStyle','-', 'linewidth', 2,'Marker','none', 'DisplayName', '10 km');
plot(d, speed5, 'color', cmap(round((4 / 9) * size(cmap, 1)), :), 'LineStyle','-', 'linewidth', 2,'Marker','none', 'DisplayName', '8 km');
plot(d, speed4, 'color', cmap(round((3 / 9) * size(cmap, 1)), :), 'LineStyle','-', 'linewidth', 2,'Marker','none', 'DisplayName', '5 km');
plot(d, speed3, 'color', cmap(round((2 / 9) * size(cmap, 1)), :), 'LineStyle','-', 'linewidth', 2,'Marker','none', 'DisplayName', '4 km');
plot(d, speed2, 'color', cmap(round((1 / 9) * size(cmap, 1)), :), 'LineStyle','-', 'linewidth', 2,'Marker','none','DisplayName', '2 km');
plot(d, speed1, 'color', 'r', 'LineStyle','-','linewidth', 2,'DisplayName', 'Nonuniform');
ylabel('Flow velocity (m a^{-1})','FontSize', 15);

% 设置 x 轴标签
xlabel('Distance across the ice flow (km)','FontSize', 15);

% 标题
title('Across the ice flow', 'FontSize', 17); % 将字体大小设置为16

% % % 最终显示图例
% legend('show');


box on
print(gcf, fullfile(path, 'Transection.png'), '-dpng', '-r1000');
