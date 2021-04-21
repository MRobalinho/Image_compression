% 
% We need convert from RGB to a luminance space, such as YCbCr. 
% The human eye has higher resolution in luminance (Y) than in the color channels, 
% so you can decimate the colors much more than the luminance for the same level of loss. 
% It is common to begin by reducing the resolution of the Cb and Cr channels by a factor of 
% two in both directions, reducing the size of the color channels by a factor of four. 
%  
% Second, you should use a discrete cosine transform (DCT), which is effectively the real
% part of the discrete Fourier transform of the samples shifted over one-half step.
% What is done in JPEG is to break the image up into 8x8 blocks for each channel,
% and doing a DCT on every column and row of each block. Then the DC component is 
% in the upper left corner, and the AC components increase in frequency as you go
% down and to the left. You can use whatever block size you like, though the overall
% computation time of the DCT will go up with the size, and the artifacts from the 
% lossy step will have a broader reach.
% 
% Now you can make it lossy by quantizing the resulting coefficients, more so in the
% higher frequencies. The result will generally have lots of small and zero coefficients,
% which is then highly compressible with run-length and Huffman coding.
%----
% https://en.wikipedia.org/wiki/JPEG#JPEG_codec_example
% Although a JPEG file can be encoded in various ways, most commonly it is done with JFIF encoding. 
% The encoding process consists of several steps:
% 
% > The representation of the colors in the image is converted to Y′CBCR, consisting of one luma component (Y'),
%     representing brightness, and two chroma components, (CB and CR), representing color. This step is sometimes
%     skipped.
% > The resolution of the chroma data is reduced, usually by a factor of 2 or 3. This reflects the fact that
%     the eye is less sensitive to fine color details than to fine brightness details.
% > The image is split into blocks of 8×8 pixels, and for each block, each of the Y, CB, and CR data 
%     undergoes the discrete cosine transform (DCT). A DCT is similar to a Fourier transform in the 
%     sense that it produces a kind of spatial frequency spectrum.
% > The amplitudes of the frequency components are quantized. Human vision is much more sensitive to 
%     small variations in color or brightness over large areas than to the strength of high-frequency 
%     brightness variations. Therefore, the magnitudes of the high-frequency components are stored with 
%     a lower accuracy than the low-frequency components. The quality setting of the encoder 
%     (for example 50 or 95 on a scale of 0–100 in the Independent JPEG 
%      Group's library[52]) affects to what extent the resolution of each frequency component is reduced.
%      If an excessively low quality setting is used, the high-frequency components are discarded altogether.
% > The resulting data for all 8×8 blocks is further compressed with a lossless algorithm, 
%     a variant of Huffman encoding.
% > The decoding process reverses these steps, except the quantization because it is irreversible.
%   In the remainder of this section, the encoding and decoding processes are described in more detail.
%% ----
% -- Test on 17-04-2021
clear all;
close all;
clc;
warning off all;
%% Input Image
%A = imread('images/women2.jpg');
A = imread('images/dance1.jpg');
%A = imread('images/dog1.jpg');

% ------
% magesc(C) displays the data in array C as an image that uses the full range of colors in the colormap.
imagesc(A)   
title('Original Image')
figure
%----- RGB Transform
B = rgb2gray(A);
imagesc(256-A)
title('RGB Image')
set(gcf,'Position', [1500 100 size(A,2) size(A,1)]);

%% FFT - Fast Fourier Transform and Image Compression
Bt = fft2(B);  % B is gray scale image
Blog = log(abs(fftshift(Bt))+1); % put FFT on log scale
imshow(256-mat2gray(Blog),[]);
set(gcf,'Position', [1500 100 size(A,2) size(A,1)]); % set(H,Name,Value) specifies a value for the property Name on the object identified by H. 

%% FFT
% Zero all small coefficients and inverse transformation
Btsort = sort(abs(Bt(:)));  % sort by magnitude
counter = 1;
for keep=[.99 .05 .01 .002]
    
    % thresh = multithresh(A) returns the single threshold value thresh 
    % computed for image A using Otsu’s method. You can use thresh as an 
    % input argument to imquantize to convert an image into a two-level image.
    
    % Y = floor(X) rounds each element of X to the nearest integer less than 
    % or equal to that element.
    thresh = Btsort(floor((1-keep)*length(Btsort))); % L = length(X) returns the length of the largest array dimension in X.
    ind = abs(Bt)>thresh; % find small indices
    Atlow = Bt .* ind;     % Threshold small indices
    Alow = uint8(ifft2(Atlow)); % Compress image
    
    % Present image
    subplot(2,2,counter),
    imshow(256-Atlow),  % Reconstrtuction
    title(['',num2str(keep*100),'%']);
    counter = counter + 1;
end
set(gcf,'Position', [1750 100 1750 2000]); % set(H,Name,Value) specifies a value for the property Name on the object identified by H. 
        
    