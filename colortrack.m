%color tracking code 
arduinoObj = serialport("COM4",9600);
configureTerminator(arduinoObj,hex2dec('5A')); % Data package ends with byte 0x5A
%max range is 6x6 in or 15x15 cm
%imsize = [480, 640];
%obtain the parameters for the checkerboard in the frame reading from the
%picture taken for picture capture code
%---------------------------------------------------------------------------
 singlephoto()
 I = imread('Image2.png'); 
 [imagePoints,boardSize] = detectCheckerboardPoints(I)
 squareSize = 12.7; % millimeters
 worldPoints = generateCheckerboardPoints(boardSize,squareSize);
 imageSize = [size(I,1) size(I,2)];
 imagePoints = detectCheckerboardPoints(I, "PartialDetections", false);
 [R,t] = extrinsics(imagePoints,worldPoints,cameraParams);
%---------------------------------------------------------------------------
%set the threshold for the color we want to track
whitethresh = 0.20;
%create imaq device to obtain the video feed
cam = imaq.VideoDevice('winvideo', 2, 'MJPG_1024x576', 'ROI', [1 1 1024 576],'ReturnedColorSpace', 'rgb');
%get all info on the imaq device 
caminfo = imaqhwinfo(cam);
%create blob analysis object which defines outputs and the minumum bolb
%area and blob count
ball = vision.BlobAnalysis('AreaOutputPort', false, 'CentroidOutputPort', true, ...
    'BoundingBoxOutputPort', true, 'MinimumBlobArea', 100,...
    'MaximumCount', 1);
%create object shape to insert around blob
objshape = vision.ShapeInserter('BorderColor', 'Custom', 'CustomBorderColor', [1 0 0]);
%create video output object to output video
VideoOutput = vision.VideoPlayer('Name', 'Final Video', 'Position', [100 100 caminfo.MaxWidth+20 caminfo.MaxHeight+30]);
%set n for the number of frames to go through in our case we wanted this to
%be as close to real time as possible so set it large to make continuous
%movement
n = 76;
%create  a centroid object to hold centroid locations for recreating an
%image traced by the tracked object
centroids = zeros(n, 2);
for i=1:n
    %grab a single frame
    singleframe = step(cam);
    %flip the frame
    singleframe = rot90(singleframe);
    singleframe = rot90(singleframe);
    %singleframe = rot90(singleframe);
    %singleframe = rot90(singleframe);
    
    diffFrame = imsubtract(singleframe(:,:,1), rgb2gray(singleframe)); % Get red component of the image
    %filter out the noise 
    diffFrame= medfilt2(diffFrame, [3 3]);
    %get the center position and bounding box and convert the image to
    %black and white
    binFrame = im2bw(diffFrame, whitethresh);
    [centroid, bbox] = step(ball, binFrame);
    %set blue and green to be zero
    singleframe(1:15,1:215,:) = 0;
    %input the bounding box in the correct spot
    vidIn = step(objshape, singleframe, bbox);
    step(VideoOutput, vidIn);
    %centroid calculations get x and y component of centroid
    centroids(i,:) = centroid; 
    xInt = centroid(1,1);
    yInt = centroid(1,2);
    %use camera paramerters to convert from pixel space to world space
    newWorldPoints = pointsToWorld(cameraParams.Intrinsics,R,t,centroid);
    disp(newWorldPoints)
    %using pixel space convert to dobot space
    xWorld = ((xInt- 240)/480-(-0.5))*115+165
    yWorld = -(((yInt - 320)/640 - (-0.5))*200-100)
    %set position of dobot to the correct postion in dobot world
    pos = setpos(xWorld, yWorld)
    %move dobot to location specified
    DOdobot_line(pos, arduinoObj);
    %pause for dobot to be able to keep up 
    pause(.5);
end
%release the camera and video objects.
release(VideoOutput);
release(cam);

