function  UserVar=DefineOutputs(UserVar,CtrlVar,MUA,BCs,F,l,GF,InvStartValues,InvFinalValues,Priors,Meas,BCsAdjoint,RunInfo)
v2struct(F);


CtrlVar.DefineOutputs='plots-sbB-ubvb-BCs-';


%%
if ~isfield(CtrlVar,'DefineOutputs')
    CtrlVar.uvPlotScale=[];
    %plots='-ubvb-udvd-log10(C)-log10(Surfspeed)-log10(DeformationalSpeed)-log10(BasalSpeed)-log10(AGlen)-';
    plots='-save-ubvb-log10(BasalSpeed)-sbB-ab-log10(C)-log10(AGlen)-';
else
    plots=CtrlVar.DefineOutputs;
end



CtrlVar.QuiverColorPowRange=2; 

%%
GLgeo=GLgeometry(MUA.connectivity,MUA.coordinates,GF,CtrlVar);
TRI=[]; DT=[]; xGL=[] ; yGL=[] ;
x=MUA.coordinates(:,1);  y=MUA.coordinates(:,2);

%%

if contains(plots,'-save-')

    % save data in files with running names
    % check if folder 'ResultsFiles' exists, if not create
   if strcmp(CtrlVar.DefineOutputsInfostring,'First call ') && exist(fullfile(cd,'ResultsFiles'),'dir')~=7 ;
        mkdir('ResultsFiles') ;
    end
    
    if strcmp(CtrlVar.DefineOutputsInfostring,'Last call')==0
                
        FileName=sprintf('ResultsFiles/%07i-Nodes%i-Ele%i-Tri%i-kH%i-%s.mat',...
            round(100*CtrlVar.time),MUA.Nnodes,MUA.Nele,MUA.nod,1000*CtrlVar.kH,CtrlVar.Experiment);
        fprintf(' Saving data in %s \n',FileName)
        save(FileName,'CtrlVar','UserVar','MUA','F')
        
    end
end



% only do plots at end of run
% if ~strcmp(CtrlVar.DefineOutputsInfostring,'Last call') ; return ; end

if contains(plots,'-BCs-')
    %%
    figure ;
    PlotBoundaryConditions(CtrlVar,MUA,BCs)
    hold on ;
    [xGL,yGL,GLgeo]=PlotGroundingLines(CtrlVar,MUA,GF,GLgeo,xGL,yGL,'r');
    save("GroundingLines.mat",'CtrlVar','GF','MUA','GLgeo',"yGL","xGL");
    PlotMuaBoundary(CtrlVar,MUA,'b')
    print(gcf, 'MuaBoundary.png', '-dpng', '-r600');
    %%
end


if contains(plots,'-sbB-')
%%
    figure
    hold off
    AspectRatio=3; 
    ViewAndLight(1)=-40 ;  ViewAndLight(2)=20 ;
    ViewAndLight(3)=30 ;  ViewAndLight(4)=50;
    [TRI,DT]=Plot_sbB(CtrlVar,MUA,s,b,B,TRI,DT,AspectRatio,ViewAndLight);
    print(gcf, '地形.png', '-dpng', '-r600');
%%   
end

if contains(plots,'-B-')
    figure ;
    PlotMeshScalarVariable(CtrlVar,MUA,B);
    hold on ;
    [xGL,yGL,GLgeo]=PlotGroundingLines(CtrlVar,MUA,GF,GLgeo,xGL,yGL,'g');
    PlotMuaBoundary(CtrlVar,MUA,'b')
end


