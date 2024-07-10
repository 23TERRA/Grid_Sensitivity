path1='E:\MATLAB\WQX\Project1\20km';
path= 'E:\MATLAB\WQX\Project1\出图代码\原图直出';
load(fullfile(path1, 'AmeryObserve_ub_vb.mat'));
load(fullfile(path1, 'AmeryInverse_ub_vb.mat'));
% idx = AmeryVB.Values~=0; % 找出非零的位置
% A=AmeryVB.Values(idx);%诊断模型得到的流速
% B=AmeryVBO.Values(idx);%观测的流速
A1=AmeryUB.Values;
B1=AmeryUBO.Values;
A2=AmeryVB.Values;
B2=AmeryVBO.Values;
speedA=sqrt(A1.*A1+A2.*A2);
speedB=sqrt(B1.*B1+B2.*B2);
diff=abs(speedA-speedB);
% 假设你想计算前 5% 最大值的均值
percentile = 100; % 5%

% 对 diff 进行排序
sorted_diff = sort(diff, 'descend');

% 计算前 5% 最大值的索引范围
num_elements = numel(sorted_diff);
top_percentile = ceil(percentile / 100 * num_elements);

% 提取前 5% 最大值
top_values = sorted_diff(1:top_percentile);

% 计算前 5% 最大值的均值
mean_of_top_values = mean(top_values);

%%   提取前 5% 最大值
resolutions = [2, 4, 5, 8, 10,16,20,25,30]; % 网格分辨率
mean_of_top_values=[33.4955,38.5753,39.5831,48.2011,72.2942,83.5957,102.5495,102.4237,113.8766];   %不规则网格  56.1167   1km 50.5160


% Mean_Diff 不规则格网9.9473
% 绘制散点图
figure
set(gcf,'color','w','position',[500 200 650 600]);
scatter(resolutions, mean_of_top_values, 100, 'b', 'filled'); % 'b'代表蓝色，'filled'填充点

% 拟合曲线（这里使用二次多项式）
p = polyfit(resolutions, mean_of_top_values, 1); % 3表示3次多项式拟合

% 生成拟合曲线的x值范围
x_fit = linspace(0, 32, 100);

% 计算拟合曲线的y值
y_fit = polyval(p, x_fit);

% 绘制拟合曲线
hold on;
plot(x_fit, y_fit, 'r', 'LineWidth', 2);

hold on;
y_line = 56.1167; % 不规则格网的Mean_diff值
plot([0, 50], [y_line, y_line], 'k--', 'LineWidth', 2);

% % 添加灰影区域（观测区间）
% y_lower = 70.0665 - 5; % 下限
% y_upper = 70.0665 + 5; % 上限
% x_fill = [min(resolutions), max(resolutions), max(resolutions), min(resolutions)];
% y_fill = [y_lower, y_lower, y_upper, y_upper];
% % 使用RGB颜色表示灰色，FaceAlpha设置透明度
% patch(x_fill, y_fill, [0.8, 0.8, 0.8], 'FaceAlpha', 0.5, 'EdgeColor', 'none');


% 设置坐标轴范围
xlim([0,32]);
set(gca,'xtick',[0 2 4 5 8 10 16 20 25 30]);
ylim([20,120]);
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% 添加标签和标题
xlabel('Grid Size (km)','Interpreter','none','fontsize',15);
ylabel('Mean Diff Max5% (m{\cdot}a^{-1})','fontsize',15);
% title('网格分辨率与Max(diff5%)关系','fontsize',17);

% 添加图例
legend('Uniform Grids', 'Fitted Line','Nonuniform Grids', 'Location', 'northwest','fontsize',15);

% 显示图形
grid on;

% box on
% print(gcf, fullfile(path, 'Mean_Diff_Max5%.png'), '-dpng', '-r1000');

%%   提取前 1% 最大值
path = 'C:\Users\TERRA\Desktop\第一篇论文_Fig_Version2';
resolutions = [2, 4, 5, 8, 10,16,20,25,30]; % 网格分辨率
mean_of_top_values=[61.5557,80.3017,78.0815,101.7401,181.0827,171.8771,216.9019,202.6684,228.6190];   %不规则网格  56.1167   1km 50.5160


% Mean_Diff 不规则格网9.9473
% 绘制散点图
figure
set(gcf,'color','w','position',[500 200 650 600]);
scatter(resolutions, mean_of_top_values, 100, 'b', 'filled'); % 'b'代表蓝色，'filled'填充点

