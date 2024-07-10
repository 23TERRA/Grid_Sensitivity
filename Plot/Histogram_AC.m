% 假设.mat文件名为data.mat，并且其中包含一个名为numbers的变量
path='E:\MATLAB\WQX\Project1';
X1=load(fullfile(path, 'UnstructuredMesh\InverseRestart.mat'));
X2=load(fullfile(path, '2km\InverseRestart.mat'));
X3=load(fullfile(path, '4km\InverseRestart.mat'));
X4=load(fullfile(path, '5km\InverseRestart.mat'));
X5=load(fullfile(path, '8km\InverseRestart.mat'));
X6=load(fullfile(path, '10km\InverseRestart.mat'));
X7=load(fullfile(path, '16km\InverseRestart.mat'));
X8=load(fullfile(path, '20km\InverseRestart.mat'));
X9=load(fullfile(path, '25km\InverseRestart.mat'));
X10=load(fullfile(path, '30km\InverseRestart.mat'));
C1ALL=X1.F.C;
C2ALL=X2.F.C;
C3ALL=X3.F.C;
C4ALL=X4.F.C;
C5ALL=X5.F.C;
C6ALL=X6.F.C;
C7ALL=X7.F.C;
C8ALL=X8.F.C;
C9ALL=X9.F.C;
C10ALL=X10.F.C;
numbers1= log10(C1ALL(X1.GF.node == 1));
numbers2= log10(C2ALL(X2.GF.node == 1));
numbers3= log10(C3ALL(X3.GF.node == 1));
numbers4= log10(C4ALL(X4.GF.node == 1));
numbers5= log10(C5ALL(X5.GF.node == 1));
numbers6= log10(C6ALL(X6.GF.node == 1));
numbers7= log10(C7ALL(X7.GF.node == 1));
numbers8= log10(C8ALL(X8.GF.node == 1));
numbers9= log10(C9ALL(X9.GF.node == 1));
numbers10= log10(C10ALL(X10.GF.node == 1));
custom_colors = [
    0.2, 0.3, 0.8;    % 鲜艳的蓝色
    0.8, 0.4, 0.2;    % 鲜艳的橙色
    0.4, 0.6, 0.3;    % 鲜艳的绿色

    0.6, 0.2, 0.8;    % 紫色
    0.3, 0.8, 0.4;    % 青色
    0.8, 0.6, 0.2;    % 橙色

    0.5, 0.5, 0.5;    % 中性灰色
    0.3, 0.3, 0.3;    % 深灰色
    0.9, 0.9, 0.2;    % 亮黄色
    0.1, 0.6, 0.5;    % 海蓝色
    ];

% 定义区间边界
edges = -6:0.1:0;

% 计算每个区间的计数
counts1 = histcounts(numbers1, edges);
total_samples1 = numel(numbers1);
probabilities1 = counts1 / total_samples1;

counts2 = histcounts(numbers2, edges);
total_samples2 = numel(numbers2);
probabilities2 = counts2 / total_samples2;


counts3 = histcounts(numbers3, edges);
total_samples3 = numel(numbers3);
probabilities3 = counts3 / total_samples3;


counts4 = histcounts(numbers4, edges);
total_samples4 = numel(numbers4);
probabilities4 = counts4 / total_samples4;


counts5 = histcounts(numbers5, edges);
total_samples5 = numel(numbers5);
probabilities5 = counts5 / total_samples5;


counts6 = histcounts(numbers6, edges);
total_samples6 = numel(numbers6);
probabilities6 = counts6 / total_samples6;

counts7 = histcounts(numbers7, edges);
total_samples7 = numel(numbers7);
probabilities7 = counts7 / total_samples7;

counts8 = histcounts(numbers8, edges);
total_samples8 = numel(numbers8);
probabilities8 = counts8 / total_samples8;

counts9 = histcounts(numbers9, edges);
total_samples9 = numel(numbers9);
probabilities9 = counts9 / total_samples9;

