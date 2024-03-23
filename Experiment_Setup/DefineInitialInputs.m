
function [UserVar,CtrlVar,MeshBoundaryCoordinates]=DefineInitialInputs(UserVar,CtrlVar)




%% Select the type of run by uncommenting one of the following options:

if isempty(UserVar) || ~isfield(UserVar,'RunType')
    
    UserVar.RunType='Inverse';

end

if isempty(UserVar) || ~isfield(UserVar,'m')
    UserVar.m=3;
end


CtrlVar.FlowApproximation="SSTREAM" ;
%%

UserVar.GeometryInterpolant='C:\Users\TERRA\Documents\MATLAB\WQX\SHP\AmeryData\AmeryGeometryInterpolantWQX_Yang_BMAV3.mat';                       
UserVar.SurfaceVelocityInterpolant='C:\Users\TERRA\Documents\MATLAB\WQX\SHP\AmeryData\AmeryVelocityInterpolantWQX_2.mat';
UserVar.BoundaryShp ='C:\Users\TERRA\Documents\MATLAB\WQX\SHP\AmeryData\shp\Amery2023.shp';
MeshBoundaryCoordinates=CreateMeshBoundaryCoordinatesFromShp(CtrlVar,UserVar);


UserVar.DistanceBetweenPointsAlongBoundary=5e3 ; 

CtrlVar.SlidingLaw="Weertman" ; % "Umbi" ; % "Weertman" ; % "Tsai" ; % "Cornford" ;  "Umbi" ; "Cornford" ; % "Tsai" , "Budd"

switch CtrlVar.SlidingLaw
    
    case "Weertman"
        UserVar.CFile='FC-Weertman.mat'; UserVar.AFile='FA-Weertman.mat';
    case "Umbi"
        UserVar.CFile='FC-Umbi.mat'; UserVar.AFile='FA-Umbi.mat';
    otherwise
        error('A and C fields not available')
end


%%

CtrlVar.Experiment=UserVar.RunType;
CtrlVar.InverseRun=1;
CtrlVar.TimeDependentRun=0;
CtrlVar.Restart=0;
CtrlVar.InfoLevelNonLinIt=1;
UserVar.Slipperiness.ReadFromFile=1;
UserVar.AGlen.ReadFromFile=1;
CtrlVar.ReadInitialMesh=1;
CtrlVar.AdaptMesh=0;

% CtrlVar.MaxNumberOfIterations = 20; % 设置迭代次数为100
% CtrlVar.dt=1e-5; 
% CtrlVar.time=0;
% CtrlVar.TotalNumberOfForwardRunSteps=100; 
% CtrlVar.TotalTime=10;

% time interval between calls to DefineOutputs.m
CtrlVar.DefineOutputsDt=1; 
% Element type
CtrlVar.TriNodes=3 ;


%%
CtrlVar.doplots=1;
CtrlVar.PlotMesh=1;  
CtrlVar.PlotBCs=1 ;
CtrlVar.PlotXYscale=1000;
CtrlVar.doAdaptMeshPlots=5; 
%%

% CtrlVar.ReadInitialMeshFileName='PIG-TWG-Mesh.mat';
% CtrlVar.ReadInitialMeshFileName='PIG-TWG-Mesh-withThwaitesIceshelfWestDeleted.mat';
% CtrlVar.SaveInitialMeshFileName='MeshFile.mat';
CtrlVar.MaxNumberOfElements=500e3;
CtrlVar.ReadInitialMesh=1;
CtrlVar.ReadInitialMeshFileName='WQXMeshInitial.mat';
CtrlVar.SaveInitialMeshFileName='WQXMesh20230828.mat';



%% Meshing 

% CtrlVar.MeshGenerator='gmsh' ; % 'mesh2d';
CtrlVar.MeshGenerator='mesh2d' ; % 'mesh2d';
CtrlVar.GmshMeshingAlgorithm=8; 
CtrlVar.MeshSizeMax=2000;
CtrlVar.MeshSize=2000;
CtrlVar.MeshSizeMin=2000;
                                         
CtrlVar.AdaptMeshInitial=1;   
CtrlVar.AdaptMeshMaxIterations=5;
CtrlVar.SaveAdaptMeshFileName='WQXMesh';    %  file name for saving adapt mesh. If left empty, no file is written



%% inverse basic 
CtrlVar.Inverse.InvertFor = '-logA-logC-' ;
CtrlVar.Inverse.Regularize.Field = '-logA-logC-';
CtrlVar.Inverse.DataMisfit.GradientCalculation='Adjoint';
CtrlVar.Inverse.MinimisationMethod='MatlabOptimizationHessian';
CtrlVar.Inverse.Iterations = 300; %迭代次数 80太小
CtrlVar.Inverse.WriteRestartFile=1; 
CtrlVar.Inverse.Measurements='-uv-';
CtrlVar.Inverse.Measurements='-uv-dhdt-';

