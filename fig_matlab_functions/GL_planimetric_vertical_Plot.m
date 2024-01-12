% 20230804 TERRA 计算GLF（看看量级是否正确）

path = 'C:\Users\TERRA\Documents\MATLAB\WQX\反演\网格敏感性实验\ADD_Experiment';
X2km=load(fullfile(path, '2km\AmeryObserve_ub_vb.mat'));
Y2km=load(fullfile(path, '30km\AmeryInverse_ub_vb.mat'));
load(fullfile(path, '不规则格网\GroundingLines.mat'),'CtrlVar','MUA','GF','yGL','xGL');

path2='C:\Users\TERRA\Documents\MATLAB\WQX\反演\网格敏感性实验';
load(fullfile(path2, 'GL_Amery.mat'),'X','Y');

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

% AAA=find(isnan(xGL));
% x=xGL(1:AAA-1);
% y=yGL(1:AAA-1);
% x=xGL;
% y=yGL;
x=X;
y=Y;
[~,~,~,Oceanwater,GL_Length]=bedmachine_profile(x,y);
figure ;  PlotMuaMesh(CtrlVar,MUA);
% 观测主接地线长度: 1.739418e+03 km                  借助Chad计算的主接地线长度： 1.7387e+03 km  海水面积：61.2849 km^2
% Nonuniform 1.9682e+03 km海水高度求和：           m 借助Chad计算的主接地线长度： 1.9673e+03 km  海水面积：18.8340 km^2
% 2km 1.8542e+03 km       海水高度求和：4.1296e+04 m 借助Chad计算的主接地线长度： 1.8534e+03 km  海水面积：25.0423 km^2
% 4km 1.8079e+03 km       海水高度求和：4.2242e+04 m 借助Chad计算的主接地线长度： 1.8072e+03 km  海水面积：49.3652 km^2
% 5km 1.7213e+03 km       海水高度求和：2.8289e+04 m 借助Chad计算的主接地线长度： 1.7206e+03 km  海水面积：45.0321 km^2
% 8km 1.7741e+03 km       海水高度求和：3.2380e+04 m 借助Chad计算的主接地线长度： 1.7734e+03 km  海水面积：79.6142 km^2
% 10km 1.6614e+03 km      海水高度求和：2.7576e+04 m 借助Chad计算的主接地线长度： 1.6610e+03 km  海水面积：85.7401 km^2
% 16km 1.5372e+03 km      海水高度求和：2.1349e+04 m 借助Chad计算的主接地线长度： 1.5370e+03 km  海水面积：111.9473 km^2
% 20km 1.4610e+03 km      海水高度求和：2.6069e+04 m 借助Chad计算的主接地线长度： 1.4609e+03 km  海水面积：159.3545 km^2
% 25km 1.3361e+03 km      海水高度求和：1.4468e+04 m 借助Chad计算的主接地线长度： 1.3364e+03 km  海水面积：120.5529 km^2
% 30km 1.4677e+03 km      海水高度求和：1.0374e+04 m 借助Chad计算的主接地线长度： 1.4675e+03 km  海水面积：109.9321 km^2
%%
% x=X;
% y=Y;
% 初始化总长度
total_length = 0;
min_length = 1000;
start_point = [];
end_point = [];
% 遍历接地线坐标点
for i = 1:(length(x) - 1)
    x1 = x(i);
    y1 = y(i);
    x2 = x(i + 1);
    y2 = y(i + 1);

    % 计算当前线段的长度
    current_length = sqrt((x2 - x1)^2 + (y2 - y1)^2);

    % 将当前线段长度添加到总长度
    total_length = total_length + current_length;

     % 检查是否是最长的线段
    if current_length < min_length && current_length > 0
        min_length = current_length;
        start_point = [x1, y1];
        end_point = [x2, y2];
        k=i;
    end
end


fprintf('总接地线长度: %d km\n', total_length/1000);

%% 接地线模拟纵向指标

path = 'C:\Users\TERRA\Desktop\results';

