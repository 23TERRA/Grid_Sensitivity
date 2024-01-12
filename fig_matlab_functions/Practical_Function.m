% 读取数据
load('Ua2D_Restartfile.mat','MUA','GF','BCs','CtrlVarInRestartFile')
load('AmeryInverse_ub_vb.mat','AmeryUB','AmeryVB')
CtrlVar=CtrlVarInRestartFile
%% 20230726 绘制漂浮部分的冰架和接地部分的冰盖

% figure ;
% PlotMeshScalarVariable(CtrlVar,MUA,GF.node) ;
% title('The nodal floating mask (floating=0, grounded=1)')

%% 20230726 绘制格网+接地线

% GLgeo=GLgeometry(MUA.connectivity,MUA.coordinates,GF,CtrlVar);
% TRI=[]; DT=[]; xGL=[] ; yGL=[] ;
% figure ; PlotMuaMesh(CtrlVar,MUA);
% hold on
% PlotGroundingLines(CtrlVar,MUA,GF,GLgeo,xGL,yGL,'r');

%% 20230726 有意思的尝试——利用接地线生成新的格网边界并存储，可用这个边界重新的格网（但与崩解后的格网并不完全一致）

% % 将新的格网边界存为.mat文件
% X=xGLele;
% Y=yGLele;
% save('NewMeshBoundary.mat', 'X','Y'); % 将结构体保存为.mat文件

%% 20230726 绘制格网上游区域（接地部分）、下游区域（漂浮部分）以及过渡区

% [GF,GLgeo,GLnodes,GLele]=IceSheetIceShelves(CtrlVar,MUA,GF);
% figure
% PlotMuaMesh(CtrlVar,MUA,GF.ElementsUpstreamOfGroundingLines,'color','k')
% hold on
% PlotMuaMesh(CtrlVar,MUA,GF.ElementsDownstreamOfGroundingLines,'color','b')
% PlotMuaMesh(CtrlVar,MUA,GF.ElementsCrossingGroundingLines,'color','r')

%% 20230726 找到距离接地线指定距离的节点

% figure
% CtrlVar.PlotNodes=0; CtrlVar.WhenPlottingMesh_PlotMeshBoundaryCoordinatesToo=0;
% PlotMuaMesh(CtrlVar,MUA)
% hold on
% [xGL,yGL,GLgeo]=PlotGroundingLines(CtrlVar,MUA,GF,[],[],[],'LineWidth',1);
% ds=5000;
% ID=FindAllNodesWithinGivenRangeFromGroundingLine([],MUA,xGL,yGL,ds) ;
% hold on
% x=MUA.coordinates(:,1); y=MUA.coordinates(:,2);
% plot(x(ID)/CtrlVar.PlotXYscale,y(ID)/CtrlVar.PlotXYscale,'*r')

%% 20230726 绘制完全崩解（只保留接地线后的MUA）后的MUA及边界条件

% [xGLele,yGLele,triGR,FB,xEdge,yEdge,nx,ny,ds]=EleBasedGL(CtrlVar,MUA,GF) ;
% figure ;
% triplot(triGR)    %接地的格网                     % Plot the triangulation of grounded elements
% hold on
% quiver(xEdge,yEdge,nx,ny) ; axis equal ;  % Plot the normals to each grounding-line edges
% plot(xGLele,yGLele,'r','LineWidth',2)                   % Plot the grounding line edges
% plot(xEdge,yEdge,'.g')                    % Plot centre points of each grounding-line edge

%% 20230726 存储崩解后的MUA

% [xGLele,yGLele,triGR,FB,xEdge,yEdge,nx,ny,ds]=EleBasedGL(CtrlVar,MUA,GF) ;
% MUA_SHEET = CreateMUA(CtrlVar,triGR.ConnectivityList,triGR.Points);
% save('WQXMesh_Sheet.mat','MUA_SHEET');
% figure ; PlotMuaMesh(CtrlVar,MUA_SHEET);

%% 20230727 计算接地线通量GLF

