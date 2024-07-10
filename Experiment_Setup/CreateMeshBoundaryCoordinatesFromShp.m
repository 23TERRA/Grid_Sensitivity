function MeshBoundaryCoordinates =CreateMeshBoundaryCoordinatesFromShp(CtrlVar, UserVar)
coastline = shaperead(UserVar.BoundaryShp);
MeshBoundaryCoordinates = [coastline.X', coastline.Y'];
end