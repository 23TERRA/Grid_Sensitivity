
path = 'C:\Users\TERRA\Desktop\results';
% 定义网格分辨率和GLF值
resolutions = [2, 4, 5, 8, 10,16,20,25,30]; % 网格分辨率
AF = [6.20,8.53,9.74,13.95,15.97,23.21,33.38,30.91,45.76]; % area/ice shlef width   不规则格网5.59

figure
set(gcf,'color','w','position',[500 200 650 600]);
% 绘制散点图
scatter(resolutions, AF, 100, 'b', 'filled'); % 'b'代表蓝色，'filled'填充点

% % 拟合曲线（这里使用二次多项式）
% p = polyfit(resolutions, AF, 1); % 3表示3次多项式拟合
% % 生成拟合曲线的x值范围
% x_fit = linspace(0, 50, 100);
% 
% % 计算拟合曲线的y值
% y_fit = polyval(p, x_fit);


% 拟合曲线（这里使用robustfit）
[b, stats] = robustfit(resolutions, AF);
% 生成拟合曲线的x值范围
x_fit = linspace(0, 32, 100);
% 计算拟合曲线的y值
% y_fit = polyval(p, x_fit);
y_fit = b(1) + b(2) * x_fit;
% 计算拟合误差
se = stats.se;
% 绘制拟合曲线
hold on;
plot(x_fit, y_fit, 'r', 'LineWidth', 2);

hold on;
y_line = 5.59; % 不规则格网的AF
plot([0, 50], [y_line, y_line], 'k--', 'LineWidth', 2);
hold on;
% 绘制拟合误差阴影
fill([x_fit, fliplr(x_fit)], [y_fit + se, fliplr(y_fit - se)], [0.8, 0.8, 0.8], 'FaceAlpha', 0.25, 'EdgeColor', 'none');
% 设置坐标轴范围
xlim([0,32]);
set(gca,'xtick',[0 2 4 5 8 10 16 20 25 30]);
ylim([1, 50]);

% 添加标签和标题
xlabel('Grid size (km)','fontsize',15);
ylabel('Normalized GL error (km)','fontsize',15);
% title('Normalized GL error = Area Difference/Ice Shelf Width','fontsize',10);

% 添加图例
legend('Uniform grids', 'Robust fit','Nonuniform grids', 'Location', 'northwest','fontsize',15);
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% 显示图形
grid on;

box on
print(gcf, fullfile(path, 'GL_Contrast.png'), '-dpng', '-r1000');