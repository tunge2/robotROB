% Moves DoBot using moveJoint method

function time = DOdobot(angles, arduinoObj)
tstart = tic;

isGrab = 0; % No suction

% Set the float values in the data package
line_float_cmd = zeros(1,10); 
% CARTESIAN  = 3;
% JOINT = 6;
line_float_cmd(1) = 6; %JOINT;
line_float_cmd(3) = angles(1); %joint 1 (degrees)
line_float_cmd(4) = angles(2); %joint 2 (degrees)
line_float_cmd(5) = angles(3); %joint 3 (degrees)
%line_float_cmd(6) = angles(4);
line_float_cmd(7) = isGrab;
% MOVE_MODE_JUMP = 0; % moveJump
% MOVE_MODE_JOINTS = 1;  % joints move independent
% MOVE_MODE_LINEAR = 2;  % linear movement
line_float_cmd(8) = 1; %MOVE_MODE N %moveJoint 

% Combine datapackage
header_chr = char(hex2dec('A5'));
line_chr_cmd = char(typecast(single(line_float_cmd), 'uint8'));
% tail_chr = char(hex2dec('5A')); % No need, bcs already specified with configureTerminator command
line_chr_cmd = [header_chr,line_chr_cmd]; %,tail_chr]
line_str_cmd = convertCharsToStrings(line_chr_cmd);

pause(0.87); %need to pause in order to succesfully actuate
writeline(arduinoObj,line_str_cmd)
time = toc(tstart);
end