CtrlVar.Inverse.AdjointGradientPreMultiplier='I'; % {'I','M'} %选择M或者取消这行就会只迭代14轮
%%  Bounds on C and AGlen
CtrlVar.AGlenmin=1e-10;
CtrlVar.AGlenmax=1e-5;
CtrlVar.Cmin=1e-6;
CtrlVar.Cmax=1e20;
CtrlVar.CisElementBased=0;
CtrlVar.AGlenisElementBased=0;

%% regularization gamma
gamafactor=1;
% CtrlVar.Inverse.Regularize.C.gs=1*gamafactor;
% CtrlVar.Inverse.Regularize.C.ga=1*gamafactor;
CtrlVar.Inverse.Regularize.logC.ga=1*gamafactor;
CtrlVar.Inverse.Regularize.logC.gs=2.5e3*gamafactor;

% CtrlVar.Inverse.Regularize.AGlen.gs=1;
% CtrlVar.Inverse.Regularize.AGlen.ga=1;
CtrlVar.Inverse.Regularize.logAGlen.ga=1*gamafactor;
CtrlVar.Inverse.Regularize.logAGlen.gs=2.5e3*gamafactor;

CtrlVar.Inverse.StoreSolutionAtEachIteration=1;

%% Testing adjoint parameters, start:
CtrlVar.Inverse.TestAdjoint.isTrue=0; % If true then perform a brute force calculation 
                                      % of the directional derivative of the objective function.  
CtrlVar.Inverse.TestAdjointFiniteDifferenceType='second-order' ; % {'central','forward'}
CtrlVar.Inverse.TestAdjointFiniteDifferenceStepSize=1e-8 ;
CtrlVar.Inverse.TestAdjoint.iRange=[100,121] ;  % range of nodes/elements over which brute force gradient is to be calculated.
                                         % if left empty, values are calulated for every node/element within the mesh. 
                                         % If set to for example [1,10,45] values are calculated for these three
                                         % nodes/elements.
% end, testing adjoint parameters. 
                                            

%% Minimum Thickness constrains
CtrlVar.ResetThicknessToMinThickness=0;  % forced the thickness, not recommended
CtrlVar.ThicknessConstraints=1; % to use the active-set method, recommended
CtrlVar.ThicknessConstraintsItMax=10; % maximum number of active-set iterations.
CtrlVar.ThickMin=20; % minimum allowed thickness without (potentially) doing something about it

%% Filenames

CtrlVar.NameOfFileForSavingSlipperinessEstimate="C-Estimate"+CtrlVar.SlidingLaw+".mat";
CtrlVar.NameOfFileForSavingAGlenEstimate=   "AGlen-Estimate"+CtrlVar.SlidingLaw+".mat";

if CtrlVar.InverseRun
    CtrlVar.Experiment="Amery-Inverse-"...
        +CtrlVar.ReadInitialMeshFileName...
        +CtrlVar.Inverse.InvertFor...
        +CtrlVar.Inverse.MinimisationMethod...
        +"-"+CtrlVar.Inverse.AdjointGradientPreMultiplier...
        +CtrlVar.Inverse.DataMisfit.GradientCalculation...
        +CtrlVar.Inverse.Hessian...
        +"-"+CtrlVar.SlidingLaw...
        +"-"+num2str(CtrlVar.DevelopmentVersion);
else
    CtrlVar.Experiment="Amery-Forward"...
        +CtrlVar.ReadInitialMeshFileName;
end


filename=sprintf('IR-%s-%s-Nod%i-%s-%s-Cga%f-Cgs%f-Aga%f-Ags%f-m%i-%s',...
    UserVar.RunType,...
    CtrlVar.Inverse.MinimisationMethod,...
    CtrlVar.TriNodes,...
    CtrlVar.Inverse.AdjointGradientPreMultiplier,...
    CtrlVar.Inverse.DataMisfit.GradientCalculation,...
    CtrlVar.Inverse.Regularize.logC.ga,...
    CtrlVar.Inverse.Regularize.logC.gs,...
    CtrlVar.Inverse.Regularize.logAGlen.ga,...
    CtrlVar.Inverse.Regularize.logAGlen.gs,...
    UserVar.m,...
    CtrlVar.Inverse.InvertFor);

CtrlVar.Experiment=replace(CtrlVar.Experiment," ","-");
filename=replace(filename,'.','k');

CtrlVar.Inverse.NameOfRestartOutputFile=filename;
CtrlVar.Inverse.NameOfRestartInputFile=CtrlVar.Inverse.NameOfRestartOutputFile;

end
