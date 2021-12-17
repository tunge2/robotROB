 clear all

arduinoObj = serialport(serialportlist("available"),9600);
configureTerminator(arduinoObj,hex2dec('5A')); % Data package ends with byte 0x5A

%set to zero config
% pause(1)
% zero_config = [0 20 20 0]';
% makezero(arduinoObj, zero_config)
% pause(1)

angles = [0 0 0 0; 10 0 0 0; 20 0 0 0; 30 0 0 0; 40 0 0 0; 50 0 0 0; 60 0 0 0; 70 0 0 0; 80 0 0 0; 90 0 0 0];
%angles = [0 40 40 0; 90 40 40 0; 180 40 40 0] %q1 examples

n = size(angles);
n = n(1);
times = zeros(n,1);
for i=1:n
    %angles = generate_angles()
    times(i,1) = DOdobot(angles(i,:), arduinoObj)
    
    pause(3)
    %READdobot(arduinoObj)
    %robot.position
    %robot.angles
end

%set to zero config

% pause(2)
% 
% makezero(arduinoObj)
% 
% pause(2)
