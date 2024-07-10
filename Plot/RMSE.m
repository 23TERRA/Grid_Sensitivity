path='E:\MATLAB\WQX\Project1\UnstructuredMesh';   % rmse=23.545930811750807
path1= 'E:\MATLAB\WQX\Project1\出图代码\原图直出';
X=load(fullfile(path, 'AmeryObserve_ub_vb.mat'));
OBub=X.AmeryUBO.Values;
OBvb=X.AmeryVBO.Values;

Y=load(fullfile(path, 'AmeryInverse_ub_vb.mat'));
Inverseub=Y.AmeryUB.Values;
Inversevb=Y.AmeryVB.Values;

Ob_speed=sqrt(OBub.*OBub+OBvb.*OBvb);
Invers_speed=sqrt(Inverseub.*Inverseub+Inversevb.*Inversevb);

[r2, rmse] = rsquare(Ob_speed,Invers_speed);

% 计算差值
difference_x = OBub - Inverseub;
difference_y = OBvb - Inversevb;

% 设置直方图的分箱数
numBins = 50;

% 定义分箱范围
edges = linspace(-200, 200, numBins + 1);

% 计算直方图
figure
set(gcf,'color','w','position',[500 200 650 600]);
histogram2(difference_x, difference_y, edges, edges, 'DisplayStyle', 'tile','Normalization','probability');
colorbar
xlabel('∆u (m a^{-1})','Interpreter','tex','fontsize',15,'fontname','time news roman');
ylabel('∆v (m a^{-1})','Interpreter','tex','fontsize',15,'fontname','time news roman');
set(gca, 'FontSize', 15,'fontname','time news roman'); % 将字体大小设置为12或你想要的大小
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');

box on
print(gcf, fullfile(path1, '归一化双变量直方图.png'), '-dpng', '-r1000');


%%
% CData=density2C(difference_x,difference_y,-200:10:200,-200:10:200);
% 
% 
% 
% % 主分布图
% ax1=axes('Parent',gcf);hold(ax1,'on')
% scatter(difference_x,difference_y,'filled','CData',CData);
% xlabel('∆u (m·a^{-1})','Interpreter','tex','fontsize',18,'fontname','time news roman');
% ylabel('∆v (m·a^{-1})','Interpreter','tex','fontsize',18,'fontname','time news roman');
% ax1.Position=[0.1,0.1,0.6,0.6];
% ax1.TickDir='out';


% % X轴直方图
% ax2=axes('Parent',gcf);hold(ax2,'on')
% [f,xi]=ksdensity(difference_x);
% fill([xi,xi(1)],[f,0],[0.34 0.47 0.71],'FaceAlpha',...
%     0.3,'EdgeColor',[0.34 0.47 0.71],'LineWidth',1.2)
% ax2.Position=[0.1,0.75,0.6,0.15];
% ax2.YColor='none';
% ax2.XTickLabel='';
% ax2.TickDir='out';
% ax2.XLim=ax1.XLim;
% 
% 
% % Y轴直方图
% ax3=axes('Parent',gcf);hold(ax3,'on')
% [f,yi]=ksdensity(difference_y);
% fill([f,0],[yi,yi(1)],[0.34 0.47 0.71],'FaceAlpha',...
%     0.3,'EdgeColor',[0.34 0.47 0.71],'LineWidth',1.2)
% ax3.Position=[0.75,0.1,0.15,0.6];
% ax3.XColor='none';
% ax3.YTickLabel='';
% ax3.TickDir='out';
% ax3.YLim=ax1.YLim;

% box on
% print(gcf, fullfile(path1, '归一化双变量直方图.png'), '-dpng', '-r1000');
%%
function [CData,h,XMesh,YMesh,ZMesh,colorList]=density2C(X,Y,XList,YList,colorList)
[XMesh,YMesh]=meshgrid(XList,YList);
XYi=[XMesh(:) YMesh(:)];
F=ksdensity([X,Y],XYi);
ZMesh=zeros(size(XMesh));
ZMesh(1:length(F))=F;
h=interp2(XMesh,YMesh,ZMesh,X,Y);

