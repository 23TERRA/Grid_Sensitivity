% Mean_diff_Cal and Plot
% TERRA 20230905
path1= 'E:\MATLAB\WQX\Project1\出图代码\原图直出';
custom_colors = [
      68 4 90; 
      26 49 139;
      31 146 139;
      114 170 207;
      145 213 66;
      192 63 103; 
      228 107 144;  
      236 93 59;   
      253 185 107;   
      255 0 0;     
];
C = custom_colors/255;

% load(fullfile(path, 'AmeryObserve_ub_vb.mat'));
% load(fullfile(path, 'AmeryInverse_ub_vb.mat'));
% % idx = AmeryVB.Values~=0; % 找出非零的位置
% % A=AmeryVB.Values(idx);%诊断模型得到的流速
% % B=AmeryVBO.Values(idx);%观测的流速
% A1=AmeryUB.Values;
% B1=AmeryUBO.Values;
% A2=AmeryVB.Values;
% B2=AmeryVBO.Values;
% speedA=sqrt(A1.*A1+A2.*A2);
% speedB=sqrt(B1.*B1+B2.*B2);
% diff=abs(speedA-speedB);
% mean1 = mean(diff(:));
% std1 = std(diff(:));



% resolutions = [2, 4, 5, 8, 10,16,20,25,30]; % 网格分辨率
% meandiff_values=[6.0421,5.2608,5.6565,6.2056,7.5493,9.4048,10.7208,11.5585,12.9844];
% % Mean_Diff 不规则格网10.5498 
% % 绘制散点图  
% figure
% set(gcf,'color','w','position',[500 200 650 600]);
% scatter(resolutions, meandiff_values, 100, 'b', 'filled'); % 'b'代表蓝色，'filled'填充点
% 
% % 拟合曲线（这里使用二次多项式）
% p = polyfit(resolutions, meandiff_values, 1); % 3表示3次多项式拟合
% 
% % 生成拟合曲线的x值范围
% x_fit = linspace(0, 32, 100);
% 
% % 计算拟合曲线的y值
% y_fit = polyval(p, x_fit);
% 
% % 绘制拟合曲线
% hold on;
% plot(x_fit, y_fit, 'r', 'LineWidth', 2);
% 
% hold on;
% y_line = 10.5498; % 不规则格网的Mean_diff值
% plot([0, 50], [y_line, y_line], 'k--', 'LineWidth', 2);
% 
% % % 添加灰影区域（观测区间）
% % y_lower = 70.0665 - 5; % 下限
% % y_upper = 70.0665 + 5; % 上限
% % x_fill = [min(resolutions), max(resolutions), max(resolutions), min(resolutions)];
% % y_fill = [y_lower, y_lower, y_upper, y_upper];
% % % 使用RGB颜色表示灰色，FaceAlpha设置透明度
% % patch(x_fill, y_fill, [0.8, 0.8, 0.8], 'FaceAlpha', 0.5, 'EdgeColor', 'none');
% 
% 
% % 设置坐标轴范围
% xlim([0,32]);
% set(gca,'xtick',[0 2 4 5 8 10 16 20 25 30]);
% ylim([3,16]);
% set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% % 添加标签和标题
% xlabel('Grid Size (km)','fontsize',15);
% ylabel('Mean Diff (m{\cdot}a^{-1})','fontsize',15);
% % title('网格分辨率与Mean(diff)关系','fontsize',17);
% 
% % 添加图例
% legend('Uniform Grids', 'Fitted Line','Nonuniform Grids', 'Location', 'northwest','fontsize',15);
% 
% % 显示图形
% grid on;
% 
% box on
% print(gcf, fullfile(path, 'Mean_Diff.png'), '-dpng', '-r1000');

%%
resolutions = [2, 4, 5, 8, 10,16,20,25,30]; % 网格分辨率
% Mean_Diff 不规则格网10.5498 
% 绘制散点图  
figure
set(gcf,'color','w','position',[500 200 650 600]);

%% 1
mean_of_top_values=[57.333238236743990,61.671549269140755,68.377650757015270,77.319214439288020,97.476422394888420,1.398598008767857e+02,1.419120224550360e+02,1.641891314288266e+02,1.719510276782112e+02];   %不规则网格  56.1167   1km 50.5160
scatter(resolutions, mean_of_top_values, 100, C(5,:), 'filled', '^'); % 'b'代表蓝色，'filled'填充点

