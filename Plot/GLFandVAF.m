 load("E:\MATLAB\WQX\Project1\30km\InverseRestart.mat")
[VAF, ~, GroundedArea] = CalcVAF(CtrlVarInRestartFile, MUA, F.h, F.B, F.S, F.rho, F.rhow, GF);
    VAF_Gt = VAF.Total / (1.0893e9);
 qGL1 = FluxAcrossGroundingLine(CtrlVarInRestartFile,MUA,GF,F.ub,F.vb,F.ud,F.vd,F.h,F.rho);   %68.153855464693300
    fluxGL = sum(qGL1)/10e+11;
%%  不规则GLF=70.8690  2km=74.5755 
path = 'E:\MATLAB\WQX\Project1\出图代码\原图直出';
% 定义网格分辨率和GLF值
resolutions = [2, 4, 5, 8, 10,16,20,25,30]; % 网格分辨率
glf_values = [74.575473101059300,76.599343100752140,84.081469700399820,87.774167230298690,81.775831472089990,80.162194669143590,80.091499519099030,1.002620032997302e+02,62.727386476239620]; % GLF值   不规则格网70.0665   1km 71.2734

figure
set(gcf,'color','w','position',[500 200 650 600]);
% 绘制散点图
scatter(resolutions, glf_values, 100, 'b', 'filled'); % 'b'代表蓝色，'filled'填充点

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
y_line = 70.869005645554580; % 不规则格网的GLF值
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
ylim([55, 105]);

% 添加标签和标题
xlabel('Grid size (km)','fontsize',15);
ylabel('GLF (Gt a^{-1})','fontsize',15);

legend('Structured grids', 'Robust fit','Unstructured grids','Obs (Rignot et al., 2019)','Obs (Zhou et al., 2019)', 'Location', 'NorthWest','fontsize',15);
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% 显示图形
grid on;

box on
print(gcf, fullfile(path, 'GLF.png'), '-dpng', '-r1000');
%%
path = 'E:\MATLAB\WQX\Project1\出图代码\原图直出';
x = [2, 4, 5, 8, 10,16,20,25,30]; % 网格分辨率
y = [2.436090170351001e+06,2.436069614224113e+06,2.436138134332431e+06,2.436350791308953e+06,2.435783726846218e+06,2.438027549345232e+06,2.438366647186514e+06,2.435536122841708e+06,2.438154626445759e+06]/361.8;
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
y_line = 2.435627682613603e+06/361.8; % 不规则格网的Mean_diff值
plot([0, 50], [y_line, y_line], 'k--', 'LineWidth', 2);
hold on;
patch([x; flipud(x)], [yfit - dy; flipud(yfit + dy)],[0.8, 0.8, 0.8], 'EdgeColor', 'none', 'FaceAlpha', 0.25);


% 设置坐标轴范围
xlim([0,32]);
set(gca,'xtick',[0 2 4 5 8 10 16 20 25 30]);
% ylim([375000,378500]);
% 添加标签和标题
xlabel('Grid size (km)','fontsize',15);
ylabel('VAF (mm)','Interpreter','tex','fontsize',15);
% ylabel('VAF (Gt{\cdot}a^{-1})','fontsize',15);
% 添加图例
legend('Structured grids', 'Robust fit','Unstructured grids', 'Location', 'northwest','fontsize',15);
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% 显示图形
grid on;

box on
print(gcf, fullfile(path, 'VAF.png'), '-dpng', '-r1000');