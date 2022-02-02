% Main Script illustrating the use of MainFunctionSeedingMetrics:
% ==============================================================
%
% Code that illustrates the use of the function MainFunctionSeedingMetrics
% V0.1: Original Version
%
%
% If you use this code, please cite the following papers:
%
%   i) Pizarro, A., Dal Sasso, S. F., and Manfreda, S.: "Refining image-velocimetry performances for streamflow monitoring: seeding metrics to errors minimisation", Hydrol. Process., 2020. 
%  ii) Pizarro, A., Dal Sasso, S. F., Perks, M., and Manfreda, S.: "Identifying the optimal spatial distribution of tracers for optical sensing of stream surface flow", Hydrol. Earth Syst. Sci., 2020.
% iii) Dal Sasso, S.F.; Pizarro, A.; Manfreda, S.: "Metrics for the Quantification of Seeding Characteristics to Enhance Image Velocimetry Performance in Rivers". Remote Sens., 12, 1789, 2020.
%
%
% Alonso Pizarro (alonso.pizarro[at]unibas.it)
% ORCID - https://orcid.org/0000-0002-7242-6559
%
% ref: OSF - https://osf.io/w2br8/
% 17/09/2020 | V0.1

%% [1/10] Initialising...
% clear all
% close all
% clc

global h1

%% [2/10] Creating Loops...
ix = 1;  %Loop across
iy = 1 ;% loop down
iii = 1;
FullResults = [];
  %53.7500 460.2500 1.8540e+03 487.5000
  
%% [3/10] Defining Variables...
ImFormat = '*.gif'; %Image format
BinThreshold = 0.7; %Threshold for binarisation purposes. Values between 0 and 1
Frames = [1 20]; %Number of frames for analyses
blockSizeR = 60; %Block size for seeding clustering analysis
MinValueAreaTracers = 0; %Minimum value for tracers area - Possible filter
Image1 = '00001.gif';
originalImage = imread(Image1);
[rows, columns, numberOfColorChannels] = size(originalImage);
gridIntensity = []

%% [4/10] ROI definition...
%Define ROI Points
XStart= 0; %%%Starting grid position
YStart= 432; %%%Starting grid position

X2 = (columns-XStart); %%%Define the region of interest size
Y2 = (rows - YStart); %%%Define the region of interest size
NumGrdx = 8;
NumGrdy = 1;
X2 = X2/NumGrdx; %%%Size of grids 
Y2 = Y2/NumGrdy; %%%Size of grids 
  
%% [5/10] Start loops

%%%INSERT HERE NumGrd+1 where NumGrd is the number of grids that fit across the image
%%%(1080px / 108px = 10, 10+1 = 11), same for ix
while iy < (NumGrdy+1)
    while ix < (NumGrdx+1)
        %% [6/10] Find Rectangle Co-ordinates
        %%%Uncomment to draw, not linked to program, exit once found and
        %%%enter above
        %     figure; imshow(imread(Image1));
        %roi = drawrectangle
        %ROI = [roi.Position]; hold on
        ROI = [XStart YStart X2 Y2]; %%%These are defined in Section 3
        PosX = XStart;
        PosY = YStart;

         figure; imshow(imread(Image1)); %%%Uncomment to show images
            hold on

        h1 = images.roi.Rectangle(gca,'Position',ROI,'StripeColor','g','Rotatable',true,'RotationAngle',360);
            hold on
        rectangle('Position',ROI,'EdgeColor','b')
            
        %% [7/10] Computing seeding metrics and SDI index...
        % Seeding Metrics:
        tic
        [MeanDensity,MeanCV_Area,MeanDispersion,SeedingDensity,Dispersion,CV_Area,SDI] = MainFunctionSeedingMetrics(Frames,ImFormat,BinThreshold,ROI,blockSizeR,MinValueAreaTracers);
        toc

        %% [8/10] Recording Results...
        MeanSDI = SDI;
        MeanSDI = nanmean(MeanSDI, 'all'); %%%Average them across the frames computed
        Results = [PosX PosY MeanDensity MeanCV_Area MeanDispersion MeanSDI gridIntensity];
        GridResults = Results;
        FullResults = [FullResults ; GridResults];
        ResultsTable = array2table(FullResults, 'VariableNames',{'PosX', 'PosY', 'MeanDensity', 'MeanCV_Area', 'MeanDispersion', 'MeanSDI', 'gridIntensity'});
        ix = ix+1;
        XStart = XStart + X2 ;
        
    end
    %% [9/10] Continue Loop...
    iy = iy + 1;
    ix = 1;
    XStart = 0;
    YStart = YStart + Y2;

    
end

%% [10/10] Save table of results...
folderinitial = ('..\SeedingResults');
FinalResults = ResultsTable;
filenameSD = [sprintf('%05d',iii) '.csv'];
filenameSD = strcat('SeedingDensity',filenameSD);
fullnameSD = fullfile(folderinitial, filenameSD);
writetable(FinalResults, fullnameSD);
iii = iii + 1;