% 拟合曲线（这里使用二次多项式）
p = polyfit(resolutions, mean_of_top_values, 1); % 3表示3次多项式拟合

% 生成拟合曲线的x值范围
x_fit = linspace(0, 32, 100);

% 计算拟合曲线的y值
y_fit = polyval(p, x_fit);

% 绘制拟合曲线
hold on;
plot(x_fit, y_fit, 'r', 'LineWidth', 2);

hold on;
y_line = 81.6171; % 不规则格网的Mean_diff值
plot([0, 50], [y_line, y_line], 'k--', 'LineWidth', 2);

% % 添加灰影区域（观测区间）
% y_lower = 70.0665 - 5; % 下限
% y_upper = 70.0665 + 5; % 上限
% x_fill = [min(resolutions), max(resolutions), max(resolutions), min(resolutions)];
% y_fill = [y_lower, y_lower, y_upper, y_upper];
% % 使用RGB颜色表示灰色，FaceAlpha设置透明度
% patch(x_fill, y_fill, [0.8, 0.8, 0.8], 'FaceAlpha', 0.5, 'EdgeColor', 'none');


% 设置坐标轴范围
xlim([0,32]);
set(gca,'xtick',[0 2 4 5 8 10 16 20 25 30]);
ylim([50,240]);
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% 添加标签和标题
xlabel('Grid Size (km)','fontsize',15);
ylabel('Mean Diff Max1% (m{\cdot}a^{-1})','fontsize',15);
% title('网格分辨率与Max(diff5%)关系','fontsize',17);

% 添加图例
legend('Uniform Grids', 'Fitted Line','Nonuniform Grids', 'Location', 'northwest','fontsize',15);

% 显示图形
grid on;

box on
print(gcf, fullfile(path, 'Mean_Diff_Max1%.png'), '-dpng', '-r1000');
%%   提取前 10% 最大值
path = 'C:\Users\TERRA\Desktop\第一篇论文_Fig_Version2';
resolutions = [2, 4, 5, 8, 10,16,20,25,30]; % 网格分辨率
mean_of_top_values=[24.9038,26.4205,27.6492,33.4025,46.7437,55.5512,68.0630,72.0044,79.7318];   %不规则网格  56.1167   1km 50.5160


% Mean_Diff 不规则格网9.9473
% 绘制散点图
figure
set(gcf,'color','w','position',[500 200 650 600]);
scatter(resolutions, mean_of_top_values, 100, 'b', 'filled'); % 'b'代表蓝色，'filled'填充点

% 拟合曲线（这里使用二次多项式）
p = polyfit(resolutions, mean_of_top_values, 1); % 3表示3次多项式拟合

% 生成拟合曲线的x值范围
x_fit = linspace(0, 32, 100);

% 计算拟合曲线的y值
y_fit = polyval(p, x_fit);

% 绘制拟合曲线
hold on;
plot(x_fit, y_fit, 'r', 'LineWidth', 2);

hold on;
y_line = 43.4554; % 不规则格网的Mean_diff值
plot([0, 50], [y_line, y_line], 'k--', 'LineWidth', 2);

% % 添加灰影区域（观测区间）
% y_lower = 70.0665 - 5; % 下限
% y_upper = 70.0665 + 5; % 上限
% x_fill = [min(resolutions), max(resolutions), max(resolutions), min(resolutions)];
% y_fill = [y_lower, y_lower, y_upper, y_upper];
% % 使用RGB颜色表示灰色，FaceAlpha设置透明度
% patch(x_fill, y_fill, [0.8, 0.8, 0.8], 'FaceAlpha', 0.5, 'EdgeColor', 'none');


% 设置坐标轴范围
xlim([0,32]);
set(gca,'xtick',[0 2 4 5 8 10 16 20 25 30]);
ylim([20,80]);
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% 添加标签和标题
xlabel('Grid Size (km)','fontsize',15);
ylabel('Mean Diff Max10% (m{\cdot}a^{-1})','fontsize',15);
% title('网格分辨率与Max(diff5%)关系','fontsize',17);

% 添加图例
legend('Uniform Grids', 'Fitted Line','Nonuniform Grids', 'Location', 'northwest','fontsize',15);

% 显示图形
grid on;

box on
print(gcf, fullfile(path, 'Mean_Diff_Max10%.png'), '-dpng', '-r1000');
