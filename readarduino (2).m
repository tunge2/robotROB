% clear all
% 
% arduinoObj = serialport("COM5",9600);
% %
% configureTerminator(arduinoObj,hex2dec('5A')); % Data package ends with byte 0x5A

function [robot, arduinoObj] = readarduino(arduinoObj)

 good_to_go = false;
    
while  good_to_go == false 
    flush(arduinoObj);
    pause(2)
    line_str = readline(arduinoObj); % MATLAB returns readline as string
    line_chr = convertStringsToChars(line_str); % convert the string to char array
    
   if line_chr(1) == char(hex2dec('A5')) && length(line_chr) == 41
       good_to_go = true;
   end
   
end

%check = [line_chr(1) char(hex2dec('A5')) length(line_chr)];
assert(line_chr(1) == char(hex2dec('A5')))
assert(length(line_chr) == 41) 


%See the float values in the data package
line_float = typecast(uint8(line_chr(2:end)), 'single'); % obtain the 10 float(single) values in the data package
%PARSING
%Now parse the data as described in 2.1.2 DOBOT CONTROLLER RETURN DATA PACKET format
robot.position.x = line_float(1); % X coordinate
robot.position.y = line_float(2); % Y coordinate
robot.position.z = line_float(3); % Z coordinate
%robot.position

robot.angles.rHead = line_float(4); % Rotation value (Relative rotation angle of the end effector to the base)
robot.angles.angle1 = line_float(5); % Base Angle
robot.angles.angle2 = line_float(6); % Rear Arm Angle
robot.angles.angle3 = line_float(7); % Fore Arm Angle
%robot.angles.pawArmAngle = line_float(8); % Servo Angle (joint 4 angle)
%robot.angles
end


