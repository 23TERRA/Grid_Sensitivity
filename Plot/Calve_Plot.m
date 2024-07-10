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

distanceFromGL2CF=[0,10,20,30,40,50,60,70,80,90,100,110,120];
km30=[14.9823,14.9820,14.9723,8.6267,0.0961,0.0950,0.0020,0.0014,0.0014,0.0010,0.0005,0.0000,0.0000];
km25=[6.9865,6.9858,6.9803, 0.0388,0.0372,0.0111,0.0021,0.0008,0.0008,0.0007,0.0003,0.0000,0.0000];
km20=[14.7891,14.7845,3.4095,0.7265,0.0168,0.0153,0.0012,0.0008,0.0008,0.0003,0.0003,0.0001,0.0000];
km16=[11.1364,11.1363,2.6655,0.8710,0.1759,0.0216,0.0009,0.0003,0.0003,0.0003,0.0002,0.0000,0.0000];
km10=[32.1635,15.5920,1.9368,1.3044,0.2075,0.0092,0.0040,0.0006,0.0002,0.0002,0.0001,0.0000,0.0000];
km8 = [31.5507,6.1655,1.5367,0.9044,0.2494,0.0125,0.0048,0.0004,0.0001,0.0000,0.0000,0.0000,0.0000];
km5 = [31.3504,8.8113,1.2181,0.7825,0.2367,0.0156,0.0046,0.0014,0.0001,0.0000,0.0000,0.0000,0.0000];
km4 = [30.7255,16.0845,1.1797,0.8333,0.3687,0.0143,0.0047,0.0021,0.0000,0.0001,0.0000,0.0000,0.0000];
km2 = [23.7538,11.7013,1.0677,0.8019,0.5089,0.0210,0.0058,0.0024,0.0001,0.0002,0.0001,0.0000,0.0000];
kmUnstructured = [29.4073,13.1372,1.1351,0.9388,0.5662,0.0219,0.0064,0.0027,0.0002,0.0002,0.0001,0.0000,0.0000];
figure
set(gcf,'color','w','position',[500 200 650 600]);
plot(distanceFromGL2CF, 100*km30,'Color',custom_colors(9,:), 'LineWidth', 2,'LineStyle','-','Marker','o');
hold on
plot(distanceFromGL2CF, 100*km25,'Color',custom_colors(8,:), 'LineWidth', 2,'LineStyle','-','Marker','+');
hold on
plot(distanceFromGL2CF, 100*km20,'Color',custom_colors(7,:), 'LineWidth', 2,'LineStyle','-','Marker','o');
hold on
plot(distanceFromGL2CF, 100*km16,'Color',custom_colors(6,:), 'LineWidth', 2,'LineStyle','-','Marker','+');
hold on
plot(distanceFromGL2CF, 100*km10,'Color',custom_colors(5,:), 'LineWidth', 2,'LineStyle','-','Marker','o');
hold on
plot(distanceFromGL2CF, 100*km8,'Color',custom_colors(4,:), 'LineWidth', 2,'LineStyle','-','Marker','+');
hold on
plot(distanceFromGL2CF, 100*km5,'Color',custom_colors(3,:), 'LineWidth', 2,'LineStyle','-','Marker','o');
hold on
plot(distanceFromGL2CF, 100*km4,'Color',custom_colors(2,:), 'LineWidth', 2,'LineStyle','-','Marker','+');
hold on
plot(distanceFromGL2CF, 100*km2,'Color',custom_colors(1,:), 'LineWidth', 2,'LineStyle','--','Marker','none');
hold on
plot(distanceFromGL2CF, 100*kmUnstructured,'Color','r', 'LineWidth', 2,'LineStyle','-','Marker','+');

xlabel('Distance from GL to CF (km)','Interpreter','tex','fontsize',15);
ylabel('% change in GLF','Interpreter','tex','fontsize',15);
ylim([0,3400]);
set(gca, 'ytick', [50 100 150 200 600 1000 1400 1800 2200 2600 3000 3400], 'yticklabel', {'','','','200','600','1000','1400','1800','2200','2600','3000','3400'});
xlim([0,120]);
xticks(0:10:120);
legend('30km','25km','20km','16km','10km', '8km','5km','4km','2km','Unstructured', 'northwest','fontsize',15);
set(gca,'linewidth',1,'fontsize',15,'fontweight','normal','fontname','time news roman');
set(gca, 'FontSize', 15,'fontname','time news roman');
set(legend,...
    'Position',[0.324102564102564 0.726111111111111 0.563589743589743 0.178055555555556],...
    'NumColumns',3,...
    'FontSize',15);
grid on;
path = 'E:\MATLAB\WQX\Project1\出图代码\原图直出';
print(gcf, fullfile(path, 'Calve.png'), '-dpng', '-r1000');