if contains(plots,'-ubvb-')
  
    figure
    N=1;
    
    speed=sqrt(ub.*ub+vb.*vb);
    CtrlVar.MinSpeedWhenPlottingVelArrows=0;
    CtrlVar.MaxPlottedSpeed=max(speed);
    CtrlVar.VelPlotIntervalSpacing='log10';
    CtrlVar.RelativeVelArrowSize=10;

    % 绘制流速有效值在0-1500范围内的箭头  %20230514这里最大值1.4923e+03
    % valid_idx = find(speed >= 0 & speed <= 1500);
    % QuiverColorGHG(x(valid_idx(1:N:end)),y(valid_idx(1:N:end)),ub(valid_idx(1:N:end)),vb(valid_idx(1:N:end)),CtrlVar);
    QuiverColorGHG(x(1:N:end),y(1:N:end),ub(1:N:end),vb(1:N:end),CtrlVar);
    AmeryUB = scatteredInterpolant(x, y, ub);
    AmeryVB = scatteredInterpolant(x, y, vb);
    save_name = 'AmeryInverse_ub_vb.mat';
    save(save_name, 'AmeryUB', 'AmeryVB');
    % 添加颜色条
    colormap jet; % 设置颜色映射
    caxis([0 1500]); % 设置颜色映射范围
    h = colorbar;
    ylabel(h, 'Speed (m/yr)', 'FontSize', 12);

    hold on;
    [xGL,yGL,GLgeo]=PlotGroundingLines(CtrlVar,MUA,GF,GLgeo,xGL,yGL,'k');
    PlotMuaBoundary(CtrlVar,MUA,'b')
    title(sprintf('(ub,vb)模拟流速 t=%-g ',CtrlVar.time)) ; xlabel('x (km)') ; ylabel('y (km)')
    print(gcf, '模拟流速.png', '-dpng', '-r600');

end

if contains(plots,'-ubvb-')
    figure
    N=1;

    X=load('C:\Users\TERRA\Documents\MATLAB\WQX\反演\网格敏感性实验\ADD_Experiment\2km\AmeryObserve_ub_vb.mat');
    OBub=X.AmeryUBO.Values;
    OBvb=X.AmeryVBO.Values;
    WQXA=OBub;
    WQXB=OBvb;

    speed=sqrt(WQXA.*WQXA+WQXB.*WQXB);
    CtrlVar.MinSpeedWhenPlottingVelArrows=0;
    CtrlVar.MaxPlottedSpeed=max(speed);
    CtrlVar.VelPlotIntervalSpacing='log10';
    CtrlVar.RelativeVelArrowSize=10;

    % 绘制流速有效值在0-1500范围内的箭头  %20230424这里最大值才768
    % valid_idx = find(speed >= 0 & speed <= 1500);
    % QuiverColorGHG(x(valid_idx(1:N:end)),y(valid_idx(1:N:end)),ub(valid_idx(1:N:end)),vb(valid_idx(1:N:end)),CtrlVar);
    QuiverColorGHG(x(1:N:end),y(1:N:end),WQXA(1:N:end),WQXB(1:N:end),CtrlVar);

    hold on;
    [xGL,yGL,GLgeo]=PlotGroundingLines(CtrlVar,MUA,GF,GLgeo,xGL,yGL,'k');
    PlotMuaBoundary(CtrlVar,MUA,'b')
    title(sprintf('(ub,vb)观测流速 t=%-g ',CtrlVar.time)) ; xlabel('x (km)') ; ylabel('y (km)')
    print(gcf, '观测流速.png', '-dpng', '-r600');    
end


if contains(plots,'-udvd-')
    % plotting horizontal velocities
    figure
    N=1;
    %speed=sqrt(ud.*ud+vd.*vd);
    %CtrlVar.MinSpeedWhenPlottingVelArrows=0; CtrlVar.MaxPlottedSpeed=max(speed); 
    CtrlVar.VelPlotIntervalSpacing='log10';
    %CtrlVar.RelativeVelArrowSize=10;
    %CtrlVar.VelColorMap='hot';
    QuiverColorGHG(x(1:N:end),y(1:N:end),ud(1:N:end),vd(1:N:end),CtrlVar);
    hold on ;
    [xGL,yGL,GLgeo]=PlotGroundingLines(CtrlVar,MUA,GF,GLgeo,xGL,yGL,'k');
    PlotMuaBoundary(CtrlVar,MUA,'b')
    title(sprintf('(ud,vd) t=%-g ',CtrlVar.time)) ; xlabel('xps (km)') ; ylabel('yps (km)')
    axis equal tight
    
