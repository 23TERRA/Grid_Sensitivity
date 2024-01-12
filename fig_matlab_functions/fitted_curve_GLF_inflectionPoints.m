path1='C:\Users\TERRA\Documents\MATLAB\WQX\反演\网格敏感性实验\ADD_Experiment';
X1=load(fullfile(path1, '30km\IR-Inverse-UaOptimization-Nod3-I-Adjoint-Cga0k000010-Cgs0k010000-Aga0k000010-Ags0k010000-m3--logA-logC-.mat'));
Iterations = [1:300];
Values1=X1.RunInfo.Inverse.WQX;
Valid_Values30km=[Values1(2:end)]';

X2=load(fullfile(path1, '25km\IR-Inverse-UaOptimization-Nod3-I-Adjoint-Cga0k000010-Cgs0k010000-Aga0k000010-Ags0k010000-m3--logA-logC-.mat'));
Values2=X2.RunInfo.Inverse.WQX;
Valid_Values25km=[Values2(2:end)]';

X3=load(fullfile(path1, '20km\IR-Inverse-UaOptimization-Nod3-I-Adjoint-Cga0k000010-Cgs0k010000-Aga0k000010-Ags0k010000-m3--logA-logC-.mat'));
Values3=X3.RunInfo.Inverse.WQX;
Valid_Values20km=[Values3(2:end)]';

X4=load(fullfile(path1, '16km\IR-Inverse-UaOptimization-Nod3-I-Adjoint-Cga0k000010-Cgs0k010000-Aga0k000010-Ags0k010000-m3--logA-logC-.mat'));
Values4=X4.RunInfo.Inverse.WQX;
Valid_Values16km=[Values4(2:end)]';

X5=load(fullfile(path1, '10km\IR-Inverse-UaOptimization-Nod3-I-Adjoint-Cga0k000010-Cgs0k010000-Aga0k000010-Ags0k010000-m3--logA-logC-.mat'));
Values5=X5.RunInfo.Inverse.WQX;
Valid_Values10km=[Values5(2:end)]';

X6=load(fullfile(path1, '8km\IR-Inverse-UaOptimization-Nod3-I-Adjoint-Cga0k000010-Cgs0k010000-Aga0k000010-Ags0k010000-m3--logA-logC-.mat'));
Values6=X6.RunInfo.Inverse.WQX;
Valid_Values8km=[Values6(2:end)]';

X7=load(fullfile(path1, '5km\IR-Inverse-UaOptimization-Nod3-I-Adjoint-Cga0k000010-Cgs0k010000-Aga0k000010-Ags0k010000-m3--logA-logC-.mat'));
Values7=X7.RunInfo.Inverse.WQX;
Valid_Values5km=[Values7(2:end)]';

X8=load(fullfile(path1, '4km\IR-Inverse-UaOptimization-Nod3-I-Adjoint-Cga0k000010-Cgs0k010000-Aga0k000010-Ags0k010000-m3--logA-logC-.mat'));
Values8=X8.RunInfo.Inverse.WQX;
Valid_Values4km=[Values8(2:end)]';

X9=load(fullfile(path1, '2km\IR-Inverse-UaOptimization-Nod3-I-Adjoint-Cga0k000010-Cgs0k010000-Aga0k000010-Ags0k010000-m3--logA-logC-.mat'));
Values9=X9.RunInfo.Inverse.WQX;
Valid_Values2km=[Values9(2:end)]';

X10=load(fullfile(path1, '不规则格网\IR-Inverse-UaOptimization-Nod3-I-Adjoint-Cga0k000010-Cgs0k010000-Aga0k000010-Ags0k010000-m3--logA-logC-.mat'));
Values10=X10.RunInfo.Inverse.WQX;
Valid_ValuesNonuniform=[Values10(2:end)]';

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
path = 'C:\Users\TERRA\Desktop\results';


[xData10, yData10] = prepareCurveData( Iterations, Valid_ValuesNonuniform );
[xData9, yData9] = prepareCurveData( Iterations, Valid_Values2km );
[xData8, yData8] = prepareCurveData( Iterations, Valid_Values4km );
[xData7, yData7] = prepareCurveData( Iterations, Valid_Values5km );
[xData6, yData6] = prepareCurveData( Iterations, Valid_Values8km );
[xData5, yData5] = prepareCurveData( Iterations, Valid_Values10km );
[xData4, yData4] = prepareCurveData( Iterations, Valid_Values16km );
[xData3, yData3] = prepareCurveData( Iterations, Valid_Values20km );
[xData2, yData2] = prepareCurveData( Iterations, Valid_Values25km );
[xData1, yData1] = prepareCurveData( Iterations, Valid_Values30km );