if nargin<5
colorList=[0.2700,0.0000,0.3300
    0.2700,0.2300,0.5100
    0.1900,0.4100,0.5600
    0.1200,0.5600,0.5500
    0.2100,0.7200,0.4700
    0.5600,0.8400,0.2700
    0.9900,0.9100,0.1300];
end

colorFunc=colorFuncFactory(colorList);
CData=colorFunc((h-min(h))./(max(h)-min(h)));
colorList=colorFunc(linspace(0,1,100)');


function colorFunc=colorFuncFactory(colorList)
x=(0:size(colorList,1)-1)./(size(colorList,1)-1);
y1=colorList(:,1);y2=colorList(:,2);y3=colorList(:,3);
colorFunc=@(X)[interp1(x,y1,X,'pchip'),interp1(x,y2,X,'pchip'),interp1(x,y3,X,'pchip')];
end
end



%% 计算r方和rmse的函数
function [r2 ,rmse] = rsquare(y,f,varargin)
% Compute coefficient of determination of data fit model and RMSE
%
% [r2 rmse] = rsquare(y,f)
% [r2 rmse] = rsquare(y,f,c)
%
% RSQUARE computes the coefficient of determination (R-square) value from
% actual data Y and model data F. The code uses a general version of 
% R-square, based on comparing the variability of the estimation errors 
% with the variability of the original values. RSQUARE also outputs the
% root mean squared error (RMSE) for the user's convenience.
%
% Note: RSQUARE ignores comparisons involving NaN values.
% 
% INPUTS
%   Y       : Actual data
%   F       : Model fit
%
% OPTION
%   C       : Constant term in model
%             R-square may be a questionable measure of fit when no
%             constant term is included in the model.
%   [DEFAULT] TRUE : Use traditional R-square computation
%            FALSE : Uses alternate R-square computation for model
%                    without constant term [R2 = 1 - NORM(Y-F)/NORM(Y)]
%
% OUTPUT 
%   R2      : Coefficient of determination
%   RMSE    : Root mean squared error
%
% EXAMPLE
%   x = 0:0.1:10;
%   y = 2.*x + 1 + randn(size(x));
%   p = polyfit(x,y,1);
%   f = polyval(p,x);
%   [r2 rmse] = rsquare(y,f);
%   figure; plot(x,y,'b-');
%   hold on; plot(x,f,'r-');
%   title(strcat(['R2 = ' num2str(r2) '; RMSE = ' num2str(rmse)]))
%   
% Jered R Wells
% 11/17/11
% jered [dot] wells [at] duke [dot] edu
%
% v1.2 (02/14/2012)
%
% Thanks to John D'Errico for useful comments and insight which has helped
% to improve this code. His code POLYFITN was consulted in the inclusion of
% the C-option (REF. File ID: #34765).

if isempty(varargin); c = true; 
elseif length(varargin)>1; error 'Too many input arguments';
elseif ~islogical(varargin{1}); error 'C must be logical (TRUE||FALSE)'
else c = varargin{1}; 
end

% Compare inputs
if ~all(size(y)==size(f)); error 'Y and F must be the same size'; end

% Check for NaN
tmp = ~or(isnan(y),isnan(f));
y = y(tmp);
f = f(tmp);

if c; r2 = max(0,1 - sum((y(:)-f(:)).^2)/sum((y(:)-mean(y(:))).^2));
else r2 = 1 - sum((y(:)-f(:)).^2)/sum((y(:)).^2);
    if r2<0
    % http://web.maths.unsw.edu.au/~adelle/Garvan/Assays/GoodnessOfFit.html
        warning('Consider adding a constant term to your model') %#ok<WNTAG>
        r2 = 0;
    end
end

rmse = sqrt(mean((y(:) - f(:)).^2));
end

