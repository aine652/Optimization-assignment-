clc;
clear;
close all;

% Objective function
fun = @(x) 0.04*x(1)^2 + 0.06*x(2)^2 - 4*x(1) - 5*x(2) + 200;

% Initial guess
x0 = [20 20];

% Run fminsearch
[x,fval] = fminsearch(fun,x0);

% Display results
fprintf('   WATER PUMPING OPTIMIZATION\n');
fprintf('Optimal x1 = %.4f m^3/h\n',x(1));
fprintf('Optimal x2 = %.4f m^3/h\n',x(2));
fprintf('Minimum pumping cost = %.4f\n',fval);

% Create values for plotting
x1 = linspace(0,80,200);
x2 = linspace(0,80,200);

[X1,X2] = meshgrid(x1,x2);

% Calculate cost over the grid
C = 0.04*X1.^2 + 0.06*X2.^2- 4*X1 - 5*X2 + 200;

% PLOT 1: CONTOUR PLOT
figure;
contourf(X1,X2,C,30);
colorbar;
hold on;

% Mark optimum
plot(x(1),x(2),'kp','MarkerSize',14,'MarkerFaceColor','w');
xlabel('x_1 (m^3/h)');
ylabel('x_2 (m^3/h)');
title('Contour Plot of Water Pumping Cost');
legend('Cost contours','Optimal point');
grid on;
hold off;

% PLOT 2: 3-D SURFACE PLOT
figure;
surf(X1,X2,C);
colorbar;
shading interp;
hold on;

% Mark optimum on surface
plot3(x(1),x(2),fval,'kp', 'MarkerSize',14,'MarkerFaceColor','w');
xlabel('x_1 (m^3/h)');
ylabel('x_2 (m^3/h)');
zlabel('Pumping Cost');
title('3-D Surface Plot of Water Pumping Cost');
grid on;
hold off;