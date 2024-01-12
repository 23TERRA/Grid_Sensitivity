path = 'C:\Users\TERRA\Documents\MATLAB\WQX\反演\网格敏感性实验';
load(fullfile(path, 'GL_Amery.mat'),'X','Y');
path1= 'C:\Users\TERRA\Desktop\results';

% 将坐标数据组合成曲线数据
curve = complex(Y/250, X/250); % 用复数形式组合 X 和 Y

% 定义盒计数法分析的尺寸范围
boxSizes = 2.^(1:8); % 这里选择尺寸范围为 2 的幂次方

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

% 绘制盒子数量和尺寸的对数关系图
plot(logSizes, logCounts, 'o-');
xlabel('log(盒子尺寸)');
ylabel('log(盒子数量)');
title('盒计数法分析');
grid on;

% 使用线性拟合估算分形维数
p = polyfit(logSizes, logCounts, 1);
fractalDimension = p(1); % 得到斜率，即分形维数

fprintf('估算得到的分形维数为: %.4f\n', fractalDimension);

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

% 估算得到的分形维数为: -0.7251
% 不规则网格 估算得到的分形维数为: -1.0796
% 2km       估算得到的分形维数为: -0.9620
% 4km       估算得到的分形维数为: -0.7879
% 5km       估算得到的分形维数为: -0.7223
% 8km       估算得到的分形维数为: -0.5969
% 10km      估算得到的分形维数为: -0.5223
% 16km      估算得到的分形维数为: -0.3847
% 20km      估算得到的分形维数为: -0.3173
% 25km      估算得到的分形维数为: -0.2587
% 30km      估算得到的分形维数为: -0.2200