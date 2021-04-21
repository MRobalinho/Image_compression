%% Work with images
% Load an Image
% Let us examine a real-life example of compression for a given and unoptimized 
% wavelet choice, to p33333eeroduce a nearly complete square norm recovery for an image. 
% https://www.mathworks.com/help/wavelet/ug/data-compression-using-2d-wavelet-analysis.html
% https://www.mathworks.com/help/matlab/ref/importdata.html

x_image = "C:\UC_CExamples\Mathlab_examples\leao-pai-768x512.jpg";

disp('My image:'+x_image);
z = importdata(x_image);
image(z)              % Load original image
title('Original Image')

%%  Step 1: Load and show image

x_image = "leao-pai-768x512.jpg";
I = imread(x_image);
title('Original Image');
imshow(I);
%% Step 2: Check How the Image Appears in the Workspace
% Check how the imread function stores the image data in the workspace, 
% using the whos command. You can also check the variable in the Workspace Browser. 
% The imread function returns the image data in the variable I , 
% which is a 291-by-240 element array of uint8 data.

whos I;
%% Step 3: Improve Image Contrast
% View the distribution of image pixel intensities.
hFig1 = figure;
hAxes1 = axes( figure ); 
imhist(I);
title(hAxes1,'Histogram of the Image Original');

% Improve the contrast in an image, using the histeq function.
I2 = histeq(I);
hFig = figure;
hAxes = axes( figure ); 
imshow(I2, 'Parent', hAxes);
title(hAxes,'Image with contrast');

% Call the imhist function again to create a histogram of the equalized image I2 . 
hFig2 = figure;
hAxes2 = axes( figure ); 
imhist(I2)
title(hAxes2,'Histogram of the Image after incrase contrast');
%% Step 4: Write the Adjusted Image to a Disk File 

imwrite (I2, 'leao.png');
%% Step 5: Check the Contents of the Newly Written File
% The imfinfo function returns information about the image in the file, 
% such as its format, size, width, and height.

imfinfo('leao.png')