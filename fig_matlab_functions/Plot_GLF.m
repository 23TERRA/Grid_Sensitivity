path = 'C:\Users\TERRA\Desktop\results';
% 定义网格分辨率和GLF值
resolutions = [2, 4, 5, 8, 10,16,20,25,30]; % 网格分辨率
glf_values = [71.3412,79.4827,80.1177,76.4124,82.5720,83.5626,83.4557,79.1898,79.7492]; % GLF值   不规则格网70.0665   1km 71.2734

figure
set(gcf,'color','w','position',[500 200 650 600]);
% 绘制散点图
scatter(resolutions, glf_values, 100, 'b', 'filled'); % 'b'代表蓝色，'filled'填充点

% % 拟合曲线（这里使用二次多项式）
% p = polyfit(resolutions, glf_values, 1); % 3表示3次多项式拟合
% 
% % 生成拟合曲线的x值范围
% x_fit = linspace(0, 50, 100);
% 
% % 计算拟合曲线的y值
% y_fit = polyval(p, x_fit);


% 拟合曲线（这里使用robustfit）
[b, stats] = robustfit(resolutions, glf_values);
% 生成拟合曲线的x值范围
x_fit = linspace(0, 32, 100);
% 计算拟合曲线的y值
y_fit = b(1) + b(2) * x_fit;
% 计算拟合误差
se = stats.se;

% 绘制拟合曲线
hold on;
plot(x_fit, y_fit, 'r', 'LineWidth', 2);

hold on;
y_line = 70.4268; % 不规则格网的GLF值
plot([0, 50], [y_line, y_line], 'k--', 'LineWidth', 2);

% % 添加灰影区域（观测区间） ,'Obs (Rignot et al.,2019)'
y_lower = 77.4 - 3.6; % 下限
y_upper = 77.4 + 3.6; % 上限
x_fill = [0, 50, 50, 0];
y_fill1 = [y_lower, y_lower, y_upper, y_upper];
% % 使用RGB颜色表示灰色，FaceAlpha设置透明度
patch(x_fill, y_fill1, [0.8, 0.8, 0.8], 'FaceAlpha', 0.3, 'EdgeColor', 'none');

% 添加灰影区域（观测区间）
y_lower2 = 61 - 5; % 下限
y_upper2 = 61 + 5; % 上限
y_fill2 = [y_lower2, y_lower2, y_upper2, y_upper2];
% 使用RGB颜色表示灰色，FaceAlpha设置透明度
patch(x_fill, y_fill2, [0.8, 0.8, 0.8], 'FaceAlpha', 0.7, 'EdgeColor', 'none');

% 设置坐标轴范围
xlim([0,32]);
set(gca,'xtick',[0 2 4 5 8 10 16 20 25 30]);
ylim([55, 98]);

% 添加标签和标题
xlabel('Grid size (km)','fontsize',15);
ylabel('GLF (Gt a^{-1})','fontsize',15);
% % % 绘制拟合误差阴影
% fill([x_fit, fliplr(x_fit)], [y_fit + se, fliplr(y_fit - se)], [0.8, 0.8, 0.8], 'FaceAlpha', 0.25, 'EdgeColor', 'none');

% 添加图例
legend('Uniform grids', 'Robust fit','Nonuniform grids','Obs (Rignot et al., 2019)','Obs (Zhou et al., 2019)', 'Location', 'NorthWest','fontsize',15);
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% 显示图形
grid on;

box on
print(gcf, fullfile(path, 'GLF.png'), '-dpng', '-r1000');
%%
path = 'C:\Users\TERRA\Desktop\results';
% 定义网格分辨率和GLF值
resolutions = [2, 4, 5, 8, 10,16,20,25,30]; % 网格分辨率

glf_values = [0.5614,4.0548,1.5710,3.9205,14.3715,5.0297,8.2024,0.3957,1.8969];

figure
set(gcf,'color','w','position',[500 200 650 600]);
% 绘制散点图
scatter(resolutions, glf_values, 100, 'b', 'filled'); % 'b'代表蓝色，'filled'填充点

% % 拟合曲线（这里使用二次多项式）
% p = polyfit(resolutions, glf_values, 1); % 3表示3次多项式拟合
% 
% % 生成拟合曲线的x值范围
% x_fit = linspace(0, 50, 100);
% 
% % 计算拟合曲线的y值
% y_fit = polyval(p, x_fit);

hold on;
y_line = 0.6910; % 不规则格网的GLF值
plot([0, 50], [y_line, y_line], 'k--', 'LineWidth', 2);

% 设置坐标轴范围
xlim([0,32]);
set(gca,'xtick',[0 2 4 5 8 10 16 20 25 30]);
ylim([0, 10]);

% 添加标签和标题
xlabel('Grid size (km)','fontsize',15);
ylabel('Relative error of initial GLF to final GLF','fontsize',15);
% % % 绘制拟合误差阴影
% fill([x_fit, fliplr(x_fit)], [y_fit + se, fliplr(y_fit - se)], [0.8, 0.8, 0.8], 'FaceAlpha', 0.25, 'EdgeColor', 'none');

% 添加图例
legend('Uniform grids','Nonuniform grids', 'Location', 'NorthWest','fontsize',15);
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% 显示图形
grid on;

box on
print(gcf, fullfile(path, 'GLFerror.png'), '-dpng', '-r1000');

%%
path = 'C:\Users\TERRA\Desktop\results';
% 定义网格分辨率和GLF值
resolutions = [2, 4, 5, 8, 10,16,20,25,30]; % 网格分辨率
glf_values = [71.3412,79.4827,80.1177,76.4124,82.5720,83.5626,83.4557,79.1898,79.7492]; % GLF值   不规则格网70.0665   1km 71.2734

figure
set(gcf,'color','w','position',[500 200 650 600]);
% 绘制散点图
scatter(resolutions, glf_values, 100, 'b', 'filled'); % 'b'代表蓝色，'filled'填充点

% 拟合曲线（这里使用二次多项式）
p = polyfit(resolutions, glf_values, 1); % 3表示3次多项式拟合

% 生成拟合曲线的x值范围
x_fit = linspace(0, 50, 100);

% 计算拟合曲线的y值
y_fit = polyval(p, x_fit);

% 绘制拟合曲线
hold on;
plot(x_fit, y_fit, 'r', 'LineWidth', 2);

hold on;
y_line = 70.4268; % 不规则格网的GLF值
plot([0, 50], [y_line, y_line], 'k--', 'LineWidth', 2);

% 添加灰影区域（观测区间）
y_lower = 77.4 - 3.6; % 下限
y_upper = 77.4 + 3.6; % 上限
x_fill = [0, 50, 50, 0];
y_fill = [y_lower, y_lower, y_upper, y_upper];
% 使用RGB颜色表示灰色，FaceAlpha设置透明度
patch(x_fill, y_fill, [0.8, 0.8, 0.8], 'FaceAlpha', 0.5, 'EdgeColor', 'none');



% 设置坐标轴范围
xlim([0,32]);
set(gca,'xtick',[0 2 4 5 8 10 16 20 25 30]);
ylim([68, 93]);

% 添加标签和标题
xlabel('Grid size (km)','fontsize',15);
ylabel('GLF (Gt a^{-1})','fontsize',15);

% 添加图例
legend('Uniform grids', 'Fitted line','Nonuniform grids','Obs (Rignot et al.,2019)', 'Location', 'northwest','fontsize',15);
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% 显示图形
grid on;

box on
% print(gcf, fullfile(path, 'GLF.png'), '-dpng', '-r1000');