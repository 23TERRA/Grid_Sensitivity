path1='E:\MATLAB\WQX\Project1';
path2='E:\MATLAB\WQX\Project1\出图代码\原图直出';
X1=load(fullfile(path1, '30km\InverseRestart.mat'));
Iterations = 1:300;
Iterations=Iterations';
Values1=X1.RunInfo.Inverse.J;
Valid_Values30km=Values1(4:303);


X2=load(fullfile(path1, '25km\InverseRestart.mat'));
Values2=X2.RunInfo.Inverse.J;
Valid_Values25km=Values2(4:303);

X3=load(fullfile(path1, '20km\InverseRestart.mat'));
Values3=X3.RunInfo.Inverse.J;
Valid_Values20km=Values3(4:303);

X4=load(fullfile(path1, '16km\InverseRestart.mat'));
Values4=X4.RunInfo.Inverse.J;
Valid_Values16km=Values4(4:303);

X5=load(fullfile(path1, '10km\InverseRestart.mat'));
Values5=X5.RunInfo.Inverse.J;
Valid_Values10km=Values5(4:303);

X6=load(fullfile(path1, '8km\InverseRestart.mat'));
Values6=X6.RunInfo.Inverse.J;
Valid_Values8km=Values6(4:303);

X7=load(fullfile(path1, '5km\InverseRestart.mat'));
Values7=X7.RunInfo.Inverse.J;
Valid_Values5km=Values7(4:303);

X8=load(fullfile(path1, '4km\InverseRestart.mat'));
Values8=X8.RunInfo.Inverse.J;
Valid_Values4km=Values8(4:303);

X9=load(fullfile(path1, '2km\InverseRestart.mat'));
Values9=X9.RunInfo.Inverse.J;
Valid_Values2km=Values9(4:303);

X10=load(fullfile(path1, 'UnstructuredMesh\InverseRestart.mat'));
Values10=X10.RunInfo.Inverse.J;
Valid_ValuesNonuniform=Values10(4:303);

%%
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
opts10.StartPoint = [380.538670424175 -0.818240012036897 -3.53557632243846];

opts9 = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts9.Display = 'Off';
opts9.Robust = 'LAR';
opts9.StartPoint = [333.624439660254 -0.721041000076428 -3.04504600751932];

opts8 = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts8.Display = 'Off';
opts8.Robust = 'LAR';
opts8.StartPoint = [370.699342047817 -0.770145565180712 -4.18006626246954];

opts7 = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts7.Display = 'Off';
opts7.Robust = 'LAR';
opts7.StartPoint = [674.913118872913 -0.872125396494575 -7.82703235757375];

opts6 = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts6.Display = 'Off';
opts6.Robust = 'LAR';
opts6.StartPoint = [1035.0118070596 -0.934753991919393 -11.2850552533923];

opts5 = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts5.Display = 'Off';
opts5.Robust = 'LAR';
opts5.StartPoint = [4443.45916287898 -1.17046850122186 -35.9007510648937];

opts4 = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts4.Display = 'Off';
opts4.Robust = 'LAR';
opts4.StartPoint = [4784.86293909471 -1.06957004892753 -44.5490342888916];

opts3 = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts3.Display = 'Off';
opts3.Robust = 'LAR';
opts3.StartPoint = [3336.82389357719 -1.0243018388762 -32.5095313269615];

opts2 = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts2.Display = 'Off';
opts2.Robust = 'LAR';
opts2.StartPoint = [5467.03099404766 -1.02768073399786 -45.1544427055773];

opts1 = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts1.Display = 'Off';
opts1.Robust = 'LAR';
opts1.StartPoint = [6048.03552688451 -1.0698053048642 -46.1667493427316];
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
% figure('units', 'centimeters', 'position', [18, 8, 17, 11]);

figure
set(gcf,'color','w','position',[500 200 650 600]); 
for i = 1:numel(fitresults)-1
    plot(Iterations, A{i}, 'color', C(i,:), 'LineWidth', 1);
    hold on
end
hold on
plot(Iterations, A{10}, 'color', C(10,:), 'LineWidth', 1);