% 设置 fittype 和选项。
ft = fittype( 'power2' );
opts10 = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts10.Display = 'Off';
opts10.Robust = 'LAR';
opts10.StartPoint = [97.7343311816291 -0.0574377814669995 0.0788051361828868];

opts9 = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts9.Display = 'Off';
opts9.Robust = 'LAR';
opts9.StartPoint = [66.3461961245997 0.025791688722939 -0.161238381805118];

opts8 = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts8.Display = 'Off';
opts8.Robust = 'LAR';
opts8.StartPoint = [450.879591469728 -0.348565763223483 -7.31759615304925];

opts7 = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts7.Display = 'Off';
opts7.Robust = 'LAR';
opts7.StartPoint = [454.236869122819 -0.346870591449359 -7.32354343737086];

opts6 = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts6.Display = 'Off';
opts6.Robust = 'LAR';
opts6.StartPoint = [418.661446571769 -0.34476303023024 -7.11232819654644];

opts5 = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts5.Display = 'Off';
opts5.Robust = 'LAR';
opts5.StartPoint = [1602.74947327232 -0.598695548506803 -29.2923231483986];

opts4 = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts4.Display = 'Off';
opts4.Robust = 'LAR';
opts4.StartPoint = [575.41962233936 -0.390709404244182 -10.6573173057191];

opts3 = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts3.Display = 'Off';
opts3.Robust = 'LAR';
opts3.StartPoint = [924.068275939349 -0.484664909187724 -18.1298655460599];

opts2 = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts2.Display = 'Off';
opts2.Robust = 'LAR';
opts2.StartPoint = [201.564615717877 -0.189111129271837 -2.05504999988151];

opts1 = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts1.Display = 'Off';
opts1.Robust = 'LAR';
opts1.StartPoint = [252.600021821958 -0.237444984330013 -3.86163553077777];
% 对数据进行模型拟合。
[fitresult10, gof10] = fit(xData10, yData10, ft, opts10 );
[fitresult9, gof9] = fit(xData9, yData9, ft, opts9 );
[fitresult8, gof8] = fit(xData8, yData8, ft, opts8 );
[fitresult7, gof7] = fit(xData7, yData7, ft, opts7 );
[fitresult6, gof6] = fit(xData6, yData6, ft, opts6 );
[fitresult5, gof5] = fit(xData5, yData5, ft, opts5 );
[fitresult4, gof4] = fit(xData4, yData4, ft, opts4 );
[fitresult3, gof3] = fit(xData3, yData3, ft, opts3 );
[fitresult2, gof2] = fit(xData2, yData2, ft, opts2 );
[fitresult1, gof1] = fit(xData1, yData1, ft, opts1 );
% 假设你有10个 fitresult，存储在一个 cell 数组中
fitresults = {fitresult1, fitresult2, fitresult3, fitresult4, fitresult5, fitresult6, fitresult7, fitresult8, fitresult9, fitresult10};

% 初始化一个 cell 数组，用于存储结果
A = cell(1, numel(fitresults));

% 循环遍历每个 fitresult，提取数据并存储在 A 中
for i = 1:numel(fitresults)
    A{i} = feval(fitresults{i}, Iterations);
end

%% 求曲率半径最小值的拐点

% 初始化一个 cell 数组，用于存储每条曲线的拐点
turning_points = cell(1, numel(fitresults));
curvature_WQX = cell(1, numel(fitresults));
% 遍历每个 fitresult
for i = 1:numel(fitresults)
    % 计算曲率
    dydx = gradient(A{i}, Iterations);
    d2ydx2 = gradient(dydx, Iterations);
    curvature = abs(d2ydx2) ./ (1 + dydx.^2).^(3/2);     % https://mathworld.wolfram.com/RadiusofCurvature.html
    curvature_WQX{i}=max(curvature);
    % 找到曲率半径最小值对应的拐点
    [max_curvature, max_index] = max(curvature);
    turning_points{i} = [Iterations(max_index), A{i}(max_index)];
end

% 绘制曲线和拐点
figure('units', 'centimeters', 'position', [18, 8, 17, 11]);

for i = 1:numel(fitresults)-1
    plot(Iterations, A{i}, 'color', C(i,:), 'LineWidth', 1);
    hold on
end
hold on
plot(Iterations, A{10}, 'color', C(10,:), 'LineWidth', 2);

