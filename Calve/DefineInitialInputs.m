function [UserVar,CtrlVar,MeshBoundaryCoordinates]=DefineInitialInputs(UserVar,CtrlVar)

%% Input files
Interpolant_path = 'E:\MATLAB\WQX\Data_usedByUa';
UserVar.RunType='Calving';
UserVar.GeometryInterpolant=fullfile(Interpolant_path,'GeometryInterpolant_BMA_v3.mat');
UserVar.SurfaceVelocityInterpolant=fullfile(Interpolant_path,'VelocityInterpolant.mat');
UserVar.BoundaryShp =fullfile(Interpolant_path,'SHP\Amery_Simplify.shp');
MeshBoundaryCoordinates=CreateMeshBoundaryCoordinatesFromShp(CtrlVar,UserVar);
UserVar.Inverse_AGlen_C = 'AmeryInverse_AGlen_C-unstructured.mat';
%% Calve run settings
CtrlVar.Experiment=UserVar.RunType;
CtrlVar.ReadInitialMesh=1;
CtrlVar.ReadInitialMeshFileName='UnstructuredMesh.mat';
CtrlVar.SaveInitialMeshFileName='UnstructuredMesh111.mat';
CtrlVar.ManuallyDeactivateElements=1;

end