resolutions = [2, 4, 5, 8, 10,16,20,25,30]; % 网格分辨率
GL_values=[25.0423,49.3652,45.0321,79.6142,85.7401,111.9473,159.3545,120.5529,109.9321]/220.01;
% Mean_Diff 不规则格网10.5498 
% 绘制散点图  
% figure('units', 'centimeters', 'position', [18, 8, 17, 8.5]);
figure
set(gcf,'color','w','position',[500 200 650 600]);
scatter(resolutions, GL_values, 100, 'b', 'filled'); % 'b'代表蓝色，'filled'填充点

% 拟合曲线（这里使用二次多项式）
% p = polyfit(resolutions(1:end), GL_values(1:end), 1); 
% 拟合曲线（这里使用robustfit）
[b, stats] = robustfit(resolutions, GL_values);
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
y_line1 = 18.8340/220.01; % 不规则格网的Mean_diff值
plot([0, 50], [y_line1, y_line1], 'k--', 'LineWidth', 2);

hold on;
y_line2 = 61.2849/220.01; % 不规则格网的Mean_diff值
plot([0, 50], [y_line2, y_line2], 'r--', 'LineWidth', 2);
hold on;
% 绘制拟合误差阴影
fill([x_fit, fliplr(x_fit)], [y_fit + se, fliplr(y_fit - se)], [0.8, 0.8, 0.8], 'FaceAlpha', 0.25, 'EdgeColor', 'none');
% 设置坐标轴范围
xlim([0,32]);
set(gca,'xtick',[0 2 4 5 8 10 16 20 25 30]);
% ylim([0,180]);

% 添加标签和标题
xlabel('Grid size (km)','fontsize',15);
ylabel('Normalized non-sealing GL error (km)','Interpreter','tex','fontsize',15);
% ylabel('VAF (Gt{\cdot}a^{-1})','fontsize',15);
% 添加图例
legend('Uniform grids','Robust fit','Nonuniform grids','MEaSUREs Antarctica v2', 'Location', 'northwest','fontsize',15);
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% 显示图形
grid on;

box on
print(gcf, fullfile(path, 'GL_Vertical.png'), '-dpng', '-r1000');

%% 接地线模拟横向指标

path = 'C:\Users\TERRA\Desktop\results';

resolutions = [2, 4, 5, 8, 10,16,20,25,30]; % 网格分辨率
GL_values=[1.8534e+03,1.8072e+03,1.7206e+03,1.7734e+03,1.6610e+03,1.5370e+03,1.4609e+03,1.3364e+03,1.4675e+03];
% Mean_Diff 不规则格网10.5498 
% 绘制散点图  
% figure('units', 'centimeters', 'position', [18, 8, 17, 8.5]);
figure
set(gcf,'color','w','position',[500 200 650 600]);
scatter(resolutions, GL_values, 100, 'b', 'filled'); % 'b'代表蓝色，'filled'填充点

% % 拟合曲线（这里使用二次多项式）
% p = polyfit(resolutions(1:end-1), GL_values(1:end-1), 1); % 3表示3次多项式拟合
% 
% % 生成拟合曲线的x值范围
% x_fit = linspace(0, 32, 100);
% 
% % 计算拟合曲线的y值
% y_fit = polyval(p, x_fit);

% 拟合曲线（这里使用二次多项式）
% p = polyfit(resolutions(1:end), GL_values(1:end), 1); 
% 拟合曲线（这里使用robustfit）
[b, stats] = robustfit(resolutions, GL_values);
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
y_line1 = 1.9673e+03; % 不规则格网的Mean_diff值
plot([0, 50], [y_line1, y_line1], 'k--', 'LineWidth', 2);

hold on;
y_line2 = 1.7387e+03; % 不规则格网的Mean_diff值
plot([0, 50], [y_line2, y_line2], 'r--', 'LineWidth', 2);
hold on;
% 绘制拟合误差阴影
fill([x_fit, fliplr(x_fit)], [y_fit + se, fliplr(y_fit - se)], [0.8, 0.8, 0.8], 'FaceAlpha', 0.25, 'EdgeColor', 'none');
% 设置坐标轴范围
xlim([0,32]);
set(gca,'xtick',[0 2 4 5 8 10 16 20 25 30]);
ylim([1300,2200]);

