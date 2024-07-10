load('E:\MATLAB\WQX\Project1\30km\InverseRestart.mat')
[GF,GLgeo,~,~]=IceSheetIceShelves(CtrlVarInRestartFile,MUA,GF);
[xGL,yGL]=ArrangeGroundingLinePos(CtrlVarInRestartFile,GLgeo,1);
% xGL=X;yGL=Y;
total_length = 0;
% 遍历接地线坐标点
for i = 1:(length(xGL) - 1)
    x1 = xGL(i);
    y1 = yGL(i);
    x2 = xGL(i + 1);
    y2 = yGL(i + 1);

    % 计算当前线段的长度
    current_length = sqrt((x2 - x1)^2 + (y2 - y1)^2);

    % 将当前线段长度添加到总长度
    total_length = total_length + current_length;

end
% UnstructuredMesh 1.990569751236115e+03   MEaSUREs 1.735730068784874e+03
% 2km 1.933576052700039e+03
% 4km 1.881091234274038e+03
% 5km 1.770556921221009e+03
% 8km 1.690145178784787e+03
% 10km 1.604782448980407e+03
% 16km 1.501418414443787e+03
% 20km 1.522920588287914e+03
% 25km 1.445556530489639e+03
% 30km 1.397123224156366e+03
%%
path = 'E:\MATLAB\WQX\Project1\出图代码\原图直出';
x = [2, 4, 5, 8, 10,16,20,25,30]; % 网格分辨率
y = [1.933576052700039e+03,1.881091234274038e+03,1.770556921221009e+03,1.690145178784787e+03,1.604782448980407e+03,1.501418414443787e+03,1.522920588287914e+03,1.445556530489639e+03,1.397123224156366e+03];
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
y_line1 = 1.990569751236115e+03; % 不规则格网的Mean_diff值
plot([0, 50], [y_line1, y_line1], 'k--', 'LineWidth', 2);
hold on;
y_line2 = 1.735730068784874e+03; % 不规则格网的Mean_diff值
plot([0, 50], [y_line2, y_line2], 'r--', 'LineWidth', 2);
hold on;
patch([x; flipud(x)], [yfit - dy; flipud(yfit + dy)],[0.8, 0.8, 0.8], 'EdgeColor', 'none', 'FaceAlpha', 0.25);

% 设置坐标轴范围
xlim([0,32]);
set(gca,'xtick',[0 2 4 5 8 10 16 20 25 30]);
ylim([1300,2300]);

% 添加标签和标题
xlabel('Grid size (km)','fontsize',15);
ylabel('Main grounding line length (km)','Interpreter','tex','fontsize',15);
% ylabel('VAF (Gt{\cdot}a^{-1})','fontsize',15);
% 添加图例
legend('Structured grids','Robust fit','Unstructured grids','MEaSUREs Antarctica v2', 'Location', 'northwest','fontsize',15);
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% 显示图形
grid on;

box on
print(gcf, fullfile(path, 'GL_Lateral.png'), '-dpng', '-r1000');