% hold on
% % 添加灰影区域（观测区间）
% y_lower = 61 - 5; % 下限
% y_upper = 61 + 5; % 上限
% x_fill = [-20, 320, 320, -20];
% y_fill = [y_lower, y_lower, y_upper, y_upper];
% % 使用RGB颜色表示灰色，FaceAlpha设置透明度
% patch(x_fill, y_fill, [0.8, 0.8, 0.8], 'FaceAlpha', 0.5, 'EdgeColor', 'none');


% for i = 1:numel(fitresults)
%     hold on
%     scatter(turning_points{i}(1), turning_points{i}(2), 50, C(i,:), 'filled');
% end


xlim([0,300]);
ylim([0,500]);
xlabel('Iterations','fontsize',15,'fontname','time news roman','fontweight','normal');
ylabel('Cost function J','fontsize',15,'fontname','time news roman','fontweight','normal');

set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% 添加省略号
text(0.002, 510, '...', 'Rotation', 90,'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 15);

% 添加图例
legend('30 km','25 km','20 km','16 km','10 km','8 km','5 km','4 km','2 km','Unstructured','Location', 'northeast','fontsize',15,'fontname','time news roman','fontweight','normal');
% title('Exponential Fit','fontsize',17,'fontname','time news roman','fontweight','normal');

% 显示图形
grid on;

box on
%print(gcf, fullfile(path2, 'GLF_Iterations300222.png'), '-dpng', '-r1000');


B10=A{10};B9=A{9};B8=A{8};B7=A{7};B6=A{6};B5=A{5};B4=A{4};B3=A{3};B2=A{2};B1=A{1};
C10=abs(Valid_ValuesNonuniform-B10);
C9=abs(Valid_Values2km-B9);
C8=abs(Valid_Values4km-B8);
C7=abs(Valid_Values5km-B7);
C6=abs(Valid_Values8km-B6);
C5=abs(Valid_Values10km-B5);
C4=abs(Valid_Values16km-B4);
C3=abs(Valid_Values20km-B3);
C2=abs(Valid_Values25km-B2);
C1=abs(Valid_Values30km-B1);

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
legend('Structured Grids','Unstructured Grids', 'Location', 'northeast','fontsize',15);

% 显示图形
grid on;

box on
print(gcf, fullfile(path2, 'Fit-Mod_Post-Last100.png'), '-dpng', '-r1000');

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
legend('30 km','25 km','20 km','16 km','10 km','8 km','5 km','4 km','2 km','Unstructured','Location', 'northeast','fontsize',15,'fontname','time news roman','fontweight','normal');
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% 显示图形
grid on;

box on
print(gcf, fullfile(path2, 'GLF_Iterations1_Max_curvature1.png'), '-dpng', '-r1000');

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
ylim([13,23]);
% 添加图例
legend('30 km','25 km','20 km','16 km','10 km','8 km','5 km','4 km','2 km','Unstructured','Location', 'southeast','fontsize',15,'fontname','time news roman','fontweight','normal');
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% 显示图形
grid on;

box on
print(gcf, fullfile(path2, 'GLF_Iterations1_Iterations_curvature.png'), '-dpng', '-r1000');


%%

resolutions = [2, 4, 5, 8, 10,16,20,25,30]; % 网格分辨率
VAF_values=[16,20,20,16,21,18,22,19,15];
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
y_line = 14; % 不规则格网的Mean_diff值
plot([0, 50], [y_line, y_line], 'k--', 'LineWidth', 2);
hold on;
% 绘制拟合误差阴影
% fill([x_fit, fliplr(x_fit)], [y_fit + se, fliplr(y_fit - se)], [0.8, 0.8, 0.8], 'FaceAlpha', 0.25, 'EdgeColor', 'none');
% 设置坐标轴范围
xlim([0,32]);
ylim([13,23]);
set(gca,'xtick',[0 2 4 5 8 10 16 20 25 30]);
% ylim([375000,378500]);
% 添加标签和标题
xlabel('Grid size (km)','fontsize',15);
ylabel('The positions of inflection points','Interpreter','tex','fontsize',15);
% ylabel('VAF (Gt{\cdot}a^{-1})','fontsize',15);
% 添加图例
legend('Structured grids','Unstructured grids', 'Location', 'northwest','fontsize',15);
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% 显示图形
grid on;

box on
print(gcf, fullfile(path2, '拐点位置.png'), '-dpng', '-r1000');
%%
path='C:\Users\TERRA\Documents\MATLAB\WQX\反演\20240306L_curve\PLOTS';
resolutions = [2, 4, 5, 8, 10,16,20,25,30]; % 网格分辨率
VAF_values=[3.0054,7.8160,6.9196,9.0204,20.1528,11.9099,10.2625,13.1483,11.5188];
% Mean_Diff 不规则格网10.5498 
% 绘制散点图  
figure
set(gcf,'color','w','position',[500 200 650 600]);
scatter(resolutions, VAF_values, 100, 'b', 'filled'); % 'b'代表蓝色，'filled'填充点

hold on;
y_line = 2.9249; % 不规则格网的Mean_diff值
plot([0, 50], [y_line, y_line], 'k--', 'LineWidth', 2);
hold on;

xlim([0,32]);
ylim([0,21]);
set(gca,'xtick',[0 2 4 5 8 10 16 20 25 30]);
% ylim([375000,378500]);
% 添加标签和标题
xlabel('Grid size (km)','fontsize',15);
ylabel('Relative error of initial GLF to ﬁnal GLF','Interpreter','tex','fontsize',15);
% ylabel('VAF (Gt{\cdot}a^{-1})','fontsize',15);
% 添加图例
legend('Structured grids','Unstructured grids', 'Location', 'northeast','fontsize',15);
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% 显示图形
grid on;

box on
print(gcf, fullfile(path2, '相对误差.png'), '-dpng', '-r1000');


%%
% 绘制曲线和拐点
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

custom_colors1 = [
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
figure
set(gcf,'color','w','position',[500 200 650 600]); 

plot(Iterations, Valid_Values30km, 'color', C(1,:), 'LineWidth', 1);
hold on
plot(Iterations, Valid_Values25km, 'color', C(2,:), 'LineWidth', 1);
hold on
plot(Iterations, Valid_Values20km, 'color', C(3,:), 'LineWidth', 1);
hold on
plot(Iterations, Valid_Values16km, 'color', C(4,:), 'LineWidth', 1);
hold on
plot(Iterations, Valid_Values10km, 'color', C(5,:), 'LineWidth', 1);
hold on
plot(Iterations, Valid_Values8km, 'color', C(6,:), 'LineWidth', 1);
hold on
plot(Iterations, Valid_Values5km, 'color', C(7,:), 'LineWidth', 1);
hold on
plot(Iterations, Valid_Values4km, 'color', C(8,:), 'LineWidth', 1);
hold on
plot(Iterations, Valid_Values2km, 'color', C(9,:), 'LineWidth', 1);
hold on
plot(Iterations, Valid_ValuesNonuniform, 'color', C(10,:), 'LineWidth', 1);

% hold on
% % 添加灰影区域（观测区间）
% y_lower = 61 - 5; % 下限
% y_upper = 61 + 5; % 上限
% x_fill = [-20, 320, 320, -20];
% y_fill = [y_lower, y_lower, y_upper, y_upper];
% % 使用RGB颜色表示灰色，FaceAlpha设置透明度
% patch(x_fill, y_fill, [0.8, 0.8, 0.8], 'FaceAlpha', 0.5, 'EdgeColor', 'none');


xlim([0,300]);
ylim([0,500]);
xlabel('Iterations','fontsize',15,'fontname','time news roman','fontweight','normal');
ylabel('Cost function J','fontsize',15,'fontname','time news roman','fontweight','normal');

set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% 添加省略号
text(-1, 510, '...', 'Rotation', 90,'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 15);

% % 添加图例
legend('30 km','25 km','20 km','16 km','10 km','8 km','5 km','4 km','2 km','Unstructured','Location', 'northeast','fontsize',15,'fontname','time news roman','fontweight','normal');
% title('Exponential Fit','fontsize',17,'fontname','time news roman','fontweight','normal');
set(legend,'NumColumns',4,'FontSize',15);
% 显示图形
grid on;

box on
print(gcf, fullfile(path2, 'Cost_Function300.png'), '-dpng', '-r1000');

