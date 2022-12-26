clc;
clear all
l_pp =45;
l_dp = 25;
l_ip = 30;

animation_configuration
% Preallocate memory for the line data
x1_data = zeros(1, length(Angle1));
y1_data = zeros(1, length(Angle1));
x2_data = zeros(1, length(Angle1));
y2_data = zeros(1, length(Angle1));
xe_data = zeros(1, length(Angle1));
ye_data = zeros(1, length(Angle1));

% Calculate line data in a vectorized manner
x1_data = l_pp*cosd(Angle1);
y1_data = l_pp*sind(Angle1);
x2_data = x1_data + l_ip*cosd(Angle1-Angle2);
y2_data = y1_data + l_ip*sind(Angle1-Angle2);
xe_data = x2_data + l_dp*cosd(Angle1-Angle2-Angle3);
ye_data = y2_data + l_dp*sind(Angle1-Angle2-Angle3);

xlabel('x axis')
ylabel('y axis')
%title('Trajectory of the links')
hold on
scatter(x1_data, y1_data, 'r');
scatter(x2_data, y2_data, 'b');
scatter(xe_data, ye_data, 'g');
line([0 x1_data(1)], [0 y1_data(1)], 'color' ,'r');
line([x1_data(1) x2_data(1)], [y1_data(1) y2_data(1)], 'color' ,'b');
line([x2_data(1) xe_data(1)], [y2_data(1) ye_data(1)], 'color' ,'g');
axis([-100 100 -100 100]);
legend('MCP','PIP','DP')
legend('Show')
grid
figure
xlabel('x axis (mm)')
ylabel('y axis (mm)')
% Set axis limits
axis([-100 100 -100 100]);

% Set tick values and labels
xticks(-100:50:100)
yticks(-100:50:100)
r_line = line([0 x1_data(1)], [0 y1_data(1)], 'color', 'r', 'LineWidth', 2);
b_line = line([x1_data(1) x2_data(1)], [y1_data(1) y2_data(1)], 'color', 'b', 'LineWidth', 2);
g_line = line([x2_data(1) xe_data(1)], [y2_data(1) ye_data(1)], 'color', 'g', 'LineWidth', 2);

grid


% Update plot data and redraw plot at each iteration
for i = 1: length(Angle1)
    set(r_line, 'XData', [0 x1_data(i)], 'YData', [0 y1_data(i)]);
    set(b_line, 'XData', [x1_data(i) x2_data(i)], 'YData', [y1_data(i) y2_data(i)]);
    set(g_line, 'XData', [x2_data(i) xe_data(i)], 'YData', [y2_data(i) ye_data(i)]);
    drawnow limitrate;
    MM(i)=getframe(gcf);
end
% Initialize video writer
v = VideoWriter('index_animation.mp4','MPEG-4');
open(v)
% Write video and close file
writeVideo(v,MM)
close(v)

