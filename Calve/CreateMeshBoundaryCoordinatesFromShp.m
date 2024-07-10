% copied and modified from ../Example/PIG-TWG/ instead of loading
% existing .mat file, I read the coordinates from shapefile
% directly (maybe slower, but more flexsible and encapsulating...)
% Teng Li, 20190806, litengbnu@foxmail.com
function MeshBoundaryCoordinates =CreateMeshBoundaryCoordinatesFromShp(CtrlVar, UserVar)
coastline = shaperead(UserVar.BoundaryShp);
MeshBoundaryCoordinates = [coastline.X', coastline.Y'];
end