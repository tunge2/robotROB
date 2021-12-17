% how to use our code use picturecap.m to obtain pictures of the calibration
% board being used.
% put those into images folder then use cameracalibration code to call the
% camera calibration toolbox be sure to input board square size and the
% units it was measured in. Calibrate the camera by pressing calibrate and export the paramerters to the default name 
% Next set up the camera and calibration board in
% the dobots range use the picture capture code once again.  
% place a red object in the center of the calibration
% board run the colortrack.m file and so long as the object stays within the
% camera frame the code will run and the dobot will point the laser in the
% location of the centroid of the red object. If the object leaves the frame
% and error occurs and you have to realese the camera and videoOutput object
% and rerun the program. 
% code tree 
% picturecap requires video input device
% camCalibration requires camra calibration a folder called pics the size
% and measurment used for the board
% color track requires vision blobanalysis and imqa device to be installed
% from matlab 
% colortrack also requires singlephoto for calibrating the current board
% inorder to move the dobot erics Dodobot_line code is required to be in the
% same folder 