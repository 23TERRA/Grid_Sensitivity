path='C:\Users\TERRA\Documents\MATLAB\WQX\反演\网格敏感性实验\ADD_Experiment';
path1= 'C:\Users\TERRA\Desktop\results';
load(fullfile(path, '不规则格网\IR-Inverse-UaOptimization-Nod3-I-Adjoint-Cga0k000010-Cgs0k010000-Aga0k000010-Ags0k010000-m3--logA-logC-.mat'),'F');
load(fullfile(path, 'GroundingLines.mat'),'MUA','CtrlVar','xGL','yGL');

figure
set(gcf,'color','w','position',[500 200 650 600]);
PlotMeshScalarVariable(CtrlVar,MUA,log10(F.AGlen));
hold on ;
AA=5832;
plot(xGL(1:AA)/CtrlVar.PlotXYscale,yGL(1:AA)/CtrlVar.PlotXYscale,'k','LineWidth',2) ;  %绘制主接地线
PlotMuaBoundary(CtrlVar,MUA,'b')
% title(sprintf('log_{10}(AGlen) t=%-g ',CtrlVar.time)) ; xlabel('x (km)') ; ylabel('y (km)')
% title(colorbar,'log_{10}(yr^{-1} kPa^{-3})')

xlabel('xps (km)','FontSize', 15,'fontname','time news roman')
ylabel('yps (km)','FontSize', 15,'fontname','time news roman')

set(gca, 'FontSize', 15,'fontname','time news roman'); % 将字体大小设置为12或你想要的大小
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
title(colorbar, 'log(AGlen)\newline/(a^{-1} kPa^{-3})', 'FontSize', 15)

box on
print(gcf, fullfile(path1, 'AGlen.png'), '-dpng', '-r1000');

figure
set(gcf,'color','w','position',[500 200 650 600]);
PlotMeshScalarVariable(CtrlVar,MUA,log10(F.C));
hold on ;
AA=5832;
plot(xGL(1:AA)/CtrlVar.PlotXYscale,yGL(1:AA)/CtrlVar.PlotXYscale,'k','LineWidth',2) ;  %绘制主接地线
PlotMuaBoundary(CtrlVar,MUA,'b')
% title(sprintf('log_{10}(AGlen) t=%-g ',CtrlVar.time)) ; xlabel('x (km)') ; ylabel('y (km)')
% title(colorbar,'log_{10}(yr^{-1} kPa^{-3})')

xlabel('xps (km)','FontSize', 15,'fontname','time news roman')
ylabel('yps (km)','FontSize', 15,'fontname','time news roman')

set(gca, 'FontSize', 15,'fontname','time news roman'); % 将字体大小设置为12或你想要的大小
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
title(colorbar, 'log(C)\newline/(m a^{-1} kPa^{-3})', 'FontSize', 15)

box on
print(gcf, fullfile(path1, 'C.png'), '-dpng', '-r1000');

% figure
% PlotMeshScalarVariable(CtrlVar,MUA,F.B);
% hold on ;
% AA=5832;
% plot(xGL(1:AA)/CtrlVar.PlotXYscale,yGL(1:AA)/CtrlVar.PlotXYscale,'r','LineWidth',2) ;  %绘制主接地线
% PlotMuaBoundary(CtrlVar,MUA,'b')
% % title(sprintf('log_{10}(AGlen) t=%-g ',CtrlVar.time)) ; xlabel('x (km)') ; ylabel('y (km)')
% % title(colorbar,'log_{10}(yr^{-1} kPa^{-3})')
% 
% title('底部地形','FontSize',20 ); xlabel('x (km)','FontSize',17) ; ylabel('y (km)','FontSize',17)
% title(colorbar,'底部高程(m)','FontSize',12)
% caxis([-1000, 1000]);

% figure
% PlotMeshScalarVariable(CtrlVar,MUA,F.s-F.B);
% hold on ;
% AA=5832;
% plot(xGL(1:AA)/CtrlVar.PlotXYscale,yGL(1:AA)/CtrlVar.PlotXYscale,'r','LineWidth',2) ;  %绘制主接地线
% PlotMuaBoundary(CtrlVar,MUA,'b')
% % title(sprintf('log_{10}(AGlen) t=%-g ',CtrlVar.time)) ; xlabel('x (km)') ; ylabel('y (km)')
% % title(colorbar,'log_{10}(yr^{-1} kPa^{-3})')
% 
% title('冰厚','FontSize',20 ); xlabel('x (km)','FontSize',17) ; ylabel('y (km)','FontSize',17)
% title(colorbar,'冰厚(m)','FontSize',12)
% caxis([0, 300]);