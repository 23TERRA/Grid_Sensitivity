% 读取数据
path1 = 'E:\MATLAB\WQX\Project1\UnstructuredMesh';
path2 = 'E:\MATLAB\WQX\Project1\2km';
path3 = 'E:\MATLAB\WQX\Project1\4km';
path4 = 'E:\MATLAB\WQX\Project1\5km';
path5 = 'E:\MATLAB\WQX\Project1\8km';
path6 = 'E:\MATLAB\WQX\Project1\10km';
path7 = 'E:\MATLAB\WQX\Project1\16km';
path8 = 'E:\MATLAB\WQX\Project1\20km';
path9 = 'E:\MATLAB\WQX\Project1\25km';
path10 = 'E:\MATLAB\WQX\Project1\30km';
load(fullfile(path1, 'InverseRestart.mat'));
[~,GLgeo,~,~]=IceSheetIceShelves(CtrlVarInRestartFile,MUA,GF);
[xGL,yGL]=ArrangeGroundingLinePos(CtrlVarInRestartFile,GLgeo,1);

X1=load(fullfile(path1,'AmeryInverse_ub_vb.mat'));
X2=load(fullfile(path2,'AmeryInverse_ub_vb.mat'));
X3=load(fullfile(path3,'AmeryInverse_ub_vb.mat'));
X4=load(fullfile(path4,'AmeryInverse_ub_vb.mat'));
X5=load(fullfile(path5,'AmeryInverse_ub_vb.mat'));
X6=load(fullfile(path6,'AmeryInverse_ub_vb.mat'));
X7=load(fullfile(path7,'AmeryInverse_ub_vb.mat'));
X8=load(fullfile(path8,'AmeryInverse_ub_vb.mat'));
X9=load(fullfile(path9,'AmeryInverse_ub_vb.mat'));
X10=load(fullfile(path10,'AmeryInverse_ub_vb.mat'));
path = 'E:\MATLAB\WQX\Project1\出图代码\原图直出';
%%
load('flowline_bottom20240530.mat');
isf = isfinite(x) & isfinite(y);
x = x(isf);
y = y(isf);
x = x(:);
y = y(:);
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
Amerysurface = scatteredInterpolant(F.x, F.y, F.s);
Amerybed = scatteredInterpolant(F.x, F.y, F.B);
Amerythck = scatteredInterpolant(F.x, F.y, F.h);
set(gcf,'color','w','position',[500 200 850 600]);
waterface = [0.431, 0.840, 1];
bedface = [0.651, 0.447, 0.271];
iceface = [0.847,0.929,0.961];%[0.890, 0.902, 0.910];


iceedge = [0.4549    0.5922    0.5882];
wateredge = 'none';
bededge = 'none'; %[0.1137 0.0078      0];
sky = 'w';

% Line widths:
iceedgewidth = 1;
wateredgewidth = 1;
bededgewidth = 1;

sfz = Amerysurface(x,y);
bed = Amerybed(x,y);
thck = Amerythck(x,y);

sfz(isnan(sfz))=0;
thck(isnan(thck)) = 0;
icebottom = sfz-thck;

% Some vertical limits:
maxsfz = max(sfz(isfinite(sfz)));
if isempty(maxsfz)
    maxsfz = 0;
end
minbed = min(bed(isfinite(bed)));
padding = (maxsfz-minbed)/20;

horizax = pathdistps(x,y,'km');

% Draw water:
hwater=fill([horizax(1);horizax(end);horizax(end);horizax(1)],[0;0;minbed-padding;minbed-padding],waterface,'DisplayName', 'Ocean Water');
set(hwater,'edgecolor',wateredge,'linewidth',wateredgewidth);
% area_water=polyarea([horizax(1);horizax(end);horizax(end);horizax(1)],[0;0;minbed-padding;minbed-padding])/1000;
hold on;

% Draw bed:
realbed = find(isfinite(bed));
hbed = fill([horizax(realbed);horizax(realbed(length(realbed)));horizax(realbed(1))],[bed(realbed);minbed-padding;minbed-padding],bedface,'DisplayName', 'Bedrock');
set(hbed,'edgecolor',bededge,'linewidth',bededgewidth)
% area_bed = polyarea([horizax(realbed);horizax(realbed(length(realbed)));horizax(realbed(1))],[bed(realbed);minbed-padding;minbed-padding])/1000;
% Draw ice:
hice = patch([horizax;flipud(horizax)],[sfz;flipud(icebottom)],iceface,'DisplayName', 'Ice');
set(hice,'edgecolor',iceedge,'linewidth',iceedgewidth);

