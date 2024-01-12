% path1='C:\Users\TERRA\Documents\MATLAB\WQX\反演\网格敏感性实验\ADD_Experiment\不规则格网';
% X1=load(fullfile(path1, 'IR-Inverse-UaOptimization-Nod3-I-Adjoint-Cga0k000010-Cgs0k010000-Aga0k000010-Ags0k010000-m3--logA-logC-.mat'));
% Y1=load(fullfile(path1, 'GroundingLines.mat'));
% [VAF1,IceVolume,GroundedArea,hAF,hfPos]=CalcVAF(Y1.CtrlVar,Y1.MUA,X1.F.h,X1.F.B,X1.F.S,X1.F.rho,X1.F.rhow,Y1.GF);
% fprintf("VAF=%f (Gt/yr)\n",VAF1.Total/1e9)   ; 


% 30km 3.7543e+05 
% 25km 3.7636e+05
% 20km 3.7658e+05
% 16km 3.7751e+05
% 10km 3.7696e+05
% 8km  3.7671e+05
% 5km  3.7666e+05
% 4km  3.7682e+05
% 2km  3.7678e+05
% Nonuniform  3.7670e+05
%%

path = 'C:\Users\TERRA\Desktop\results';

resolutions = [2, 4, 5, 8, 10,16,20,25,30]; % 网格分辨率
VAF_values=[3.7678e+05,3.7682e+05,3.7666e+05,3.7671e+05,3.7696e+05,3.7751e+05,3.7658e+05,3.7636e+05,3.7543e+05]/361.8;
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
hold on;
plot(x_fit, y_fit, 'r', 'LineWidth', 2);

hold on;
y_line = 3.7670e+05/361.8; % 不规则格网的Mean_diff值
plot([0, 50], [y_line, y_line], 'k--', 'LineWidth', 2);
hold on;
% 绘制拟合误差阴影
fill([x_fit, fliplr(x_fit)], [y_fit + se, fliplr(y_fit - se)], [0.8, 0.8, 0.8], 'FaceAlpha', 0.25, 'EdgeColor', 'none');
% 设置坐标轴范围
xlim([0,32]);
set(gca,'xtick',[0 2 4 5 8 10 16 20 25 30]);
% ylim([375000,378500]);
% 添加标签和标题
xlabel('Grid size (km)','fontsize',15);
ylabel('VAF (mm)','Interpreter','tex','fontsize',15);
% ylabel('VAF (Gt{\cdot}a^{-1})','fontsize',15);
% 添加图例
legend('Uniform grids', 'Robust fit','Nonuniform grids', 'Location', 'northwest','fontsize',15);
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% 显示图形
grid on;

box on
print(gcf, fullfile(path, 'VAF.png'), '-dpng', '-r1000');