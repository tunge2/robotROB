clear all

arduinoObj = serialport(serialportlist("available")',9600);
configureTerminator(arduinoObj,hex2dec('5A')); % Data package ends with byte 0x5A

robot = makezero(arduinoObj, [0 20 20]);

%position = [200 190 50; 200 -190 50];
position = [150 0 20];
n = size(position);
n = n(2);
n = 4;

times = zeros(n,1);

for i=1:10
    %angles = generate_angles()
    %xpos = x(i);
    %ypos = y(i);
    %position = [xpos ypos 20]
    times(i,1) = DOdobot_line([200 0 20], arduinoObj);
    pause(2)
    %READdobot(arduinoObj)
    %robot.position
    %robot.angles 
end

% %set to zero config
% 
% pause(2)
% 
% makezero(arduinoObj)
% 
% pause(2)


% load S_path
% x = S_xdata;
% y = S_ydata;
% 
% plot(x,y,'linewidth',20);
% axis square


