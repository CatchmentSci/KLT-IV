
% %% Initialisation
clear all 
clc
%% Load in files
%%Load video file
% file = uigetfile

%MY DEFAULT TEST - Comment out to select your path above
file = 'devon-dart20180712_05100.mp4'
vid = VideoReader(file);

%%select the save destination for the file
% selpath = uigetdir
% folder = selpath;

%% Set up file ready for looping

%MY DEFAULT TEST
mkdir('GrayScaleImagery')
mkdir('middleimages')
mkdir('SeedingResults')
folder = 'GrayscaleImagery';
folder2 = 'middleimages';
f = vid.FrameRate;
d = vid.Duration;
midImage = round(0.5*f*d);
FileString = extractAfter(file, "Dart\");
FileString = strcat(FileString(1:end-4),"_");
%Loop through the video, reading each frame into a width-by-height-by-3 array named img. Write out each image to a JPEG file with a name in the form imgN.jpg, where N is the frame number.
ii = 1;
addpath(folder);
copyfile MainScriptSeedingMetrics.m GrayScaleImagery
copyfile MainFunctionSeedingMetrics.m GrayScaleImagery

%% Create grey frames

while hasFrame(vid)
   img = readFrame(vid);
   img2 = rgb2gray(img);
   filename = [sprintf('%05d',ii) '.gif'];
   fullname = fullfile(folder,filename);
     if ii == midImage
         midimageName = strcat(FileString,'.gif');
         MidImage = fullfile(folder2,midimageName);
         imwrite(img2,MidImage);
         imwrite(img2,fullname);
     else
   imwrite(img2,fullname) % Write out to a JPEG file (img1.jpg, img2.jpg, etc.)
       end
   ii = ii+1;
end



%%%%%%% Create a video file from the frames
% 
% % Find Image File Names
% % Find all the JPEG file names in the images folder. Convert the set of image names to a cell array.
% imageNames = dir(fullfile(folder,'*.gif'));
% imageNames = {imageNames.name}';
% 
% %Create New Video with the Image Sequence
% %Construct a VideoWriter object, which creates a Motion-JPEG AVI file by default.
% %Save name for the video
% 
% %videoname= input('Enter saved file name', 's'); %%% Input name if you want
% videoname = FileString;
% videoname=strcat(videoname,'.avi');
%     
% outputVideo = VideoWriter(fullfile(folder, videoname));
% outputVideo.FrameRate = vid.FrameRate;
% open(outputVideo)
% 
% %Loop through the image sequence, load each image, and then write it to the video.
% for ii = 1:length(imageNames)
%    img2 = imread(fullfile(folder,imageNames{ii}));
%    writeVideo(outputVideo,img2)
% end
% 
% % Finalize the video file.
% close(outputVideo)
% 
% %Construct a reader object.
% VideoOut = VideoReader(fullfile(folder, videoname));
% 
% %Create a MATLAB movie struct from the video frames.
% ii = 1;
% while hasFrame(VideoOut)
%    mov(ii) = im2frame(readFrame(VideoOut));
%    ii = ii+1;
% end
% 
% %Resize the current figure and axes based on the video's width and height, and view the first frame of the movie.
% figure 
% imshow(mov(1).cdata, 'Border', 'tight')
% 
% %Play back the movie once at the video's frame rate.
% movie(mov,1,VideoOut.FrameRate)
% 

midimage= imread(MidImage);
imshow(midimage);
coordinates_input = ginput(midimage(1))
rowPI = round(coordinates_input(2));
columnPI = round(coordinates_input(1));
fprintf('You clicked on coordinates (row,column) = (%f,%f)\nWhich is the pixel in row %d, column %d\n', ...  
    coordinates_input(1), coordinates_input(2), rowPI,columnPI);
close all
h = imshow(midimage);
im = imagemodel(h);
pixval = getPixelValue(im, rowPI, columnPI)