counts10 = histcounts(numbers10, edges);
total_samples10 = numel(numbers10);
probabilities10 = counts10 / total_samples10;
edges = edges+0.05;
% 绘制条形图
figure; % 创建一个新的图形窗口
% set(gcf, 'color', 'w', 'position', [-2183.666666666667,-159.6666666666667,992.0000000000002,838]);
set(gcf,'color','w','position',[500 200 650 600]); 
plot(edges(1:end-1), probabilities10,'Color',custom_colors(9,:), 'LineWidth', 2,'LineStyle','-','Marker','o');
hold on
plot(edges(1:end-1), probabilities9,'Color',custom_colors(8,:), 'LineWidth', 2,'LineStyle','-','Marker','+');
hold on
plot(edges(1:end-1), probabilities8,'Color',custom_colors(7,:), 'LineWidth', 2,'LineStyle','-','Marker','o');
hold on
plot(edges(1:end-1), probabilities7,'Color',custom_colors(6,:), 'LineWidth', 2,'LineStyle','-','Marker','+');
hold on
plot(edges(1:end-1), probabilities6,'Color',custom_colors(5,:), 'LineWidth', 2,'LineStyle','-','Marker','o');
hold on
plot(edges(1:end-1), probabilities5,'Color',custom_colors(4,:), 'LineWidth', 2,'LineStyle','-','Marker','+');
hold on
plot(edges(1:end-1), probabilities4,'Color',custom_colors(3,:), 'LineWidth', 2,'LineStyle','-','Marker','o');
hold on
plot(edges(1:end-1), probabilities3,'Color',custom_colors(2,:), 'LineWidth', 2,'LineStyle','-','Marker','+');
hold on
plot(edges(1:end-1), probabilities2,'Color',custom_colors(1,:), 'LineWidth', 2,'LineStyle','--','Marker','none');
hold on
plot(edges(1:end-1), probabilities1,'r', 'LineWidth', 2,'LineStyle','-','Marker','+');
hold on; % 确保新的图形能够与之前的图形在同一图上显示
plot([-4.7093, -4.7093], [0, 1], 'k--', 'LineWidth', 1);
ylim([0, 0.8]); % 设置y轴的范围
yticks(0:0.1:0.8);
xlim([-6,0]);
xticks(-6:0.5:0);
xlabel('log_{10}(C)');
ylabel('Probability');
legend('30km','25km','20km','16km','10km','8km','5km','4km','2km','Unstructured','Prior(C)', 'Location', 'northeast','fontsize',15);

set(gca, 'FontSize', 15, 'fontname', 'time news roman');
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
path = 'E:\MATLAB\WQX\Project1\出图代码\原图直出';
grid on;

box on
print(gcf, fullfile(path, '接地C直方图.png'), '-dpng', '-r1000');


%%
% 假设.mat文件名为data.mat，并且其中包含一个名为numbers的变量
path='E:\MATLAB\WQX\Project1';
X1=load(fullfile(path, 'UnstructuredMesh\InverseRestart.mat'));
X2=load(fullfile(path, '2km\InverseRestart.mat'));
X3=load(fullfile(path, '4km\InverseRestart.mat'));
X4=load(fullfile(path, '5km\InverseRestart.mat'));
X5=load(fullfile(path, '8km\InverseRestart.mat'));
X6=load(fullfile(path, '10km\InverseRestart.mat'));
X7=load(fullfile(path, '16km\InverseRestart.mat'));
X8=load(fullfile(path, '20km\InverseRestart.mat'));
X9=load(fullfile(path, '25km\InverseRestart.mat'));
X10=load(fullfile(path, '30km\InverseRestart.mat'));
C1ALL=X1.F.AGlen;
C2ALL=X2.F.AGlen;
C3ALL=X3.F.AGlen;
C4ALL=X4.F.AGlen;
C5ALL=X5.F.AGlen;
C6ALL=X6.F.AGlen;
C7ALL=X7.F.AGlen;
C8ALL=X8.F.AGlen;
C9ALL=X9.F.AGlen;
C10ALL=X10.F.AGlen;
numbers1= log10(C1ALL);
numbers2= log10(C2ALL);
numbers3= log10(C3ALL);
numbers4= log10(C4ALL);
numbers5= log10(C5ALL);
numbers6= log10(C6ALL);
numbers7= log10(C7ALL);
numbers8= log10(C8ALL);
numbers9= log10(C9ALL);
numbers10= log10(C10ALL);
custom_colors = [
    0.2, 0.3, 0.8;    % 鲜艳的蓝色
    0.8, 0.4, 0.2;    % 鲜艳的橙色
    0.4, 0.6, 0.3;    % 鲜艳的绿色

    0.6, 0.2, 0.8;    % 紫色
    0.3, 0.8, 0.4;    % 青色
    0.8, 0.6, 0.2;    % 橙色

    0.5, 0.5, 0.5;    % 中性灰色
    0.3, 0.3, 0.3;    % 深灰色
    0.9, 0.9, 0.2;    % 亮黄色
    0.1, 0.6, 0.5;    % 海蓝色
    ];

