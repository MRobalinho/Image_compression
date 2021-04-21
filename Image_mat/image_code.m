%
% http://www.owlnet.rice.edu/~elec539/Projects99/JAMK/proj1/
%
%%---------------------
function z = rowthing(A);

n = length(A);
for i=1:n,
        k=1;
        for j=1:2:(n-1),
                z(i,k) =  (A(i,j) + A(i, j+1))/sqrt(2);
                z(i, k + n/2) = (A(i,j) - A(i,j+1))/sqrt(2);
                k=k+1;
        end
end


%--------------------------------------------------
function z = colthing(A);

n = length(A);
for j=1:n,
        k=1;
        for i=1:2:(n-1),
                z(k,j) =  (A(i,j) + A(i+1, j))/sqrt(2);
                z(k + n/2,j) = (A(i,j) - A(i+1,j))/sqrt(2);
                k=k+1;
        end
end

%--------------------------------------------------
function [z,b] = squisher(A, b16, b32, b64, b128, b256);

n=length(A);
b=A;
while n>16
        c=colthing(rowthing(b(1:n,1:n)));
        b(1:n,1:n) = c(1:n,1:n);
        n=n/2;
end

% now we need to quantize the image with diff num of bits for each region
z = quant(b, b16, b32, b64, b128, b256);


%--------------------------------------------------
function z = quant(A,b16,b32,b64,b128,b256);

q=[b16,b32,b64,b128,b256];
k=5;
n=256;
while (n >= 16)
        z(1:n,1:n) = round(A(1:n,1:n).*2.^q(k)./256);
        n=n/2;
        k=k-1;
end

%--------------------------------------------------
function b=bit(a, b16, b32, b64, b128, b256)

a = a*256/max(max(a));
mask(1:16, 1:16) = b16;
mask(17:32, 1:16) = b32;
mask(17:32, 17:32) = b32;
mask(1:16, 17:32) = b32;
mask(33:64, 1:32) = b64;
mask(33:64, 33:64) = b64;
mask(1:32, 33:64) = b64;
mask(65:128, 1:64) = b128;
mask(65:128, 65:128) = b128;
mask(1:64, 65:128) = b128;
mask(129:256, 1:128) = b256;
mask(129:256, 129:256) = b256;
mask(1:128, 129:256) = b256;

fid = fopen('boybit.bin','wb');
for(i=1:length(mask)^2)
        if (mask(i) ~= 0)
                w1=strcat('ubit', int2str(mask(i)));
                fwrite(fid, a(i), w1);
        end
end
fclose('all');

fid = fopen('boybit.bin','rb');
b=zeros(length(mask));
for (j = 1:length(mask)^2)
        if (mask(j) ~= 0)
                w2 = strcat('ubit', int2str(mask(j)));
                b(j) = fread(fid, 1, w2);
        else
                w2 = 'ubit1';
        end
end



%--------------------------------------------------
function z = iquant(A,b16,b32,b64, b128, b256);

q=[b16,b32,b64,b128,b256];
k=5;
n=256;
while (n >= 16)
        z(1:n,1:n) = round(A(1:n,1:n)./2.^q(k).*256);
        n=n/2;
        k=k-1;
end



%--------------------------------------------------
function z = rowthingi(A);

n = length(A);
for i=1:n,
        k=1;
        for j=1:(n/2),
                z(i,k) = (A(i,j)+A(i,j+n/2))/sqrt(2);
                z(i,k+1) = (A(i,j)-A(i,j+n/2))/sqrt(2);
                k=k+2;
        end
end



%--------------------------------------------------
function z = colthingi(A);

n = length(A);
for j=1:n,
        k=1;
        for i=1:(n/2),
                z(k,j) = (A(i,j) + A(i+n/2, j))/sqrt(2);
                z(k+1,j ) = (A(i,j) - A(i+n/2,j))/sqrt(2);
                k=k+2;
        end
end



%--------------------------------------------------
function [b,d] = unsquisher(A, b16, b32, b64, b128, b256);

b = iquant(A, b16, b32, b64, b128, b256);
N=length(A);
n=32;

d=b;
while n <= N
        c=rowthingi(colthingi(d(1:n,1:n)));
        d(1:n,1:n) = c(1:n,1:n);
        n=n*2;
end