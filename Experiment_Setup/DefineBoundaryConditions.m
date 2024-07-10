function  [UserVar,BCs]=DefineBoundaryConditions(UserVar,CtrlVar,MUA,BCs,time,s,b,h,S,B,ub,vb,ud,vd,GF)
GroundedBoundaryNodes=MUA.Boundary.Nodes(GF.node(MUA.Boundary.Nodes)>0.5);
BCs.vbFixedNode = GroundedBoundaryNodes; 
BCs.ubFixedNode = GroundedBoundaryNodes; 
%% To set velocities at all grounded nodes along the boundary to zero:
BCs.ubFixedValue = zeros(numel(GroundedBoundaryNodes),1);
BCs.vbFixedValue = zeros(numel(GroundedBoundaryNodes),1);
BCMissingData=isnan(BCs.ubFixedValue) | isnan(BCs.vbFixedValue) ;
BCs.ubFixedValue(BCMissingData)=0 ;  BCs.vbFixedValue(BCMissingData)=0 ;
end