% 定义区间边界
edges = -10:0.1:-5;

% 计算每个区间的计数
counts1 = histcounts(numbers1, edges);
total_samples1 = numel(numbers1);
probabilities1 = counts1 / total_samples1;

counts2 = histcounts(numbers2, edges);
total_samples2 = numel(numbers2);
probabilities2 = counts2 / total_samples2;


counts3 = histcounts(numbers3, edges);
total_samples3 = numel(numbers3);
probabilities3 = counts3 / total_samples3;


counts4 = histcounts(numbers4, edges);
total_samples4 = numel(numbers4);
probabilities4 = counts4 / total_samples4;


counts5 = histcounts(numbers5, edges);
total_samples5 = numel(numbers5);
probabilities5 = counts5 / total_samples5;


counts6 = histcounts(numbers6, edges);
total_samples6 = numel(numbers6);
probabilities6 = counts6 / total_samples6;

counts7 = histcounts(numbers7, edges);
total_samples7 = numel(numbers7);
probabilities7 = counts7 / total_samples7;

counts8 = histcounts(numbers8, edges);
total_samples8 = numel(numbers8);
probabilities8 = counts8 / total_samples8;

counts9 = histcounts(numbers9, edges);
total_samples9 = numel(numbers9);
probabilities9 = counts9 / total_samples9;

counts10 = histcounts(numbers10, edges);
total_samples10 = numel(numbers10);
probabilities10 = counts10 / total_samples10;
edges = edges+0.05;
% 绘制条形图
figure; % 创建一个新的图形窗口
set(gcf,'color','w','position',[500 200 650 600]); 
plot(edges(1:end-1), probabilities10,'Color',custom_colors(9,:), 'LineWidth', 2,'LineStyle','-','Marker','o');
hold on
plot(edges(1:end-1), probabilities9,'Color',custom_colors(8,:), 'LineWidth', 2,'LineStyle','-','Marker','+');
hold on
plot(edges(1:end-1), probabilities8,'Color',custom_colors(7,:), 'LineWidth', 2,'LineStyle','-','Marker','o');
hold on
plot(edges(1:end-1), probabilities7,'Color',custom_colors(6,:), 'LineWidth', 2,'LineStyle','-','Marker','+');
hold on
plot(edges(1:end-1), probabilities6,'Color',custom_colors(5,:), 'LineWidth', 2,'LineStyle','-','Marker','o');
hold on
plot(edges(1:end-1), probabilities5,'Color',custom_colors(4,:), 'LineWidth', 2,'LineStyle','-','Marker','+');
hold on
plot(edges(1:end-1), probabilities4,'Color',custom_colors(3,:), 'LineWidth', 2,'LineStyle','-','Marker','o');
hold on
plot(edges(1:end-1), probabilities3,'Color',custom_colors(2,:), 'LineWidth', 2,'LineStyle','-','Marker','+');
hold on
plot(edges(1:end-1), probabilities2,'Color',custom_colors(1,:), 'LineWidth', 2,'LineStyle','--','Marker','none');
hold on
plot(edges(1:end-1), probabilities1,'r', 'LineWidth', 2,'LineStyle','-','Marker','+');
hold on; % 确保新的图形能够与之前的图形在同一图上显示
plot([-7.9407, -7.9407], [0, 1], 'k--', 'LineWidth', 1);
ylim([0, 1]); % 设置y轴的范围
yticks(0:0.1:1);
xlim([-10,-5]);
xticks(-10:0.5:-5);
xlabel('log_{10}(AGlen)');
ylabel('Probability');
legend('30km','25km','20km','16km','10km','8km','5km','4km','2km','Unstructured','Prior(AGlen)', 'Location', 'northeast','fontsize',15);
set(gca, 'FontSize', 15, 'fontname', 'time news roman');
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
set(gca, 'XTickLabelRotation', 45); 
path = 'E:\MATLAB\WQX\Project1\出图代码\原图直出';
grid on;

box on
print(gcf, fullfile(path, 'AGlen直方图.png'), '-dpng', '-r1000');