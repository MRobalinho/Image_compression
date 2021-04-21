% http://faculty.washington.edu/sbrunton/me565/
% Steve Brunton, MEB 305
% https://www.youtube.com/watch?v=uB3v6n8t2dQ

%% ---
clear all, close all, clc

%% Load full image
disp('Loading full image...')
% A = imread('hat','png');
A=imread('images/women6.jpg', 'jpeg'); 
%A=imread('images/man2.jpg', 'jpeg'); 
% A=imread('images/women2.jpg','jpeg');
% A=imread('DOGCAT', 'jpeg'); 
% A=imread('ROSIE', 'bmp'); 
% B = A+uint8(50*rand(size(A)));
figure(3);
imshow(A)
title('Original image','FontSize',18)
% figure(4);
% imshow(B)
% B= 255-A;
% imshow(B)

%% Make image black and white
Abw2=rgb2gray(A); 
[nx,ny]=size(Abw2); 
figure(1), subplot(2,2,1), imshow(Abw2)
title('Original image','FontSize',18)

%% Compute the FFT of our image using fft2
disp('Doing FFT analysis for sparsity check...')
tic;  % tic function records the current time
At=fft2(Abw2); 
% At =Atlow;
F = log(abs(fftshift(At))+1);
F = mat2gray(F); % Use mat2gray to scale the image between 0 and 1
figure(4)
imshow(F,[]); % Display the result
% 

%% Zero out all small coefficients and inverse transform
disp('Zeroing out small Fourier coefficients...')
tic;

% - Print original image
figure(1), subplot(2,2,1), imshow(Abw2)
title('Original image','FontSize',18)

count_pic=2; 
for thresh=.1*[0.05 0.01 0.002] * max(max(abs(At)))
    ind = abs(At)>thresh;

    per = thresh .* 10 / max(max(abs(At)))

    Atlow = At.*ind;

    Alow=uint8(ifft2(Atlow)); 
    figure(1), subplot(2,2,count_pic), imshow(Alow);
    count_pic=count_pic+1;
    drawnow
    title([num2str(per ) '% of FFT basis'],'FontSize',18)
end
disp(['    done. (' num2str(toc) 's)'])

%% 
figure
Anew = imresize(Abw2,.1);
surf(double(Anew));