end

if contains(plots,'-e-')
    % plotting effectiv strain rates
    
    % first get effective strain rates, e :
    [etaInt,xint,yint,exx,eyy,exy,Eint,e,txx,tyy,txy]=calcStrainRatesEtaInt(CtrlVar,MUA,u,v,AGlen,n);
    % all these variables are are element variables defined on integration points
    % therfore if plotting on nodes, must first project these onto nodes
    eNod=ProjectFintOntoNodes(MUA,e);
    
    figure
    [FigHandle,ColorbarHandel,tri]=PlotNodalBasedQuantities(MUA.connectivity,MUA.coordinates,eNod,CtrlVar)    ;
    hold on ; 
    [xGL,yGL,GLgeo]=PlotGroundingLines(CtrlVar,MUA,GF,GLgeo,xGL,yGL,'k');
    PlotMuaBoundary(CtrlVar,MUA,'b')
    title(sprintf('e t=%-g ',CtrlVar.time)) ; xlabel('x (km)') ; ylabel('y (km)')
    
end

if contains(plots,'-ub-')
    
    figure
    [FigHandle,ColorbarHandel,tri]=PlotNodalBasedQuantities(MUA.connectivity,MUA.coordinates,ub,CtrlVar)    ;
    hold on ;
    [xGL,yGL,GLgeo]=PlotGroundingLines(CtrlVar,MUA,GF,GLgeo,xGL,yGL,'k');
    PlotMuaBoundary(CtrlVar,MUA,'b')
    title(sprintf('ub t=%-g ',CtrlVar.time)) ; xlabel('x (km)') ; ylabel('y (km)')
    
end


if contains(plots,'-log10(AGlen)-')
%%    
    figure
    PlotMeshScalarVariable(CCtrlVarInRestartFiletrlVar,MUA,log10(AGlen));
    hold on ; 
    [xGL,yGL,GLgeo]=PlotGroundingLines(CtrlVar,MUA,GF,GLgeo,xGL,yGL,'k');
    PlotMuaBoundary(CtrlVar,MUA,'b')
    title(sprintf('log_{10}(AGlen) t=%-g ',CtrlVar.time)) ; xlabel('x (km)') ; ylabel('y (km)')
    title(colorbar,'log_{10}(yr^{-1} kPa^{-3})')
%%
end


if contains(plots,'-log10(C)-')
%%    
    figure
    PlotMeshScalarVariable(CtrlVar,MUA,log10(C));
    hold on 
    [xGL,yGL,GLgeo]=PlotGroundingLines(CtrlVar,MUA,GF,GLgeo,xGL,yGL,'k');
    PlotMuaBoundary(CtrlVar,MUA,'b')
    title(sprintf('log_{10}(C) t=%-g ',CtrlVar.time)) ; xlabel('x (km)') ; ylabel('y (km)')
    title(colorbar,'log_{10}(m yr^{-1} kPa^{-3})')
%%
end


if contains(plots,'-C-')
    
    figure
    PlotElementBasedQuantities(MUA.connectivity,MUA.coordinates,C,CtrlVar);
    title(sprintf('C t=%-g ',CtrlVar.time)) ; xlabel('x (km)') ; ylabel('y (km)')
    
end


if contains(plots,'-log10(SurfSpeed)-')
    
    us=ub+ud;  vs=vb+vd;
    SurfSpeed=sqrt(us.*us+vs.*vs);
    
    figure
    PlotNodalBasedQuantities(MUA.connectivity,MUA.coordinates,log10(SurfSpeed),CtrlVar);
    hold on ;
    [xGL,yGL,GLgeo]=PlotGroundingLines(CtrlVar,MUA,GF,GLgeo,xGL,yGL,'k');
    PlotMuaBoundary(CtrlVar,MUA,'b')
    
    title(sprintf('log_{10}(Surface speed) t=%-g ',CtrlVar.time)) ; xlabel('x (km)') ; ylabel('y (km)')
    title(colorbar,'log_{10}(m/yr)')
