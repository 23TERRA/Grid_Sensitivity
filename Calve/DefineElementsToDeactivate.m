function [UserVar,ElementsToBeDeactivated]=DefineElementsToDeactivate(UserVar,RunInfo,CtrlVar,MUA,xEle,yEle,ElementsToBeDeactivated,s,b,S,B,rho,rhow,ub,vb,ud,vd,GF)

x=MUA.coordinates(:,1); y=MUA.coordinates(:,2);

[GF,GLgeo,~,~]=IceSheetIceShelves(CtrlVar,MUA,GF);

[xGL,yGL]=ArrangeGroundingLinePos(CtrlVar,GLgeo,1);

xB=MUA.Boundary.x; yB=MUA.Boundary.y;
idStart = knnsearch([xB yB],[xGL(1) yGL(1)]);
idEnd = knnsearch([xB yB],[xGL(end) yGL(end)]);
xShPoly = [xGL; flipud(xB(idStart:idEnd))];
yShPoly = [yGL; flipud(yB(idStart:idEnd))];

ShelfID = inpoly2([x y], [xShPoly yShPoly]);

ID2 = ShelfID & GF.node > 0.5;
GF.node(ID2) = 0.1;

[GF,~,GLnodes,~]=IceSheetIceShelves(CtrlVar,MUA,GF);

[~,D] = knnsearch([x(GLnodes) y(GLnodes)],[x y]); % distance of node to calving front
CalvingID = zeros(length(x),1);

CalvingID(D > UserVar.CalvingDistance & GF.NodesDownstreamOfGroundingLines) = true;

fprintf('\nCalving ice up to %i km from the GL...\n',UserVar.CalvingDistance/1000);
ElementsToBeDeactivated=MuaElementsContainingGivenNodes(CtrlVar,MUA,find(CalvingID),[],"any");

end