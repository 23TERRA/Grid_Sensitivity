path='E:\MATLAB\WQX\Project1\30km';
path1= 'E:\MATLAB\WQX\Project1\出图代码\原图直出';
load(fullfile(path, 'InverseRestart.mat'));

figure
set(gcf,'color','w','position',[500 200 650 600]);
PlotMeshScalarVariable(CtrlVarInRestartFile,MUA,log10(F.AGlen));
hold on ;

[~,GLgeo,~,~]=IceSheetIceShelves(CtrlVarInRestartFile,MUA,GF);
[xGL,yGL]=ArrangeGroundingLinePos(CtrlVarInRestartFile,GLgeo,1);
plot(xGL/CtrlVarInRestartFile.PlotXYscale,yGL/CtrlVarInRestartFile.PlotXYscale,'k','LineWidth',2) ;  %绘制主接地线
PlotMuaBoundary(CtrlVarInRestartFile,MUA,'b')
% title(sprintf('log_{10}(AGlen) t=%-g ',CtrlVar.time)) ; xlabel('x (km)') ; ylabel('y (km)')
% title(colorbar,'log_{10}(yr^{-1} kPa^{-3})')

% xlabel('xps (km)','FontSize', 15,'fontname','time news roman')
% ylabel('yps (km)','FontSize', 15,'fontname','time news roman')
xlim([1672.1304186886 2249.56167457682]);
ylim([445.872800080901 1006.39663954361]);
set(gca, 'FontSize', 15,'fontname','time news roman'); % 将字体大小设置为12或你想要的大小
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
title(colorbar, 'log(AGlen)\newline/(a^{-1} kPa^{-3})', 'FontSize', 15)
caxis([-10 -5]) 
% axis off;
% cbar = colorbar;
% delete(cbar);
box on
print(gcf, fullfile(path1, 'AGlen_30km_detail.png'), '-dpng', '-r1000');



%%
figure
set(gcf,'color','w','position',[500 200 650 600]);
PlotMeshScalarVariable(CtrlVarInRestartFile,MUA,log10(F.C));
hold on ;
plot(xGL/CtrlVarInRestartFile.PlotXYscale,yGL/CtrlVarInRestartFile.PlotXYscale,'k','LineWidth',2) ;  %绘制主接地线
PlotMuaBoundary(CtrlVarInRestartFile,MUA,'b')
% title(sprintf('log_{10}(AGlen) t=%-g ',CtrlVar.time)) ; xlabel('x (km)') ; ylabel('y (km)')
% title(colorbar,'log_{10}(yr^{-1} kPa^{-3})')

% xlabel('xps (km)','FontSize', 15,'fontname','time news roman')
% ylabel('yps (km)','FontSize', 15,'fontname','time news roman')
xlim([1672.1304186886 2249.56167457682]);
ylim([445.872800080901 1006.39663954361]);
set(gca, 'FontSize', 15,'fontname','time news roman'); % 将字体大小设置为12或你想要的大小
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
title(colorbar, 'log(C)\newline/(m a^{-1} kPa^{-3})', 'FontSize', 15)
caxis([-6 0]) 
% axis off;
% cbar = colorbar;
% delete(cbar);
box on
print(gcf, fullfile(path1, 'C_30km_detail.png'), '-dpng', '-r1000');

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