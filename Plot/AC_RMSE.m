AC2=load('E:\MATLAB\WQX\Project1\2km\AmeryInverse_AGlen_C-2km.mat');
ACun=load('E:\MATLAB\WQX\Project1\UnstructuredMesh\AmeryInverse_AGlen_C-unstructured.mat');
path='E:\MATLAB\WQX\Project1\2km';
load(fullfile(path,'InverseRestart.mat'));
AGlen_unstructured = ACun.AmeryF_C(MUA.coordinates(:,1), MUA.coordinates(:,2));
AGlen_2 = AC2.AmeryF_C(MUA.coordinates(:,1), MUA.coordinates(:,2));

AGlen_unstructured_grounded = AGlen_unstructured(GF.node == 1);
AGlen_unstructured_afloat = AGlen_unstructured(GF.node == 0);

AGlen_2_grounded = AGlen_2(GF.node == 1);
AGlen_2_afloat = AGlen_2(GF.node == 0);

[r2_AGlen_un2, rmse_AGlen_un2] = rsquare(AGlen_unstructured,AGlen_2); 
[r2_AGlen_grounded_un2, rmse_AGlen_grounded_un2] = rsquare(AGlen_unstructured_grounded,AGlen_2_grounded); 
[r2_AGlen_afloat_un2, rmse_AGlen__afloat_un2] = rsquare(AGlen_unstructured_afloat,AGlen_2_afloat); 
%%  把不规则网格的AC往规则网格上插值：
%  AGlen        All     grounded    afloat            All        grounded     afloat
% UnVS2km  r2  0.6334    0.0759     0.7294;  RMSE  2.0985e-09   1.6286e-09   6.7863e-09
% UnVS4km  r2  0.4280      0        0.6331;  RMSE  2.5796e-09   1.7072e-09   7.4177e-09
% UnVS5km  r2  0.2278      0        0.4808;  RMSE  2.9789e-09   1.8903e-09   8.8148e-09
% UnVS8km  r2    0         0          0   ;  RMSE  4.3378e-09   2.4251e-09   1.4047e-08
% UnVS10km r2    0         0          0   ;  RMSE  5.2197e-09   2.7749e-09   1.2665e-08
% UnVS16km r2    0         0        0.3253;  RMSE  1.5332e-08   9.8077e-09   1.1669e-08
% UnVS20km r2    0         0          0   ;  RMSE  1.4157e-08   1.1583e-08   2.4589e-08
% UnVS25km r2    0         0          0   ;  RMSE  1.6916e-08   3.3461e-09   1.2519e-08
% UnVS30km r2    0         0          0   ;  RMSE  2.5303e-08   2.2963e-08   1.5599e-08

%   C           All     grounded    afloat            All        grounded     afloat
% UnVS2km  r2    0         0          0   ;  RMSE  6.6247e-04   6.7847e-04   1.4065e-06
% UnVS4km  r2    0      0.0368        0   ;  RMSE  6.3455e-04   6.5001e-04   2.0331e-06
% UnVS5km  r2    0         0          0   ;  RMSE  6.1455e-04   6.2952e-04   3.1803e-06
% UnVS8km  r2  0.0225    0.1439       0   ;  RMSE  6.4962e-04   6.6591e-04   9.1507e-06
% UnVS10km r2    0         0          0   ;  RMSE  4.1491e-04   4.2148e-04   7.9734e-06
% UnVS16km r2    0         0          0   ;  RMSE  5.8081e-04   5.9953e-04   3.7414e-06
% UnVS20km r2    0         0          0   ;  RMSE  5.8580e-04   5.6838e-04   3.1064e-06
% UnVS25km r2    0         0          0   ;  RMSE  6.8843e-04   5.2978e-04   8.1288e-06
% UnVS30km r2    0         0          0   ;  RMSE  7.1770e-04   7.4864e-04   5.7578e-06

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
