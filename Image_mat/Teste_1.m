%% Read Picture - load file from disk and show its pixel values
file = 'flower.bmp';
table = imread(file);
imshow(table);
%% Image block processing

secondlevelTIFF = imread(file);
imshow(secondlevelTIFF);
axis on;
[rows, columns, numberOfColorChannels] = size(secondlevelTIFF);
hold on;
for row = 1 : 50 : rows
  line([1, columns], [row, row], 'Color', 'r');
end
for col = 1 : 50 : columns
  line([col, col], [1, rows], 'Color', 'r');
end
%% Obtain Edges Figure

file = 'flower.bmp';
file_name = file;
I = imread(file_name);
normal_edges = edge(I,'canny');

imshow(I)
title('Original Image')
%% Edges
imshow(normal_edges)
title('Conventional Edge Detection')
%% Mirror padding

table_crop = table(1:end-4,1:end-4);
table_padded = padarray(table_crop,[4,4],'symmetric','post');
imshow(table_padded);
%% Mirror-padded block
imshow(table_padded(1:8,end-7:end));

%% DCT Block Transforming
posr = 12; posc = 13;
f = table*0.3;
f(8*(posr-1)+1:8*(posr-1)+8,8*(posc-1)+1:8*(posc-1)+8) = table(8*(posr-1)+1:8*(posr-1)+8, 8*(posc-1)+1:8*(posc-1)+8);
imshow(f);
%% Magnification of the selected block
b = table(8*(posr-1)+1:8*(posr-1)+8, 8*(posc-1)+1:8*(posc-1)+8)
imshow(b);
%% DCT of a given image block
d = dct2(double(b)-128),
imshow(d);
%% DCT coefficients
v = sort(abs(d(:)),1,'descend');
plot(v);
%% coefficients with highest energy
dct_energy_distribution = cumsum(v.*v)/sum(v.*v);

%% umulated percentage of energy
bv = sort(double(b(:)),1,'descend');
ima_energy_distribution = cumsum(bv.*bv)/sum(bv.*bv);
imshow(ima_energy_distribution)
%%  Zigzag scan
v = zigzag8(d);
for N=[1 4 8 16 32 48]
ve = [v(1:N),zeros(1,64-N)];
dr = izigzag8(ve);
br = uint8(idct2(dr)+128);
imshow(br);
end;