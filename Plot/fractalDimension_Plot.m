custom_colors = [
    0.2, 0.3, 0.8;    % 鲜艳的蓝色
    0.8, 0.4, 0.2;    % 鲜艳的橙色
    0.4, 0.6, 0.3;    % 鲜艳的绿色

    0.6, 0.2, 0.8;    % 紫色
    0.3, 0.8, 0.4;    % 青色
    0.8, 0.6, 0.2;    % 橙色

    0.5, 0.5, 0.5;    % 中性灰色
    0.3, 0.3, 0.3;    % 深灰色
    0.9, 0.9, 0.2;    % 亮黄色
    0.1, 0.6, 0.5;    % 海蓝色
];
boxSizes = 2.^(1:9);
logSizes = log2(boxSizes);
km30 = [0.0636,0.0562,0.0370,0.0091,0.0760,0.4557,0.9610,1.2925,1.3315];
km25 = [0.0850,0.0515,0.0245,0.0348,0.1884,0.5620,0.8721,1.2390,1.3685];
km20 = [0.0774,0.0119,0.0135,0.0370,0.1477,0.7203,1.0336,1.1962,1.4037];
km16 = [0.0623,0.0289,0.0524,0.0387,0.3570,0.8602,1.0769,1.2297,1.3685];
km10 = [0.0135,0.0217,0.0245,0.1912,0.7290,1.0796,1.0888,1.1610,1.4037];
km8 = [0.0541,0.0331,0.0437,0.3725,0.9078,1.1376,1.1258,1.1448,1.4037];
km5 = [0.0191,0.0131,0.1946,0.6603,1.0251,1.1912,1.1185,1.1962,1.4037];
km4 = [0.0801,0.0205,0.2738,0.9158,1.0186,1.1644,1.1610,1.1962,1.4037];
km2 = [0.0108,0.3688,0.8639,1.0141,1.0349,1.1643,1.1678,1.2131,1.4037];
kmMEaSUREs = [0.0397,0.1195,0.4096,0.6864,0.8421,1.1075,1.1823,1.1962,1.3685];
kmUnstructured = [0.3656,0.8459,1.0043,1.0483,1.0826,1.1775,1.1471,1.1282,1.4037];
figure
set(gcf,'color','w','position',[-2183.666666666667,-159.6666666666667,992.0000000000002,838]); 
plot(logSizes, km30,'Color',custom_colors(1,:), 'LineWidth', 2,'LineStyle','-','Marker','o');
hold on
plot(logSizes, km25,'Color',custom_colors(2,:), 'LineWidth', 2,'LineStyle','-','Marker','+');
hold on
plot(logSizes, km20,'Color',custom_colors(3,:), 'LineWidth', 2,'LineStyle','-','Marker','o');
hold on
plot(logSizes, km16,'Color',custom_colors(4,:), 'LineWidth', 2,'LineStyle','-','Marker','+');
hold on
plot(logSizes, km10,'Color',custom_colors(5,:), 'LineWidth', 2,'LineStyle','-','Marker','o');
hold on
plot(logSizes, km8,'Color',custom_colors(6,:), 'LineWidth', 2,'LineStyle','-','Marker','+');
hold on
plot(logSizes, km5,'Color',custom_colors(7,:), 'LineWidth', 2,'LineStyle','-','Marker','o');
hold on
plot(logSizes, km4,'Color',custom_colors(8,:), 'LineWidth', 2,'LineStyle','-','Marker','+');
hold on
plot(logSizes, km2,'Color',custom_colors(9,:), 'LineWidth', 2,'LineStyle','-','Marker','o');
hold on
plot(logSizes, kmMEaSUREs,'Color',custom_colors(10,:), 'LineWidth', 2,'LineStyle','-','Marker','diamond');
hold on
plot(logSizes, kmUnstructured,'r', 'LineWidth', 2,'LineStyle','-','Marker','*');
xlabel('log_{2} Box scale','Interpreter','tex','fontsize',15);
ylabel('Fractal dimension','Interpreter','tex','fontsize',15);
ylim([0,1.5]);
yticks(0:0.3:1.5);
legend('30km','25km','20km','16km','10km', '8km','5km','4km','2km','MEaSUREs Antarctica v2','Unstructured', 'northwest','fontsize',15);
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
set(legend,...
    'Position',[0.15070564516129 0.722653142402546 0.38239247311828 0.189140811455847],...
    'NumColumns',2,...
    'FontSize',15);
grid on;
path = 'E:\MATLAB\WQX\Inversion\20240610';
print(gcf, fullfile(path, '分形维数PLUS.png'), '-dpng', '-r1000');

%%
path = 'E:\MATLAB\WQX\Project1\出图代码\原图直出';
x = [2, 4, 5, 8, 10,16,20,25,30]; % 网格分辨率
% y = [0.9620,0.7879,0.7223,0.5969,0.5223,0.3847,0.3173,0.2587,0.2200];
y = [0.9441,0.7790,0.7131,0.5999,0.5253,0.3934,0.3699,0.2758,0.2441];
figure
set(gcf,'color','w','position',[500 200 650 600]); 
x=x';
y=y';  
[p, s] = polyfit(x, y, 1);
scatter(x, y, 100, 'b', 'filled'); % 'b'代表蓝色，'filled'填充点 
x = linspace(0, 32, 100);
x=x';
y1 = polyval(p, x);
[yfit, dy] = polyconf(p, x, s, 'predopt', 'curve');
hold on;
plot(x, y1, 'r', 'LineWidth', 2);


hold on;
y_line = 1.0511; % 不规则格网的Mean_diff值
plot([0, 50], [y_line, y_line], 'k--', 'LineWidth', 2);
hold on;
y_line2 = 0.7314; % 不规则格网的Mean_diff值
plot([0, 50], [y_line2, y_line2], 'r--', 'LineWidth', 2);
hold on;
patch([x; flipud(x)], [yfit - dy; flipud(yfit + dy)],[0.8, 0.8, 0.8], 'EdgeColor', 'none', 'FaceAlpha', 0.25);

% 设置坐标轴范围
xlim([0,32]);
ylim([0,1.45]);
set(gca,'xtick',[0 2 4 5 8 10 16 20 25 30]);
% ylim([375000,378500]);
% 添加标签和标题
xlabel('Grid size (km)','fontsize',15);
ylabel('Fractal dimension','Interpreter','tex','fontsize',15);
% ylabel('VAF (Gt{\cdot}a^{-1})','fontsize',15);
% 添加图例
legend('Structured grids', 'Robust fit','Unstructured grids','MEaSUREs Antarctica v2', 'Location', 'northwest','fontsize',15);
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% 显示图形
grid on;

box on
print(gcf, fullfile(path, '分形维数.png'), '-dpng', '-r1000');