%% 5
mean_of_top_values5=[29.037675196120894,29.477059063147493,31.258717095270450,34.381137222281865,40.743954552120470,60.485674663604090,66.991712272366800,74.690535998734230,83.052512146882620];   %不规则网格  56.1167   1km 50.5160
hold on;
scatter(resolutions, mean_of_top_values5, 100, C(7,:), 'filled', 's'); % 'b'代表蓝色，'filled'填充点

%% 10
mean_of_top_values10=[20.908971245027747,20.368630901398767,20.701928991175237,21.814713351109898,25.198187340212172,36.979007351044395,41.676583855926650,46.039477727459534,52.763964179339090];   %不规则网格  56.1167   1km 50.5160
hold on;
scatter(resolutions, mean_of_top_values10, 100, C(9,:), 'filled'); % 'b'代表蓝色，'filled'填充点

%% mean
meandiff_values=[4.074363588411402,3.773955347247808,3.619260830507241,3.427331390780321,3.718506919956130,4.958226910879621,5.529850446652612,5.937199158999217,6.662439302364673];
hold on;
scatter(resolutions, meandiff_values, 100, C(4,:),'filled', 'd'); % 'b'代表蓝色，'filled'填充点

% 拟合曲线（这里使用二次多项式）
p = polyfit(resolutions, mean_of_top_values10, 1); % 3表示3次多项式拟合

% 生成拟合曲线的x值范围
x_fit = linspace(0, 32, 100);

% 计算拟合曲线的y值
y_fit = polyval(p, x_fit);

% 绘制拟合曲线
hold on;
plot(x_fit, y_fit, 'color', C(9,:), 'LineWidth', 2);

hold on;
y_line = 59.720905379504070; % 10%
plot([0, 50], [y_line, y_line], 'color', C(9,:), 'LineWidth', 2,'LineStyle','--');


% 拟合曲线（这里使用二次多项式）
p = polyfit(resolutions, mean_of_top_values5, 1); % 3表示3次多项式拟合

% 生成拟合曲线的x值范围
x_fit = linspace(0, 32, 100);

% 计算拟合曲线的y值
y_fit = polyval(p, x_fit);

% 绘制拟合曲线
hold on;
plot(x_fit, y_fit, 'color', C(7,:), 'LineWidth', 2);

hold on;
y_line = 78.928385497726750; % 5%
plot([0, 50], [y_line, y_line], 'color', C(7,:), 'LineWidth', 2,'LineStyle','--');


% 拟合曲线（这里使用二次多项式）
p = polyfit(resolutions, mean_of_top_values, 1); % 3表示3次多项式拟合

% 生成拟合曲线的x值范围
x_fit = linspace(0, 32, 100);

% 计算拟合曲线的y值
y_fit = polyval(p, x_fit);

% 绘制拟合曲线
hold on;
plot(x_fit, y_fit, 'color', C(5,:), 'LineWidth', 2);

hold on;
y_line = 1.273082183727295e+02; % 1%
plot([0, 50], [y_line, y_line], 'color', C(5,:), 'LineWidth', 2,'LineStyle','--');

% 拟合曲线（这里使用二次多项式）
p = polyfit(resolutions, meandiff_values, 1); % 3表示3次多项式拟合

% 生成拟合曲线的x值范围
x_fit = linspace(0, 32, 100);

% 计算拟合曲线的y值
y_fit = polyval(p, x_fit);

% 绘制拟合曲线
hold on;
plot(x_fit, y_fit, 'color', C(4,:), 'LineWidth', 2);

hold on;
y_line = 13.171499425974318; % 100%
plot([0, 50], [y_line, y_line], 'color', C(4,:), 'LineWidth', 2,'LineStyle','--');
%%
% 设置坐标轴范围
xlim([0,32]);
set(gca,'xtick',[0 2 4 5 8 10 16 20 25 30]);
% ylim([3,16]);
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% 添加标签和标题
xlabel('Grid size (km)','fontsize',15);
ylabel('Mean(abs(mod-obs)) (m a^{-1})','fontsize',15);
% 显示图形
grid on;
% 添加图例
legend('Mean diff max1%','Mean diff max5%','Mean diff max10%', 'Mean diff','Location', 'northwest','fontsize',15);
box on
print(gcf, fullfile(path1, 'Velocity_Diff.png'), '-dpng', '-r1000');