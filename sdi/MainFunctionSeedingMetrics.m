% Seeding Metrics characterisation for Image-Velocimetry analysis
% ===============================================================
%
% Main function for Seeding Metrics Characterisation
% V0.1: Seeding clustering, density, CV area, and SDI index
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

function [MeanDensity,MeanCV_Area,MeanNu,SeedingDensity,Dispersion,CV_Area,SDI] = MainFunctionSeedingMetrics(contIniFin,ImFormat,BinThreshold,ROI,blockSizeR,MinValueAreaTracers)
global h1

wbar=waitbar(0,'Processing Seeding Metric Analysis');
contwaitbar = 0;

direc = dir([pwd,filesep,ImFormat]); filenames={};
[filenames{1:length(direc),1}] = deal(direc.name);
filenames = sortrows(filenames); %sort all image files

%% Computation of Seeding variables
% Initialising variables used in loops
MeanAreaFiltered = nan(1,contIniFin(2));
SeedingDensity = MeanAreaFiltered;
CV_Area = MeanAreaFiltered;
Dispersion = MeanAreaFiltered;

for cont = contIniFin(1): contIniFin(2)
    contwaitbar = contwaitbar +1;

    I = imread(filenames{cont}); I = I(:,:,1);  
    [m,n] = size(I);
    BW2 = poly2mask(h1.Vertices(:,1),h1.Vertices(:,2),m,n);
    BW3 = imcrop(I,ROI);
    BW3 = nanmean(BW3, 'all');
    BW = imbinarize(I,BinThreshold); 
    BW = BW2.*BW;
    BW = imcrop(BW,ROI);
    
    gridIntensity = BW3;
    assignin('base', 'gridIntensity', gridIntensity)
    
    % Detection algorithm: MSER features
    [~,mserCC] = detectMSERFeatures(BW,'RegionAreaRange',[1 14000]);
    Area  = regionprops('table',mserCC, 'Area');
    
    % Filtering spourious tracers
    AreaFiltered = cat(1, Area.Area);
    AreaFiltered(AreaFiltered<MinValueAreaTracers) = NaN;
    AreaFiltered(AreaFiltered>(blockSizeR/2)*(blockSizeR/2)) = NaN;
    MeanAreaFiltered(cont) = nanmean(AreaFiltered);
    VarAreaFiltered = nanvar(AreaFiltered);
    sAreaFiltered = ceil(AreaFiltered./ MeanAreaFiltered(cont));
    sAreaFiltered(isnan(sAreaFiltered))=[];
    NumberParticles  = sum(sAreaFiltered);
    
    % Computation of Variables
    SeedingDensity(cont) =  sum(NumberParticles)/(abs(h1.Vertices(1,2)- h1.Vertices(2,2))*abs(h1.Vertices(2,1)- h1.Vertices(3,1)));
    CV_Area(cont) = sqrt(VarAreaFiltered)./MeanAreaFiltered(cont);
    Dispersion(cont)=AggregationFunction(BW,blockSizeR,blockSizeR,MinValueAreaTracers,MeanAreaFiltered(cont));

    waitbar(contwaitbar/(contIniFin(2)-contIniFin(1)),wbar,'Processing Seeding Metrics Analysis');
end
close(wbar);

MeanDensity = nanmean(SeedingDensity);
MeanCV_Area = nanmean(CV_Area);
MeanNu = nanmean(Dispersion);
SDI = ((Dispersion.^0.1)./(SeedingDensity./1.52E-03));

%% Plotting
figure
subplot(4,1,1)
plot(contIniFin(1):(contIniFin(2)),SeedingDensity)
xlabel('Frame Number')
ylabel('\rho (ppp)')

subplot(4,1,2)
plot(contIniFin(1):(contIniFin(2)),Dispersion)
xlabel('Frame Number')
ylabel('D^*')

subplot(4,1,3)
plot(contIniFin(1):(contIniFin(2)),CV_Area)
xlabel('Frame Number')
ylabel('CV Area')

subplot(4,1,4)
plot(contIniFin(1):(contIniFin(2)),SDI)
xlabel('Frame Number')
ylabel('SDI')
end


function [Dispersion]=AggregationFunction(Frame,blockSizeR,blockSizeC,MinValueAreaTracers,MeanAreaFiltered)
% Reading Frame
rgbImage = Frame(:,:,1);

% Getting properties of the Frame
[rows,columns,numberOfColorBands] = size(rgbImage);

% Dividing the ROI in blocks of size: blockSizeR x blockSizeC
wholeBlockRows = floor(rows / blockSizeR);
blockVectorR = [blockSizeR * ones(1, wholeBlockRows), rem(rows, blockSizeR)];
wholeBlockCols = floor(columns / blockSizeC);
blockVectorC = [blockSizeC * ones(1, wholeBlockCols), rem(columns, blockSizeC)];

% Analysis for Grayscale or full RGB  images
if numberOfColorBands > 1
    ca = mat2cell(rgbImage, blockVectorR, blockVectorC, numberOfColorBands);
else
    ca = mat2cell(rgbImage, blockVectorR, blockVectorC);
end

numPlotsR = size(ca, 1);
numPlotsC = size(ca, 2);
contParticles = 1;

% Empirical aggregation Analysis
for r = 1 : numPlotsR
    for c = 1 : numPlotsC
        rgbBlock = ca{r,c};
        [rowsB,columnsB,~] = size(rgbBlock);
        if rowsB == blockSizeR && columnsB == blockSizeC
            [~,mserCC] = detectMSERFeatures(rgbBlock,'RegionAreaRange',[1 14000]);
            Area  = regionprops('table',mserCC, 'Area');
            AreaFiltered = cat(1, Area.Area);
            AreaFiltered(AreaFiltered<MinValueAreaTracers) = NaN;
            AreaFiltered(AreaFiltered>(blockSizeR/2)*(blockSizeR/2)) = NaN;
            sAreaFiltered = ceil(AreaFiltered./MeanAreaFiltered);
            sAreaFiltered(isnan(sAreaFiltered))=[];
            
            SumArea(contParticles) = nansum(sAreaFiltered);
            NumberParticles (contParticles) = sum(sAreaFiltered);
            contParticles = contParticles + 1;
        end
    end
end
Dispersion = nanvar(NumberParticles)/nanmean(NumberParticles); % Computation of the Aggregation/Dispersion parameter D*
end