%%20240306晚上七点 30km网格的L-curve分析
x = [9.844950254E-10,0.143023716E-08,0.253819251E-08,0.589464788E-08,1.45962995E-08,0.059817267E-06,0.285249891E-06,0.267441801E-04,0.026167088E-06]; % 对数尺度的R
y = [32.18759955,29.62453784,27.15146826,23.97638935,23.06351284,22.58788961,22.48145751,22.479648,22.72877766]; % 纵轴数据I
path = 'C:\Users\TERRA\Documents\MATLAB\WQX\反演\20240306L_curve';
figure
set(gcf,'color','w','position',[500 200 650 600]);
% 绘制散点图
scatter(x, y, 100, 'k', 'filled'); % 使用黑色填充的大点

% 设置横轴为对数尺度
set(gca, 'XScale', 'log');

% 设置坐标轴范围
% xlim([10^(-5), 10^(0)]);
% set(gca, 'xtick', [10^(-5), 10^(-4), 10^(-3), 10^(-2), 10^(-1), 10^(0)]);
% ylim([63.5, 67]);

% 添加标题和标签
title('Varying \gamma_{s} with \gamma_{a}=1');%with \gamma_{a A/C}=10^{-2}
xlabel('Regularisation','fontsize',15);
ylabel('Misfit','fontsize',15);

set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% grid on;

box on

% % 在每个点附近添加对数编号
% for i = 1:numel(x)
%      text(x(i)*1.2, y(i)-0.05, sprintf('10^{%.0f}', i-5),'Color','k','FontSize',12,'VerticalAlignment','bottom','HorizontalAlignment','left');
% end
print(gcf, fullfile(path, 'L_gama_s.png'), '-dpng', '-r1000');
