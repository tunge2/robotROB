%might have to change this to be whatever the camera is in the lab just
%gotta look up what it is, camlist = webcamlist should give all webcams
%connected then this takes thirty snapshots one every 3 seconds but you can
%adjust to what works
photo = videoinput('winvideo', 2, 'MJPG_1024x576', 'ROI', [1 1 640 480],'ReturnedColorSpace', 'rgb');
for i = 1:10
        my_image = getsnapshot(photo);
        file_name = sprintf('Image%d', i);
        imwrite(my_image, [file_name,'.png']);
        pause(3);    
        imshow(my_image);
end