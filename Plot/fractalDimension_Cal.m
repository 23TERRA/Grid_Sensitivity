path = 'E:\MATLAB\WQX\Project1\30km';
load(fullfile(path, 'InverseRestart.mat'));
path1= 'E:\MATLAB\WQX\Inversion\20240610';
x=MUA.coordinates(:,1); y=MUA.coordinates(:,2);
[GF,GLgeo,~,~]=IceSheetIceShelves(CtrlVarInRestartFile,MUA,GF);
[xGL,yGL]=ArrangeGroundingLinePos(CtrlVarInRestartFile,GLgeo,1);
X=xGL;Y=yGL;
%%
% 将坐标数据组合成曲线数据
curve = complex(Y/250, X/250); % 用复数形式组合 X 和 Y
%%
% 定义盒计数法分析的尺寸范围
boxSizes = 2.^(1:8); 
% boxSizes = 2.^(0:10); % 默认方案  这里选择尺寸范围为 2 的幂次方
% 初始化盒子数量
boxCount = zeros(size(boxSizes));

% 盒计数法
for i = 1:length(boxSizes)
    boxSize = boxSizes(i);
    
    % 计算覆盖曲线的盒子数量
    boxCount(i) = countBoxes(curve, boxSize);
end

% 计算盒子数量和尺寸的对数关系
logSizes = log(boxSizes);
logCounts = log(boxCount);
figure
set(gcf,'color','w','position',[500 200 650 600]); 
% 绘制盒子数量和尺寸的对数关系图
plot(logSizes, logCounts, 'o-','LineWidth', 2);
xlabel('log(盒子尺寸)');
ylabel('log(盒子数量)');
title('盒计数法分析');
grid on;

% 使用线性拟合估算分形维数
p = polyfit(logSizes, logCounts, 1);
fractalDimension = p(1); % 得到斜率，即分形维数

fprintf('估算得到的分形维数为: %.4f\n', fractalDimension);
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');

% print(gcf, fullfile(path1, 'MEaSUREs分形维度.png'), '-dpng', '-r1000');
% 定义一个函数来计算盒子数量
function count = countBoxes(curve, boxSize)
    % 获取曲线的边界框
    minX = min(real(curve));
    maxX = max(real(curve));
    minY = min(imag(curve));
    maxY = max(imag(curve));
    
    % 计算盒子数量
    count = 0;
    for x = minX:boxSize:maxX
        for y = minY:boxSize:maxY
            box = curve(abs(curve - (x + y * 1i)) <= boxSize/2);
            if ~isempty(box)
                count = count + 1;
            end
        end
    end
end 

% 估算得到的分形维数为: 0.7314
% 不规则网格 估算得到的分形维数为: 1.0511
% 2km       估算得到的分形维数为: 0.9441
% 4km       估算得到的分形维数为: 0.7790
% 5km       估算得到的分形维数为: 0.7131
% 8km       估算得到的分形维数为: 0.5999
% 10km      估算得到的分形维数为: 0.5253
% 16km      估算得到的分形维数为: 0.3934
% 20km      估算得到的分形维数为: 0.3699
% 25km      估算得到的分形维数为: 0.2758
% 30km      估算得到的分形维数为: 0.2441