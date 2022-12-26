clc;
clear all;

% Use animation_configuration function to get angle arrays
animation_configuration;

l1 = 20;
l2 = 45;
l3 = 30;

% Preallocate memory for the line data
x1_data = zeros(1, length(Angle1));
y1_data = zeros(1, length(Angle1));
z1_data = zeros(1, length(Angle1));
x2_data = zeros(1, length(Angle1));
y2_data = zeros(1, length(Angle1));
z2_data = zeros(1, length(Angle1));
x3_data = zeros(1, length(Angle1));
y3_data = zeros(1, length(Angle1));
z3_data = zeros(1, length(Angle1));
x4_data = zeros(1, length(Angle1));
y4_data = zeros(1, length(Angle1));
z4_data = zeros(1, length(Angle1));

% Calculate line data in a vectorized manner
x1_data = 0;
y1_data = 0;
z1_data = 0;
z2_data = l1;
x2_data = 0;
y2_data = 0;
x3_data = l2*cosd(Angle1).*cosd(Angle2);
y3_data = l2*sind(Angle1).*cosd(Angle2);
z3_data = l2*sind(Angle2)+l1;
x4_data =  l3*cosd(Angle2+Angle3).*cosd(Angle1) + l2*cosd(Angle1).*cosd(Angle2);
y4_data = l3*cosd(Angle2+Angle3).*sind(Angle1) + l2*sind(Angle1).*cosd(Angle2);
z4_data = l3*sind(Angle2+Angle3) + l2*sind(Angle2) + l1;
figure
hold on
xlabel('x axis');
ylabel('y axis');
zlabel('z axis');
view(3)
grid on
scatter3(x1_data, y1_data, z1_data, 'r');
scatter3(x2_data, y2_data, z2_data, 'b');
scatter3(x3_data, y3_data, z3_data, 'g');
scatter3(x4_data, y4_data, z4_data, 'k');
line([0 x1_data(1)], [0 y1_data(1)], [0 z1_data(1)], 'color' ,'r');
line([x1_data(1) x2_data(1)], [y1_data(1) y2_data(1)], [z1_data(1) z2_data(1)], 'color' ,'b');
line([x2_data(1) x3_data(1)], [y2_data(1) y3_data(1)], [z2_data(1) z3_data(1)], 'color' ,'g');
line([x3_data(1) x4_data(1)], [y3_data(1) y4_data(1)], [z3_data(1) z4_data(1)], 'color' ,'k');
axis([-100 100 -100 100 -100 100]);
r_line = line([0 x1_data(1)], [0 y1_data(1)], [0 z1_data(1)], 'color', 'r', 'LineWidth', 2);
b_line = line([x1_data(1) x2_data(1)], [y1_data(1) y2_data(1)], [z1_data(1) z2_data(1)], 'color', 'b', 'LineWidth', 2);
g_line = line([x2_data(1) x3_data(1)], [y2_data(1) y3_data(1)], [z2_data(1) z3_data(1)], 'color', 'g', 'LineWidth', 2);
k_line = line([x3_data(1) x4_data(1)], [y3_data(1) y4_data(1)], [z3_data(1) z4_data(1)], 'color', 'k', 'LineWidth', 2);


figure
view(3)
grid on
hold on

xlabel('x axis (mm)')
ylabel('y axis (mm)')
% Set axis limits
xticks(-100:50:100)
yticks(-100:50:100)
zticks(-100:50:100)
zlabel('z axis (mm)')
axis([-100 100 -100 100 -100 100]);
v = VideoWriter('index_animation.mp4','MPEG-4');
open(v)
d=1; %defines velocity of simulation
j=1:d:length(Angle1); 

% Update plot data and redraw plot at each iteration
for i = 1: length(j)

    line( 'XData', [0 x1_data], 'YData', [0 y1_data], 'ZData', [0 z1_data], 'color', 'r', 'LineWidth', 2);
    line('XData', [x1_data x2_data], 'YData', [y1_data y2_data], 'ZData', [z1_data z2_data], 'color', 'b', 'LineWidth', 2);
    line( 'XData', [x2_data x3_data(i)], 'YData', [y2_data y3_data(i)], 'ZData', [z2_data z3_data(i)], 'color', 'g', 'LineWidth', 2);
    line( 'XData', [x3_data(i) x4_data(i)], 'YData', [y3_data(i) y4_data(i)], 'ZData', [z3_data(i) z4_data(i)], 'color', 'k', 'LineWidth', 2);

    MM(i)=getframe(gcf);
        children = get(gca, 'children');
    delete(children(:));
end
% Initialize video writer
v = VideoWriter('thumb_animation.mp4','MPEG-4');
open(v)
% Write video and close file
writeVideo(v,MM)
close(v)
% 
%     line(r_line, 'XData', [0 x1_data], 'YData', [0 y1_data], 'ZData', [0 z1_data]);
%     line(b_line, 'XData', [x1_data x2_data], 'YData', [y1_data y2_data], 'ZData', [z1_data z2_data]);
%     line(g_line, 'XData', [x2_data x3_data(i)], 'YData', [y2_data y3_data(i)], 'ZData', [z2_data z3_data(i)]);
%     line(k_line, 'XData', [x3_data(i) x4_data(i)], 'YData', [y3_data(i) y4_data(i)], 'ZData', [z3_data(i) z4_data(i)]);