% load('AmeryInverse_ub_vb.mat','AmeryUB','AmeryVB');
% load('C:\Users\TERRA\Documents\MATLAB\WQX\SHP\AmeryData\AmeryGeometryInterpolantWQX_BMAV3.mat','AmeryThicknessBMAV3')
% ub=AmeryUB.Values;
% vb=AmeryVB.Values;
% rho=910*ones(70687, 1);  %需和网格大小对应
% ud=0;
% vd=0;
% x=MUA.coordinates(:,1);
% y=MUA.coordinates(:,2);
% h=AmeryThicknessBMAV3(x, y);
% 
% [qGL,qGLx,qGLy,Fub,Fvb,Fr,Fh,LakeNodes,GLgeo,ubGL,vbGL]=FluxAcrossGroundingLine(CtrlVar,MUA,GF,ub,vb,ud,vd,h,rho);
% PlotMuaMesh(CtrlVar,MUA) ; hold on ; 
% plot(GLgeo(:,[3 4])'/CtrlVar.PlotXYscale,GLgeo(:,[5 6])'/CtrlVar.PlotXYscale,'g','LineWidth',2); 
% scale=1; hold on ;  quiver(GLgeo(:,7)/CtrlVar.PlotXYscale,GLgeo(:,8)/CtrlVar.PlotXYscale,qGLx,qGLy,scale,'color','r') ; 
% axis equal
% dsGL=sqrt((GLgeo(:,3)-GLgeo(:,4)).^2+(GLgeo(:,5)-GLgeo(:,6)).^2);
% scatter(GLgeo(:,7)/CtrlVar.PlotXYscale,GLgeo(:,8)/CtrlVar.PlotXYscale,dsGL/CtrlVar.PlotXYscale) ; 

%% 20230804 绘制主接地线

% GLgeo=GLgeometry(MUA.connectivity,MUA.coordinates,GF,CtrlVar);
% TRI=[]; DT=[];
% xa=GLgeo(:,3) ;  xb=GLgeo(:,4) ; ya=GLgeo(:,5) ;  yb=GLgeo(:,6) ;
% [xGL,yGL]=LineUpEdges2([],xa,xb,ya,yb);
% figure ; PlotMuaMesh(CtrlVar,MUA);
% hold on
% AA=5832
% plot(xGL(1:AA)/CtrlVar.PlotXYscale,yGL(1:AA)/CtrlVar.PlotXYscale,'r','LineWidth',2) ;  %绘制主接地线
% figure ; PlotMuaMesh(CtrlVar,MUA);
% plot(xGL/CtrlVar.PlotXYscale,yGL/CtrlVar.PlotXYscale,'r','LineWidth',2) ; %绘制所有接地线

%% 20230824 绘制流线

figure ;  PlotMuaMesh(CtrlVar,MUA);
xA=1450000;
yA=650000;
hold on
flowline(xA,yA,8000,'plotxy','r','LineWidth', 2);


% xB=1910000;
% yB=897000;
% hold on
% flowline(xB,yB,8000,'plotxy','r');

xB = 2080000;
yB = 840000;
vertical_length = 215000; % 设置一个垂直的长度

XX = [xB, xB];
YY = [yB, yB - vertical_length];

hold on;
plot(XX/1000, YY/1000, 'r', 'LineWidth', 2);

GLgeo=GLgeometry(MUA.connectivity,MUA.coordinates,GF,CtrlVar);
TRI=[]; DT=[]; xGL=[] ; yGL=[] ;
hold on
PlotGroundingLines(CtrlVar,MUA,GF,GLgeo,xGL,yGL,'r');

%% 20230828 流线高级操作

xA=1450000;
yA=650000;
figure ;  PlotMuaMesh(CtrlVar,MUA);
[lat,lon]=flowline(xA,yA,8000,'plotxy','r');
[x,y] = ll2ps(lat,lon); 

% 经纬度与投影互相转化  xy与latlon
% 方法1：[x,y] = ll2ps(lat,lon); 
% 方法2： 
% epsgCode = 3031; %定义EPSG代码
% proj = projcrs(epsgCode);%创建投影坐标系结构体
% [x, y] = projfwd(proj, lat, lon);%将经纬度坐标转换为投影坐标

sfz = bedmachine_interp('surface',x,y);

% Calculate distance along the flowline in kilometers:
d = pathdistps(x,y,'km');

% 从流速场中提取流速值
ub_values = AmeryUB(x, y);
vb_values = AmeryVB(x, y);
speed=sqrt(ub_values.*ub_values+vb_values.*vb_values);

figure
% 使用左侧竖轴绘制地形图
yyaxis left;
bedmachine_profile(x,y);
ylabel('Elevation (m)');
plot(d, sfz, 'b', 'linewidth', 2, 'DisplayName', 'Surface Elevation');
% legend('-DynamicLegend'); % 创建动态图例


% 使用右侧竖轴绘制流速图
yyaxis right;
plot(d, speed, 'r', 'linewidth', 2, 'DisplayName', 'Flow Velocity');
ylabel('Flow Velocity (m/year)');

% 设置 x 轴标签
xlabel('Distance along flowline (km)');

% 标题
title('Elevation and Flow Velocity along Flowline');

% 最终显示图例
% legend('show');