Oceanwater = polyarea([horizax;flipud(horizax)],[icebottom;flipud(bed)])/1000;
GL_Length=horizax(end);
axis tight;
box off;
xlim([0,800]);ylim([-3300,2500]);
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
plot(d, speed1, 'color', 'r', 'LineStyle','-','linewidth', 2,'DisplayName', 'Unstructured');

ylabel('Flow velocity (m a^{-1})','FontSize', 15);
% 设置 x 轴标签
xlabel('Distance along the ice flow (km)','FontSize', 15);
ylim([0,1200]);
% 标题
title('Along the ice flow', 'FontSize', 17); % 将字体大小设置为16

set(gca, 'FontSize', 15,'fontname','time news roman'); % 将字体大小设置为12或你想要的大小
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% % 最终显示图例
legend('show');
set(legend,...
    'Position',[0.170588235294117 0.786388888888889 0.709411764705882 0.121666666666667],...
    'NumColumns',5);
box on
print(gcf, fullfile(path, 'Profile.png'), '-dpng', '-r1000');

%%
XX = linspace(2043.19, 2124.66, 180000);
YY = linspace(623.003, 831.511, 180000);
XX=XX';YY=YY';
x=XX*1000; y=YY*1000;
isf = isfinite(x) & isfinite(y);
x = x(isf);
y = y(isf);
x = x(:);
y = y(:);
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
Amerysurface = scatteredInterpolant(F.x, F.y, F.s);
Amerybed = scatteredInterpolant(F.x, F.y, F.B);
Amerythck = scatteredInterpolant(F.x, F.y, F.h);
set(gcf,'color','w','position',[500 200 850 600]);
waterface = [0.431, 0.840, 1];
bedface = [0.651, 0.447, 0.271];
iceface = [0.847,0.929,0.961];%[0.890, 0.902, 0.910];


iceedge = [0.4549    0.5922    0.5882];
wateredge = 'none';
bededge = 'none'; %[0.1137 0.0078      0];
sky = 'w';

% Line widths:
iceedgewidth = 1;
wateredgewidth = 1;
bededgewidth = 1;

sfz = Amerysurface(x,y);
bed = Amerybed(x,y);
thck = Amerythck(x,y);

sfz(isnan(sfz))=0;
thck(isnan(thck)) = 0;
icebottom = sfz-thck;

% Some vertical limits:
maxsfz = max(sfz(isfinite(sfz)));
if isempty(maxsfz)
    maxsfz = 0;
end
minbed = min(bed(isfinite(bed)));
padding = (maxsfz-minbed)/20;

horizax = pathdistps(x,y,'km');

% Draw water:
hwater=fill([horizax(1);horizax(end);horizax(end);horizax(1)],[0;0;minbed-padding;minbed-padding],waterface,'DisplayName', 'Ocean Water');
set(hwater,'edgecolor',wateredge,'linewidth',wateredgewidth);
% area_water=polyarea([horizax(1);horizax(end);horizax(end);horizax(1)],[0;0;minbed-padding;minbed-padding])/1000;
hold on;

% Draw bed:
realbed = find(isfinite(bed));
hbed = fill([horizax(realbed);horizax(realbed(length(realbed)));horizax(realbed(1))],[bed(realbed);minbed-padding;minbed-padding],bedface,'DisplayName', 'Bedrock');
set(hbed,'edgecolor',bededge,'linewidth',bededgewidth)
% area_bed = polyarea([horizax(realbed);horizax(realbed(length(realbed)));horizax(realbed(1))],[bed(realbed);minbed-padding;minbed-padding])/1000;
% Draw ice:
hice = patch([horizax;flipud(horizax)],[sfz;flipud(icebottom)],iceface,'DisplayName', 'Ice');
set(hice,'edgecolor',iceedge,'linewidth',iceedgewidth);

Oceanwater = polyarea([horizax;flipud(horizax)],[icebottom;flipud(bed)])/1000;
GL_Length=horizax(end);
axis tight;
box off;
xlim([0,220]);ylim([-1380,650]);
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
plot(d, speed1, 'color', 'r', 'LineStyle','-','linewidth', 2,'DisplayName', 'Unstructured');
ylabel('Flow velocity (m a^{-1})','FontSize', 15);

% 设置 x 轴标签
xlabel('Distance across the ice flow (km)','FontSize', 15);
ylim([0,800]);
xticks(0:20:220);
% 标题
title('Across the ice flow', 'FontSize', 17); % 将字体大小设置为16
set(gca, 'FontSize', 15,'fontname','time news roman'); % 将字体大小设置为12或你想要的大小
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% % % 最终显示图例
legend('show');
set(legend,...
    'Position',[0.169803921568627 0.784166666666666 0.709411764705882 0.121666666666666],...
    'NumColumns',5);
box on
print(gcf, fullfile(path, 'Transection.png'), '-dpng', '-r1000');
