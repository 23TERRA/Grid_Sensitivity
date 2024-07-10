function [UserVar,CtrlVar,MeshBoundaryCoordinates]=DefineInitialInputs(UserVar,CtrlVar)
%% Input files
Interpolant_path = 'E:\MATLAB\WQX\Data_usedByUa';
UserVar.RunType='InverseUnstructuredMesh';
UserVar.GeometryInterpolant=fullfile(Interpolant_path,'GeometryInterpolant_BMA_v3.mat');
UserVar.SurfaceVelocityInterpolant=fullfile(Interpolant_path,'VelocityInterpolant.mat');
UserVar.BoundaryShp =fullfile(Interpolant_path,'SHP\Amery_Simplify.shp');
MeshBoundaryCoordinates=CreateMeshBoundaryCoordinatesFromShp(CtrlVar,UserVar);
%% Inverse
CtrlVar.Experiment=UserVar.RunType;
CtrlVar.InverseRun=1;
CtrlVar.Restart=0;
CtrlVar.MaxNumberOfElements=50000e3;
CtrlVar.AdaptMesh=0;
CtrlVar.ReadInitialMesh=1;
CtrlVar.ReadInitialMeshFileName='UnstructuredMesh.mat';
CtrlVar.SaveInitialMeshFileName='WQXMesh20240626.mat';
%% Meshing 
CtrlVar.MeshGenerator='mesh2d' ;
CtrlVar.GmshMeshingAlgorithm=8;                                       
%% Inverse basic 
CtrlVar.Inverse.MinimisationMethod='MatlabOptimizationHessian';
CtrlVar.Inverse.Iterations = 300;
CtrlVar.Inverse.AdjointGradientPreMultiplier='I';
%%  Bounds on C and AGlen
CtrlVar.AGlenmin=1e-10;
CtrlVar.AGlenmax=1e-5;
CtrlVar.Cmin=1e-6;
CtrlVar.Cmax=1e20;
CtrlVar.CisElementBased=0;
CtrlVar.AGlenisElementBased=0;
%% regularization gamma
gamafactor=1;
CtrlVar.Inverse.Regularize.logC.ga=1*gamafactor;
CtrlVar.Inverse.Regularize.logC.gs=7.5e4*gamafactor;
CtrlVar.Inverse.Regularize.logAGlen.ga=1*gamafactor;
CtrlVar.Inverse.Regularize.logAGlen.gs=7.5e4*gamafactor;
CtrlVar.Inverse.StoreSolutionAtEachIteration=1;
CtrlVar.Inverse.TestAdjointFiniteDifferenceType='second-order' ;                                        
CtrlVar.NameOfRestartFiletoWrite='Ua2D_InverseUnstructuredMesh.mat'; 
end
