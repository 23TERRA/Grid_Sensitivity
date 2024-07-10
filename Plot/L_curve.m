x = [0.1398/(5e3^2),0.1745/(1e4^2),1.0505/(5e4^2),1.6597/(7.5e4^2),2.2472/(1e5^2),6.2007/(5e5^2),11.7850/(7.5e5^2)]; % 对数尺度的R
y = [23.1140,23.1501,23.2328,23.2048,23.9080,33.2503,40.5143]; % 纵轴数据I
path = 'E:\MATLAB\WQX\Project1\出图代码';
figure
set(gcf,'color','w','position',[500 200 650 600]);
% 绘制散点图
scatter(x, y, 100, 'k', 'filled'); % 使用黑色填充的大点

% 设置横轴为对数尺度
set(gca, 'XScale', 'log');

% 设置坐标轴范围
% xlim([10^(-5), 10^(0)]);
% ylim([63.5, 67]);
title('Varying \gamma_{s} with \gamma_{a}=1');
xlabel('Regularization: R/\gamma_s^2','fontsize',15);
ylabel('Misfit: I','fontsize',15);
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
box on

print(gcf, fullfile(path, '原图直出\L_gama_s.png'), '-dpng', '-r1000');
