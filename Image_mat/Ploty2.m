getplotlyoffline('https://cdn.plot.ly/plotly-latest.min.js')
X = linspace(0,2*pi,50)';
Y = [cos(X), 0.5*sin(X)];
stem(X,Y)
fig2plotly(gcf, 'offline', true);