
function robot = makezero(arduinoObj, zero_config)
alligned = false;

while alligned == false
    disp('moving')
    DOdobot(zero_config, arduinoObj);
    pause(2)
    disp('reading')
    [robot, arduinoObj] = readarduino(arduinoObj);
    pause(2)
    true_angles = [robot.angles.angle1 robot.angles.angle2 robot.angles.angle3]
    if norm(true_angles-zero_config) < 0.5
        alligned = true;
        error = norm(true_angles-zero_config)
        disp('Dobot @ Zero')
        disp(true_angles)
        disp('alligned')
    else
        error = norm(true_angles-zero_config)
        alligned = false;
        disp('not alligned')
    end
    pause(3)
end

end