end



if contains(plots,'-log10(BasalSpeed)-')
    BasalSpeed=sqrt(ub.*ub+vb.*vb); 
    figure
    PlotNodalBasedQuantities(MUA.connectivity,MUA.coordinates,log10(BasalSpeed),CtrlVar);
    hold on
    plot(GLgeo(:,[3 4])'/CtrlVar.PlotXYscale,GLgeo(:,[5 6])'/CtrlVar.PlotXYscale,'k','LineWidth',1);
    title(sprintf('log_{10}(Basal speed) t=%-g ',CtrlVar.time)) ; xlabel('x (km)') ; ylabel('y (km)') ; title(colorbar,'log_{10}(m/yr)')
end



if contains(plots,'-log10(DeformationalSpeed)-')
    DeformationalSpeed=sqrt(ud.*ud+vd.*vd); 
    figure
    PlotNodalBasedQuantities(MUA.connectivity,MUA.coordinates,log10(DeformationalSpeed),CtrlVar);
    hold on
    plot(GLgeo(:,[3 4])'/CtrlVar.PlotXYscale,GLgeo(:,[5 6])'/CtrlVar.PlotXYscale,'k','LineWidth',1);
    title(sprintf('log_{10}(Deformational speed) t=%-g ',CtrlVar.time)) ; xlabel('x (km)') ; ylabel('y (km)') ; title(colorbar,'log_{10}(m/yr)')
end


if contains(plots,'-ab-')
%%
    figure
    
    PlotMeshScalarVariable(CtrlVar,MUA,ab)
    hold on
    plot(GLgeo(:,[3 4])'/CtrlVar.PlotXYscale,GLgeo(:,[5 6])'/CtrlVar.PlotXYscale,'k','LineWidth',1);
    title(sprintf('ab t=%-g ',CtrlVar.time)) ; xlabel('x (km)') ; ylabel('y (km)') ; title(colorbar,'(m/yr)')
    axis equal
%%
end


if contains(plots,'-as-')
%%
    figure
    PlotMeshScalarVariable(CtrlVar,MUA,as)
    hold on
    plot(GLgeo(:,[3 4])'/CtrlVar.PlotXYscale,GLgeo(:,[5 6])'/CtrlVar.PlotXYscale,'k','LineWidth',1);
    title(sprintf('as t=%-g ',CtrlVar.time)) ; xlabel('x (km)') ; ylabel('y (km)') ; title(colorbar,'(m/yr)')
    axis equal
%%
end

if contains(plots,'-h-')
%%
    figure
    PlotMeshScalarVariable(CtrlVar,MUA,h)
    hold on
    plot(GLgeo(:,[3 4])'/CtrlVar.PlotXYscale,GLgeo(:,[5 6])'/CtrlVar.PlotXYscale,'k','LineWidth',1);
    
    I=h<=CtrlVar.ThickMin;
    plot(MUA.coordinates(I,1)/CtrlVar.PlotXYscale,MUA.coordinates(I,2)/CtrlVar.PlotXYscale,'.r')
    title(sprintf('h t=%-g ',CtrlVar.time)) ; xlabel('x (km)') ; ylabel('y (km)') ; title(colorbar,'(m/yr)')
    axis equal
