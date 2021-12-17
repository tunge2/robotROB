clear all

load theendcenters.mat

arduinoObj = serialport(serialportlist("available"),9600);
configureTerminator(arduinoObj,hex2dec('5A')); % Data package ends with byte 0x5A

n = length(centroids);
position = ones(3, n);
position = position*30;
position(1,:) = centroids(:, 1);
position(2,:) = centroids(:, 2);

times = zeros(n,1);

for i=1:n
%     if mod(i,2) == 0
%         times(i,1) = DOdobot_line(position(:,1), arduinoObj);
%     else
%          times(i,1) = DOdobot_line(position(:,end), arduinoObj);
%     end
    times(i,1) = DOdobot_line(position(:,i), arduinoObj);
    pause(1)
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
