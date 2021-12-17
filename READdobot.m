%READdobot

function robot = READdobot(arduinoObj)
    
    flush(arduinoObj);
    pause(3)
    
    line_str = readline(arduinoObj); % MATLAB returns readline as string
    line_chr = convertStringsToChars(line_str); % convert the string to char array
    % line_hex = dec2hex(line_chr) % Just to see the data as byte values in hex
    %Some assertions to make sure the data is valid
    assert(line_chr(1) == char(hex2dec('A5'))) % Assertion for header byte
    assert(length(line_chr) == 41) % Assertion for data length is correct (ie 42 bytes, 1 is removed with end byte while reading the line)
    %See the float values in the data package
    line_float = typecast(uint8(line_chr(2:end)), 'single'); % obtain the 10 float(single) values in the data package
    %PARSING
    %Now parse the data as described in 2.1.2 DOBOT CONTROLLER RETURN DATA PACKET format
    robot.position.x = line_float(1); % X coordinate
    robot.position.y = line_float(2); % Y coordinate
    robot.position.z = line_float(3); % Z coordinate
    
    %robot.angles.rHead = line_float(4); % Rotation value (Relative rotation angle of the end effector to the base)
    robot.angles.angle1 = line_float(5); % Base Angle
    robot.angles.angle2 = line_float(6); % Rear Arm Angle
    robot.angles.angle3 = line_float(7); % Fore Arm Angle
    %robot.angles.pawArmAngle = line_float(8); % Servo Angle (joint 4 angle)    
end