%%
end
%%
if contains(plots,'-stresses-')
    
    figure

    [txzb,tyzb,txx,tyy,txy,exx,eyy,exy,e]=CalcNodalStrainRatesAndStresses(CtrlVar,MUA,AGlen,n,C,m,GF,s,b,ub,vb,ud,vd);
    N=10;
    
    %xmin=-750e3 ; xmax=-620e3 ; ymin=1340e3 ; ymax = 1460e3 ;
    %I=find(x>xmin & x< xmax & y>ymin & y< ymax) ;
    %I=I(1:N:end);
    I=1:N:MUA.Nnodes;
    
    scale=1e-2;
    PlotTensor(x(I)/CtrlVar.PlotXYscale,y(I)/CtrlVar.PlotXYscale,txx(I),txy(I),tyy(I),scale);
    hold on
    plot(x(MUA.Boundary.Edges)/CtrlVar.PlotXYscale, y(MUA.Boundary.Edges)/CtrlVar.PlotXYscale, 'k', 'LineWidth',2) ;
    hold on ; plot(GLgeo(:,[3 4])'/CtrlVar.PlotXYscale,GLgeo(:,[5 6])'/CtrlVar.PlotXYscale,'k','LineWidth',1);
    axis equal
    axis([xmin xmax ymin ymax]/CtrlVar.PlotXYscale)
    xlabel(CtrlVar.PlotsXaxisLabel) ;
    ylabel(CtrlVar.PlotsYaxisLabel) ;
    
end
if contains(plots,'-plots-')
    
    figsWidth=1000 ; figHeights=300;
    GLgeo=[]; xGL=[] ; yGL=[];
    %%
    fig100=figure(100) ;
    fig100.Position=[50 50 figsWidth 3*figHeights];
    subplot(4,1,1)
    PlotMeshScalarVariable(CtrlVar,MUA,F.h); title(sprintf('h at t=%g',CtrlVar.time))
    hold on    
    [xGL,yGL,GLgeo]=PlotGroundingLines(CtrlVar,MUA,F.GF,GLgeo,xGL,yGL);
    %Plot_sbB(CtrlVar,MUA,s,b,B) ; title(sprintf('time=%g',time))
    
    
    subplot(4,1,2)
    QuiverColorGHG(MUA.coordinates(:,1),MUA.coordinates(:,2),F.ub,F.vb,CtrlVar);
    hold on
    [xGL,yGL,GLgeo]=PlotGroundingLines(CtrlVar,MUA,F.GF,GLgeo,xGL,yGL);
    hold off
    
    subplot(4,1,3)
    PlotMeshScalarVariable(CtrlVar,MUA,F.dhdt);   title(sprintf('dhdt at t=%g',CtrlVar.time))
    hold on
    [xGL,yGL,GLgeo]=PlotGroundingLines(CtrlVar,MUA,F.GF,GLgeo,xGL,yGL);
    
    subplot(4,1,4)
    PlotMeshScalarVariable(CtrlVar,MUA,F.ab);   title(sprintf('ab at t=%g',CtrlVar.time))
    hold on
    
    [xGL,yGL,GLgeo]=PlotGroundingLines(CtrlVar,MUA,F.GF,GLgeo,xGL,yGL);
    hold off
    
    
    x=MUA.coordinates(:,1);
    y=MUA.coordinates(:,2);
    
    Fb=scatteredInterpolant(x,y,F.b);
    Fs=Fb ; Fs.Values=F.s;
    
    xProfile=min(x):1000:max(x);
    
    yCentre=40e3+xProfile*0;
    sProfile=Fs(xProfile,yCentre);
    bProfile=Fb(xProfile,yCentre);
    
    BProfile=MismBed(xProfile,yCentre);
    
    
    fig200=figure(200);
    fig200.Position=[1200 50 figsWidth 2*figHeights];
    
    plot(xProfile/1000,sProfile,'b')
    hold on
    plot(xProfile/1000,bProfile,'b')
    plot(xProfile/1000,BProfile,'k')
    title(sprintf('t=%g',time))
    hold off
    
    
    fig300=figure(300);
    fig300.Position=[1200 700 figsWidth figHeights];
    PlotMuaMesh(CtrlVar,MUA);
    hold on 
    
    [xGL,yGL,GLgeo]=PlotGroundingLines(CtrlVar,MUA,F.GF,GLgeo,xGL,yGL,'r','LineWidth',2);
    title(sprintf('t=%g',time))
    hold off
    
    drawnow
    
end
end
