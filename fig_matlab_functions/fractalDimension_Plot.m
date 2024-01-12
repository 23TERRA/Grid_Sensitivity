path = 'C:\Users\TERRA\Desktop\results';

resolutions = [2, 4, 5, 8, 10,16,20,25,30]; % 网格分辨率
values=[0.9620,0.7879,0.7223,0.5969,0.5223,0.3847,0.3173,0.2587,0.2200];
% Mean_Diff 不规则格网10.5498 
% 绘制散点图  
figure
set(gcf,'color','w','position',[500 200 650 600]);
scatter(resolutions, values, 100, 'b', 'filled'); % 'b'代表蓝色，'filled'填充点

% % 拟合曲线（这里使用二次多项式）
% p = polyfit(resolutions, VAF_values, 1); % 3表示3次多项式拟合
% 
% % 生成拟合曲线的x值范围
% x_fit = linspace(0, 32, 100);
% 
% % 计算拟合曲线的y值
% y_fit = polyval(p, x_fit);

% 拟合曲线（这里使用robustfit）
[b, stats] = robustfit(resolutions, values);
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
y_line = 1.0796; % 不规则格网的Mean_diff值
plot([0, 50], [y_line, y_line], 'k--', 'LineWidth', 2);
hold on;
y_line2 = 0.7251; % 不规则格网的Mean_diff值
plot([0, 50], [y_line2, y_line2], 'r--', 'LineWidth', 2);
hold on;
% 绘制拟合误差阴影
fill([x_fit, fliplr(x_fit)], [y_fit + se, fliplr(y_fit - se)], [0.8, 0.8, 0.8], 'FaceAlpha', 0.25, 'EdgeColor', 'none');
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
legend('Uniform grids', 'Robust fit','Nonuniform grids','MEaSUREs Antarctica v2', 'Location', 'northwest','fontsize',15);
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% 显示图形
grid on;

box on
print(gcf, fullfile(path, '分形维数.png'), '-dpng', '-r1000');