hold on
% 添加灰影区域（观测区间）
y_lower = 61 - 5; % 下限
y_upper = 61 + 5; % 上限
x_fill = [-20, 320, 320, -20];
y_fill = [y_lower, y_lower, y_upper, y_upper];
% 使用RGB颜色表示灰色，FaceAlpha设置透明度
patch(x_fill, y_fill, [0.8, 0.8, 0.8], 'FaceAlpha', 0.5, 'EdgeColor', 'none');


for i = 1:numel(fitresults)
    hold on
    scatter(turning_points{i}(1), turning_points{i}(2), 50, C(i,:), 'filled');
end


xlim([-20,320]);
ylim([50,150]);
xlabel('Iterations','fontsize',10,'fontname','time news roman','fontweight','normal');
ylabel('GLF (Gt a^{-1})','fontsize',10,'fontname','time news roman','fontweight','normal');

set(gca,'linewidth',1,'fontsize',10,'fontweight','normal','fontname','time news roman');
% 添加省略号
text(-1, 152, '...', 'Rotation', 90,'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 10);

% 添加图例
legend('30 km','25 km','20 km','16 km','10 km','8 km','5 km','4 km','2 km','Nonuniform','Location', 'northeast','fontsize',10,'fontname','time news roman','fontweight','normal');
% title('Exponential Fit','fontsize',17,'fontname','time news roman','fontweight','normal');

% 显示图形
grid on;

box on
print(gcf, fullfile(path, 'GLF_Iterations300.png'), '-dpng', '-r1000');


B10=A{10};B9=A{9};B8=A{8};B7=A{7};B6=A{6};B5=A{5};B4=A{4};B3=A{3};B2=A{2};B1=A{1};
C10=abs(Valid_ValuesNonuniform-B10');
C9=abs(Valid_Values2km-B9');
C8=abs(Valid_Values4km-B8');
C7=abs(Valid_Values5km-B7');
C6=abs(Valid_Values8km-B6');
C5=abs(Valid_Values10km-B5');
C4=abs(Valid_Values16km-B4');
C3=abs(Valid_Values20km-B3');
C2=abs(Valid_Values25km-B2');
C1=abs(Valid_Values30km-B1');

%%
resolutions = [2, 4, 5, 8, 10,16,20,25,30]; % 网格分辨率
Diff_values=[sum(C9(201:end)),sum(C8(201:end)),sum(C7(201:end)),sum(C6(201:end)),sum(C5(201:end)),sum(C4(201:end)),sum(C3(201:end)),sum(C2(201:end)),sum(C1(201:end))]
% Mean_Diff 不规则格网10.5498 
% 绘制散点图  
figure
set(gcf,'color','w','position',[500 200 650 600]);
scatter(resolutions, Diff_values, 100, 'b', 'filled'); % 'b'代表蓝色，'filled'填充点

% % 拟合曲线（这里使用二次多项式）
% p = polyfit(resolutions, Diff_values, 1); % 3表示3次多项式拟合
% 
% % 生成拟合曲线的x值范围
% x_fit = linspace(0, 32, 100);
% 
% % 计算拟合曲线的y值
% y_fit = polyval(p, x_fit);

% % 绘制拟合曲线
% hold on;
% plot(x_fit, y_fit, 'r', 'LineWidth', 2);

hold on;
y_line = sum(C10(201:end)); % 不规则格网的Mean_diff值
plot([0, 50], [y_line, y_line], 'k--', 'LineWidth', 2);

% 设置坐标轴范围
xlim([0,32]);
set(gca,'xtick',[0 2 4 5 8 10 16 20 25 30]);
% ylim([3,16]);
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% 添加标签和标题
xlabel('Grid Size (km)','fontsize',15);
ylabel('Sum(abs(Mod-Fit)) [last 100] (Gt{\cdot}a^{-1})','fontsize',15,'fontweight','normal','fontname','time news roman');

% 添加图例
legend('Uniform Grids','Nonuniform Grids', 'Location', 'northwest','fontsize',15);

% 显示图形
grid on;

box on
print(gcf, fullfile(path, 'Fit-Mod_Post-Last100.png'), '-dpng', '-r1000');

%%
i=2;
dydx = gradient(A{i}, Iterations);
d2ydx2 = gradient(dydx, Iterations);
curvature = abs(d2ydx2) ./ (1 + dydx.^2).^(3/2);     % https://mathworld.wolfram.com/RadiusofCurvature.html
EEE=100*log10(curvature);
% 找到曲率最大值对应的拐点
[max_curvature, max_index] = max(curvature);
turning_pointsWQX = [Iterations(max_index), A{i}(max_index)];
figure
set(gcf,'color','w','position',[500 200 650 600]);
plot(Iterations, A{i}, 'color', C(i,:), 'LineWidth', 2);
hold on
plot(Iterations, EEE, 'color', 'k', 'LineWidth', 2);
hold on
scatter(turning_pointsWQX(1), turning_pointsWQX(2), 100, C(i,:), 'filled');
axis equal

%% 腾哥的点子 20231011 横坐标GLF（1） 纵坐标曲率最大值 每个Grid size一个点

figure
set(gcf,'color','w','position',[500 200 650 600]);
for i = 1:numel(fitresults)-1
    hold on
    scatter(A{i}(1), curvature_WQX{i}, 100, C(i,:), 'filled');
end
hold on
scatter(A{10}(1), curvature_WQX{10}(1), 400,C(10,:),'p','filled');
xlabel('GLF (iterations=1) (Gt a^{-1})','fontsize',15,'fontname','time news roman','fontweight','normal');
ylabel('Max curvature','Interpreter','none','fontsize',15,'fontname','time news roman','fontweight','normal');


% 添加图例
legend('30 km','25 km','20 km','16 km','10 km','8 km','5 km','4 km','2 km','Nonuniform','Location', 'northeast','fontsize',15,'fontname','time news roman','fontweight','normal');
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% 显示图形
grid on;

box on
print(gcf, fullfile(path, 'GLF_Iterations1_Max_curvature1.png'), '-dpng', '-r1000');

%%
figure
set(gcf,'color','w','position',[500 200 650 600]);
for i = 1:numel(fitresults)-1
    hold on
    scatter(A{i}(1), turning_points{i}(1), 100, C(i,:), 'filled');
end
hold on
scatter(A{10}(1), turning_points{10}(1), 400,C(10,:),'filled','p');
xlabel('GLF (iterations=1) (Gt a^{-1})','fontsize',15,'fontname','time news roman','fontweight','normal');
ylabel('Iterations (max curvature)','fontsize',15,'fontname','time news roman','fontweight','normal');

% 添加图例
legend('30 km','25 km','20 km','16 km','10 km','8 km','5 km','4 km','2 km','Nonuniform','Location', 'southeast','fontsize',15,'fontname','time news roman','fontweight','normal');
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% 显示图形
grid on;

box on
print(gcf, fullfile(path, 'GLF_Iterations1_Iterations_curvature.png'), '-dpng', '-r1000');


%%
path = 'C:\Users\TERRA\Desktop\results';

resolutions = [2, 4, 5, 8, 10,16,20,25,30]; % 网格分辨率
VAF_values=[7,19,15,16,18,18,15,5,6];
% Mean_Diff 不规则格网10.5498 
% 绘制散点图  
figure
set(gcf,'color','w','position',[500 200 650 600]);
scatter(resolutions, VAF_values, 100, 'b', 'filled'); % 'b'代表蓝色，'filled'填充点

% % 拟合曲线（这里使用二次多项式）
% p = polyfit(resolutions, VAF_values, 1); % 3表示3次多项式拟合
% 
% % 生成拟合曲线的x值范围
% x_fit = linspace(0, 32, 100);
% 
% % 计算拟合曲线的y值
% y_fit = polyval(p, x_fit);

% 拟合曲线（这里使用robustfit）
[b, stats] = robustfit(resolutions, VAF_values);
% 生成拟合曲线的x值范围
x_fit = linspace(0, 32, 100);
% 计算拟合曲线的y值
y_fit = b(1) + b(2) * x_fit;
% 计算拟合误差
se = stats.se;

% 绘制拟合曲线
% hold on;
% plot(x_fit, y_fit, 'r', 'LineWidth', 2);

hold on;
y_line = 8; % 不规则格网的Mean_diff值
plot([0, 50], [y_line, y_line], 'k--', 'LineWidth', 2);
hold on;
% 绘制拟合误差阴影
% fill([x_fit, fliplr(x_fit)], [y_fit + se, fliplr(y_fit - se)], [0.8, 0.8, 0.8], 'FaceAlpha', 0.25, 'EdgeColor', 'none');
% 设置坐标轴范围
xlim([0,32]);
set(gca,'xtick',[0 2 4 5 8 10 16 20 25 30]);
% ylim([375000,378500]);
% 添加标签和标题
xlabel('Grid size (km)','fontsize',15);
ylabel('The positions of inflection points','Interpreter','tex','fontsize',15);
% ylabel('VAF (Gt{\cdot}a^{-1})','fontsize',15);
% 添加图例
legend('Uniform grids','Nonuniform grids', 'Location', 'northeast','fontsize',15);
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% 显示图形
grid on;

box on
print(gcf, fullfile(path, '拐点位置.png'), '-dpng', '-r1000');
