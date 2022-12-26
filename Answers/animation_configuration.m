% Set up input dialog
prompt = {};
title = 'Input';
dims = [1 35];
definput = {};

% Loop through angles
for i = 1:3
    prompt{end+1} = sprintf('Enter start value for Angle %d:', i);
    prompt{end+1} = sprintf('Enter end value for Angle %d:', i);
    definput{end+1} = '0';
    definput{end+1} = '20';
end
prompt{end+1} = 'Enter number of points for all angles:';
definput{end+1} = '200';

% Show input dialog
inputs = inputdlg(prompt,title,dims,definput);

% Extract input values
Angle1_start = str2double(inputs{1});
Angle1_end = str2double(inputs{2});
Angle2_start = str2double(inputs{3});
Angle2_end = str2double(inputs{4});
Angle3_start = str2double(inputs{5});
Angle3_end = str2double(inputs{6});
Angle_npoints = str2double(inputs{7});

% Generate angle arrays
Angle1 = linspace(Angle1_start, Angle1_end, Angle_npoints);
Angle2 = linspace(Angle2_start, Angle2_end, Angle_npoints);
Angle3 = linspace(Angle3_start, Angle3_end, Angle_npoints);
