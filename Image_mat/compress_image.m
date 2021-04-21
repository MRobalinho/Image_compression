%% Data Compression using 2-D Wavelet Analysis
%  
% https://www.mathworks.com/help/wavelet/ug/data-compression-using-2d-wavelet-analysis.html
% View MATLAB Command
% The purpose of this example is to show how to compress an image using two-dimensional wavelet analysis. Compression is one of the most important applications of wavelets. Like denoising, the compression procedure contains three steps:
% Decompose: Choose a wavelet, choose a level N. Compute the wavelet decomposition of the signal at level N.
% Threshold detail coefficients: For each level from 1 to N, a threshold is selected and hard thresholding is applied to the detail coefficients.
% Reconstruct: Compute wavelet reconstruction using the original approximation coefficients of level N and the modified detail coefficients of levels from 1 to N.
%  

%1. Load an Image
%Let us examine a real-life example of compression for a given and unoptimized wavelet choice, to produce a nearly complete square norm recovery for an image.

x_image = "leao-pai-768x512.jpg";
I = imread(x_image);

hFig1 = figure;
hAxes1 = axes( figure ); 
imshow(I);
title(hAxes1,'Image Original');
%% Select image
x = I(100:500,100:500);  % Select ROI
imshow(x);
%% Method 1: Global Thresholding

n = 5;                   % Decomposition level 
w = 'sym8';              % Near symmetric wavelet
[c,l] = wavedec2(x,n,w); % Multilevel 2-D wavelet decomposition

% In this first method, the WDENCMP function performs a compression process 
% from the wavelet decomposition structure [c,l] of the image.
%% In this first method, the WDENCMP function performs a compression process from the wavelet decomposition structure [c,l] of the image.
opt = 'gbl'; % Global threshold
thr = 20;    % Threshold
sorh = 'h';  % Hard thresholding
keepapp = 1; % Approximation coefficients cannot be thresholded
[xd,cxd,lxd,perf0,perfl2] = wdencmp(opt,c,l,w,n,thr,sorh,keepapp);
image(x)
title('Original Image')
colormap(map)

%% Compressed
figure
image(xd)
title('Compressed Image - Global Threshold = 20')
colormap(map)

%% Compressed score
disp('Compressed score %:');
disp(perf0);
disp('L2-norm recovery (%)');
disp(perfl2)
%-----------
disp('The density of the current decomposition sparse matrix is:');
cxd = sparse(cxd);
cxd_density = nnz(cxd)/numel(cxd)
%disp(cxd_density);
%% Summary:

% By using level-dependent thresholding, the density of the wavelet 
% decomposition was reduced by 3% while improving the L2-norm recovery by 3%.
% If the wavelet representation is too dense, similar strategies can be used
% in the wavelet packet framework to obtain a sparser representation. 
% You can then determine the best decomposition with respect to a suitably 
% selected entropy-like criterion, which corresponds to the selected purpose 
% (denoising or compression).

