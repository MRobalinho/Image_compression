% https://towardsdatascience.com/building-a-narx-in-matlab-to-forecast-time-series-data-f60561864874
path = 'height.csv';
%read data example: Import columns as column vectors 
[X Y Z] = csvimport(path, 'columns', {'X, 'Y', 'Z'});
%remove headers
X(1) = [];
Y(1) = [];
Z(1) = [];