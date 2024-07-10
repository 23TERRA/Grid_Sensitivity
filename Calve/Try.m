CtrlVar=CtrlVarInRestartFile;
UserVar=UserVarInRestartFile;
x=MUA.coordinates(:,1); y=MUA.coordinates(:,2);

[GF,GLgeo,~,~]=IceSheetIceShelves(CtrlVar,MUA,GF);

[xGL,yGL]=ArrangeGroundingLinePos(CtrlVar,GLgeo,1);
% 
% xB=MUA.Boundary.x; yB=MUA.Boundary.y;
% idStart = knnsearch([xB yB],[xGL(1) yGL(1)]);
% idEnd = knnsearch([xB yB],[xGL(end) yGL(end)]);
% xShPoly = [xGL; flipud(xB(idStart:idEnd))];
% yShPoly = [yGL; flipud(yB(idStart:idEnd))];
% 
% ShelfID = inpoly2([x y], [xShPoly yShPoly]);
% 
% ID2 = ShelfID & GF.node > 0.5;
% GF.node(ID2) = 0.1;
% 
% [GF,~,GLnodes,~]=IceSheetIceShelves(CtrlVar,MUA,GF);
% 
% [~,D] = knnsearch([x(GLnodes) y(GLnodes)],[x y]); % distance of node to calving front
% CalvingID = zeros(length(x),1);
% %%
% UserVar.CalvingDistance = 10000;
% CalvingID(D > UserVar.CalvingDistance & GF.NodesDownstreamOfGroundingLines) = true;
% 
% fprintf('\nCalving ice up to %i km from the GL...\n',UserVar.CalvingDistance/1000);
% ElementsToBeDeactivated=MuaElementsContainingGivenNodes(CtrlVar,MUA,find(CalvingID),[],"any");

%%
figure
set(gcf,'color','w','position',[500 200 650 600]);
PlotMuaMesh(CtrlVar,MUA,[],'k') ;  
% hold on ; PlotMuaMesh(CtrlVar,MUA,ElementsToBeDeactivated,'r') ;

hold on;
plot(xGL/CtrlVar.PlotXYscale,yGL/CtrlVar.PlotXYscale,'r','LineWidth',2) ;
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
xlim([1672.1304186886 2249.56167457682]);
ylim([445.872800080901 1006.39663954361]);
box on
print(gcf, 'After_Calving100.png', '-dpng', '-r1000');
%%
% [qGL,qGLx,qGLy,Fub,Fvb,Fr,Fh,LakeNodes,GLgeo,ubGL,vbGL]=FluxAcrossGroundingLine(CtrlVar,MUA,GF,F.ub,F.vb,F.ud,F.vd,F.h,F.rho);  %1281.35 70.88
% fluxGL = sum(qGL)/10e+11;
% fprintf('fluxGL=%i\n',fluxGL)
% %  0                 1.0562e+09               1.2929e+12
% % 10 1.001889e+03     1.4804e+10
% % 20 1.513116e+02    2.6165e+10
% % 30 1.373992e+02      3.4831e+10
% % 40 1.109970e+02    4.3091e+10
% % 50 7.241846e+01    4.9293e+10
% % 60 7.132259e+01    5.2623e+10
% % 70 7.106162e+01     5.5368e+10
% % 80 7.088113e+01    5.7497e+10
% % 90 7.085452e+01    5.9088e+10
% % 100 7.086098e+01   6.0231e+10
% % 110 7.086858e+01   6.1009e+10
% % 120 7.086901e+01

% 6.1314e+10
% 总面积：1.3545e+12
% 接地总面积：1.2939e+12
% 崩解掉面积
% 6.0584e+10,4.6760e+10,3.5303e+10,2.6501e+10,1.8201e+10,1.1998e+10,8.6691e+09,5.9237e+09,3.7949e+09,2.2041e+09,1.0607e+09,2.8297e+08
