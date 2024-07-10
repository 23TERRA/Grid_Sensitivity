path= 'E:\MATLAB\WQX\Project1\出图代码\原图直出';
resolutions = [2, 4, 5, 8, 10,16,20,25,30]; % 网格分辨率
time_values=[868,192,79,48,31,14,10,8,4.5];
%%
% Mean_Diff 不规则格网10.5498 
% 绘制散点图 
[xData, yData] = prepareCurveData( resolutions, time_values );

% 设置 fittype 和选项。
ft = fittype( 'exp2' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [2417.31460619531 -0.513431300780724 -8.76701906595326 -0.0613973443699412];
% 对数据进行模型拟合。
[fitresult, gof] = fit( xData, yData, ft, opts );
% figure('units', 'centimeters', 'position', [18, 8, 17, 8.5]);
figure
set(gcf,'color','w','position',[500 200 650 600]);
%%
yyaxis left;

scatter(resolutions, time_values, 100, 'b', 'filled', 'MarkerFaceAlpha', 0.8);


% % 拟合曲线（这里使用二次多项式）
% p = polyfit(resolutions, time_values, 3); % 3表示3次多项式拟合
% 
% % 生成拟合曲线的x值范围
% x_fit = linspace(0, 32, 100);
% 
% % 计算拟合曲线的y值
% y_fit = polyval(p, x_fit);
% 
% % 绘制拟合曲线
% hold on;
% plot(x_fit, y_fit, 'r', 'LineWidth', 2);

hold on;
y_line = 87; % 不规则格网的time值
plot([0, 50], [y_line, y_line], 'b--', 'LineWidth', 2);

% % 添加灰影区域（观测区间）
% y_lower = 70.0665 - 5; % 下限
% y_upper = 70.0665 + 5; % 上限
% x_fill = [min(resolutions), max(resolutions), max(resolutions), min(resolutions)];
% y_fill = [y_lower, y_lower, y_upper, y_upper];
% % 使用RGB颜色表示灰色，FaceAlpha设置透明度
% patch(x_fill, y_fill, [0.8, 0.8, 0.8], 'FaceAlpha', 0.5, 'EdgeColor', 'none');
hold on; % 保持当前图形
x = linspace(min(xData), max(xData), 100); % 创建一个线性间隔的 x 值数组用于绘制曲线
y = feval(fitresult, x); % 计算拟合模型在 x 值上的 y 值
plot(x, y, 'Color', 'r', 'LineWidth', 2,'LineStyle','--'); % 绘制拟合曲线
% 设置坐标轴范围
xlim([0,32]);
set(gca,'xtick',[0 2 4 5 8 10 16 20 25 30]);
ylim([0,900]);

% 添加标签和标题
xlabel('Grid size (km)','fontsize',15);
ylabel('Inversion time (min)','fontsize',15);

%%
yyaxis right;
Point_values=[391518,98363,63085,24826,16036,6624,4604,3261,2597];
scatter(resolutions, Point_values, 100, 'r', 'filled', 'MarkerFaceAlpha', 0.5); % 'b'代表蓝色，'filled'填充点

hold on;
y_line2 = 63463; % 不规则格网的time值
plot([0, 50], [y_line2, y_line2], 'r--', 'LineWidth', 2);
ylabel('Grid nodes','fontsize',15);

% 添加图例
legend('Structured grid inversion time','Unstructured grid inversion time','Fitted curve for inversion time','Structured grid nodes','Unstructured grid nodes', 'Location', 'northeast','fontsize',15);
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
% title('网格分辨率与反演时长、网格节点数关系','fontsize',17);
% 显示图形
grid on;

box on
print(gcf, fullfile(path, 'Time_Nodes.png'), '-dpng', '-r1000');