function [UserVar,s,b,S,B,alpha]=DefineGeometry(UserVar,CtrlVar,MUA,time,FieldsToBeDefined)
persistent SurfaceBMA_v3
persistent BedBMA_v3
persistent ThicknessBMA_v3
if nargin<5
    FieldsToBeDefined='sbSB';
end
fprintf('DefineGeometry %s \n', FieldsToBeDefined)
%%
if isempty(SurfaceBMA_v3) 
    fprintf('DefineGeometry: loading file: %-s ', UserVar.GeometryInterpolant)
    load(UserVar.GeometryInterpolant,'BedBMA_v3','SurfaceBMA_v3','ThicknessBMA_v3')
    fprintf(' done \n')
end
x=MUA.coordinates(:,1);
y=MUA.coordinates(:,2);
alpha=0 ;

if contains(FieldsToBeDefined,'S')
    S=x*0;
else
    S=NaN;
end

if contains(FieldsToBeDefined,'s')
    s=SurfaceBMA_v3(x,y);
else
    s=NaN;
end
b=NaN;
B=NaN;
if contains(FieldsToBeDefined,'b')  || contains(FieldsToBeDefined,'B')
    B = BedBMA_v3(x, y);
    b = s - ThicknessBMA_v3(x, y);
    I = b<B;
    b(I) = B(I);  

end
end