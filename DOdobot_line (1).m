function time = DOdobot_line(position, arduinoObj)
tstart = tic;

% Target Moving Mode 
line_float_cmd = zeros(1,10);
line_float_cmd(1) = 3;
    % CARTESIAN = 3;
    % JOINT = 6;
line_float_cmd(3) = position(1);
line_float_cmd(4) = position(2);
line_float_cmd(5) = position(3);
%line_float_cmd(6) = angles(4);
% line_float_cmd(7) = isGrab;
line_float_cmd(8) = 1; %MOVE_MODE
    % MOVE_MODE_JUMP = 0; % moveJump
    % MOVE_MODE_JOINTS = 1;  % joints move independent
    % MOVE_MODE_LINEAR = 2;  % linear movement    
% line_float_cmd(9) = 0;
line_float_cmd(9) = 2; %Pause time after action (sec)
    
% Combine datapackage
header_chr = char(hex2dec('A5'));
line_chr_cmd = char(typecast(single(line_float_cmd), 'uint8'));
% tail_chr = char(hex2dec('5A')); % No need, bcs already specified with configureTerminator command
line_chr_cmd = [header_chr,line_chr_cmd]; %,tail_chr]
line_str_cmd = convertCharsToStrings(line_chr_cmd);

%pause(0.87); %need to pause in order to succesfully actuate?
pause(0.87)
writeline(arduinoObj,line_str_cmd)
time = toc(tstart);
end