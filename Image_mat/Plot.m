plot(X,J,’LineWidth’,1.5)
axis([0 20 -.5 1])
grid on
legend(‘J_0',’J_1',’J_2',’J_3',’J_4',’Location’,’Best’)
title(‘Bessel Functions of the First Kind for v = 0,1,2,3,4')
xlabel(‘X’)
ylabel(‘J_v(X)’)
X = 0:0.1:20;
X = 0:0.1:20;
J = zeros(5,201);
for i = 0:4 J(i+1,☺ = besselj(i,X);
end
plot(X,J,’LineWidth’,1.5)
axis([0 20 -.5 1])
grid on
legend(‘J_0',’J_1',’J_2',’J_3',’J_4',’Location’,’Best’)
title(‘Bessel Functions of the First Kind for v = 0,1,2,3,4')
xlabel(‘X’)
ylabel(‘J_v(X)’)
fig2plotly();