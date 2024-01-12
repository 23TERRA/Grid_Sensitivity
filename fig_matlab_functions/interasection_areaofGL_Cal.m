path='C:\Users\TERRA\Documents\MATLAB\WQX\反演\网格敏感性实验';
load(fullfile(path, 'ADD_Experiment\30km\GroundingLines.mat'),'MUA','CtrlVar','GF');
load(fullfile(path, 'GL_Amery.mat'),'X','Y');

GLgeo=GLgeometry(MUA.connectivity,MUA.coordinates,GF,CtrlVar);
TRI=[]; DT=[];
xa=GLgeo(:,3) ;  xb=GLgeo(:,4) ; ya=GLgeo(:,5) ;  yb=GLgeo(:,6) ;
[xGL,yGL]=LineUpEdges2([],xa,xb,ya,yb);
figure ; PlotMuaMesh(CtrlVar,MUA);
hold on
% AA=55555;
% plot(xGL(1:AA)/CtrlVar.PlotXYscale,yGL(1:AA)/CtrlVar.PlotXYscale,'r','LineWidth',2) ;  %绘制主接地线
plot(xGL/CtrlVar.PlotXYscale,yGL/CtrlVar.PlotXYscale,'r','LineWidth',2) ;  %绘制主接地线
hold on
plot(X/CtrlVar.PlotXYscale,Y/CtrlVar.PlotXYscale,'cyan','LineWidth',2) ;  %绘制主接地线
% X_Inverse=xGL(1:AA);
% Y_Inverse=yGL(1:AA);
X_Inverse=xGL;
Y_Inverse=yGL;

% 
% 
% 计算两个多边形的相交区域   上边界
% [x_intersect1, y_intersect1] = polybool('union', X_Inverse, Y_Inverse, X, Y);
% 
% % 构建相交区域的多边形
% intersection_polygon1 = [x_intersect1/1000, y_intersect1/1000];
% 
% hold on
% plot(intersection_polygon1(:, 1), intersection_polygon1(:, 2), 'y', 'LineWidth', 5);
% 
% 
% % 计算两个多边形的相交区域   下边界
% [x_intersect2, y_intersect2] = polybool('intersection', X_Inverse, Y_Inverse, X, Y);
% 
% % 构建相交区域的多边形
% intersection_polygon2 = [x_intersect2/1000, y_intersect2/1000];
% 
% hold on
% plot(intersection_polygon2(:, 1), intersection_polygon2(:, 2), 'b', 'LineWidth', 5);
% 
% % 找到与点 A 最接近的序列号
% x=2222650;
% y=804713;
% epsilon = 5;  % 允许的数值差异
% idx = find(abs(x_intersect1 - x) < epsilon & abs(y_intersect1 - y) < epsilon);
% 
% if ~isempty(idx)
%     % 打印序列号
%     fprintf('点 A 在数据中的序列号是：%d\n', idx);
% else
%     fprintf('未找到匹配的点 A。\n');
% end
% 
% % 创建一个索引向量，包括要保留的点
% index_to_keep = setdiff(1:length(x_intersect1), [101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120]);
% 
% % 使用索引向量来获取新的多边形顶点坐标
% X_new = x_intersect1(index_to_keep)/1000;
% Y_new = y_intersect1(index_to_keep)/1000;
% plot(X_new, Y_new, 'r', 'LineWidth', 5);
% 
% 
% index_to_keep2 = setdiff(1:length(x_intersect2), [55555]);
% 
% % 使用索引向量来获取新的多边形顶点坐标
% X_new2 = x_intersect2(index_to_keep2)/1000;
% Y_new2 = y_intersect2(index_to_keep2)/1000;
% plot(X_new2, Y_new2, 'cyan', 'LineWidth', 5);
% 
% % 计算相交区域的面积
% intersection_area1 = polyarea(X_new, Y_new);
% intersection_area2 = polyarea(X_new2, Y_new2);
% intersection_area=intersection_area1-intersection_area2;
% % 输出结果
% fprintf('相交区域的面积 = %.2f\n', intersection_area);
% 
% front_width = [max(Y) - min(Y)]/1000;
% fprintf('Amery冰架宽度 = %.2f\n', front_width);
% 
% A_over_F = intersection_area / front_width;
% fprintf('A/F 的值 = %.2f\n', A_over_F);


% 不规则格网 相交区域的面积 = 1228.96   Amery冰架宽度 = 220.01    A/F 的值 = 5.59;
% 2km 相交区域的面积 = 1364.79 Amery冰架宽度 = 220.01 A/F 的值 = 6.20;
% 4km 相交区域的面积 = 1875.83 Amery冰架宽度 = 220.01 A/F 的值 = 8.53;
% 5km 相交区域的面积 = 2142.58 Amery冰架宽度 = 220.01 A/F 的值 = 9.74;
% 8km 相交区域的面积 = 3069.96 Amery冰架宽度 = 220.01 A/F 的值 = 13.95;
% 10km 相交区域的面积 = 3514.28 Amery冰架宽度 = 220.01 A/F 的值 = 15.97;
% 16km 相交区域的面积 = 5106.76 Amery冰架宽度 = 220.01 A/F 的值 = 23.21
% 20km 相交区域的面积 = 7343.21 Amery冰架宽度 = 220.01 A/F 的值 = 33.38
% 25km 相交区域的面积 = 6801.02 Amery冰架宽度 = 220.01 A/F 的值 = 30.91
% 30km 相交区域的面积 = 10066.82 Amery冰架宽度 = 220.01 A/F 的值 = 45.76
%% 1.shp2mat
% path='D:\Quantarctica3\Glaciology\MEaSUREs Antarctic Boundaries';
% shp = shaperead(fullfile(path, 'GroundingLine_Antarctica_v2.shp'));
% save('GL_Antarctica.mat', 'shp');

%%  2.找最近的点
% % 找到与点 A 最接近的序列号
% x=2227580;
% y=807719;
% epsilon = 500;  % 允许的数值差异
% idx = find(abs(XX - x) < epsilon & abs(YY - y) < epsilon);
% 
% if ~isempty(idx)
%     % 打印序列号
%     fprintf('点 A 在数据中的序列号是：%d\n', idx);
% else
%     fprintf('未找到匹配的点 A。\n');
% end

%% 3.存成GL_Amery
% path1='C:\Users\TERRA\Documents\MATLAB\WQX\反演\网格敏感性实验';
% load(fullfile(path1, 'GL_Antarctica.mat'),'shp');
% figure
% PlotMuaMesh(CtrlVar,MUA);
% XX=shp.X;
% YY=shp.Y;
% plot(XX(25060:25843)/CtrlVar.PlotXYscale,YY(25060:25843)/CtrlVar.PlotXYscale,'r','LineWidth',2) ;   % (2129.3,620.126)   25843     (2227.58,807.719) 25060
% X=[XX(25060:25843)]';
% Y=[YY(25060:25843)]';
% save('GL_Amery.mat','X','Y');