% 添加标签和标题
xlabel('Grid size (km)','fontsize',15);
ylabel('Main grounding line length (km)','Interpreter','tex','fontsize',15);
% ylabel('VAF (Gt{\cdot}a^{-1})','fontsize',15);
% 添加图例
legend('Uniform grids','Robust fit','Nonuniform grids','MEaSUREs Antarctica v2', 'Location', 'northwest','fontsize',15);
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% 显示图形
grid on;

box on
print(gcf, fullfile(path, 'GL_Lateral.png'), '-dpng', '-r1000');
%%

ub_values2kmObs = X2km.AmeryUBO(x, y);
vb_values2kmObs = X2km.AmeryVBO(x, y);
speed2kmObs=sqrt(ub_values2kmObs.*ub_values2kmObs+vb_values2kmObs.*vb_values2kmObs);

ub_values2kmInv = Y2km.AmeryUB(x, y);
vb_values2kmInv = Y2km.AmeryVB(x, y);
speed2kmInv=sqrt(ub_values2kmInv.*ub_values2kmInv+vb_values2kmInv.*vb_values2kmInv);

speed2km=speed2kmInv-speed2kmObs;
d = pathdistps(x,y,'km');
% figure ;  
% set(gcf,'color','w','position',[500 200 650 600]);
% PlotMuaMesh(CtrlVar,MUA) ; hold on ; 
% plot(x/CtrlVar.PlotXYscale,y/CtrlVar.PlotXYscale,'g','LineWidth',2); 


figure('units', 'centimeters', 'position', [18, 8, 17, 10]);
% 使用左侧竖轴绘制地形图
yyaxis left;
[~,~,~,Oceanwater_height]=bedmachine_profile(x,y);
ylabel('Elevation (m)','FontSize', 10);

% 使用右侧竖轴绘制流速图
yyaxis right;
plot(d,speed2km,'color', C(1,:),'LineWidth',2,'DisplayName', '30 km');
ylabel('Velocity(mod-obs) (m{\cdot}a^{-1})','FontSize', 10);
% 设置 x 轴标签
xlabel('Distance along GL (km)','FontSize', 10);
% % 最终显示图例
legend('Location', 'northwest','fontsize',10);
legend('show');
set(gca,'linewidth',1,'fontsize',10,'fontweight','normal','fontname','time news roman');

box on
% print(gcf, fullfile(path1, 'Iteration1_4km.png'), '-dpng', '-r1000');
%% 结果： sum(qGL)=73.7441Gt/a    SLR=0.2038mm/a  sum(qGL)/10e+11 sum(qGL)/10e+11/361.8

path = 'C:\Users\TERRA\Documents\MATLAB\WQX\反演\网格敏感性实验';
path1= 'C:\Users\TERRA\Desktop\results';
load(fullfile(path, 'ADD_Experiment\2km\GroundingLines.mat'),'CtrlVar','MUA','GF','yGL','xGL');
load(fullfile(path1, 'GL_Amery.mat'),'X','Y');
figure ;  
set(gcf,'color','w','position',[500 200 650 600]);
PlotMuaMesh(CtrlVar,MUA) ; hold on ; 
plot(X/CtrlVar.PlotXYscale,Y/CtrlVar.PlotXYscale,'g','LineWidth',2); 

AAA=find(isnan(xGL));
x=xGL(1:AAA-1);
y=yGL(1:AAA-1);


hold on ; 
plot(x/CtrlVar.PlotXYscale,y/CtrlVar.PlotXYscale,'r','LineWidth',2); 

total_length = 0;
% 遍历接地线坐标点
for i = 1:(length(x) - 1)
    x1 = x(i);
    y1 = y(i);
    x2 = x(i + 1);
    y2 = y(i + 1);

    % 计算当前线段的长度
    current_length = sqrt((x2 - x1)^2 + (y2 - y1)^2);

    % 将当前线段长度添加到总长度
    total_length = total_length + current_length;

end

