clc;
clear;
close all;

% Objective function
% Operating cost
fun = @(x) 0.5*x(1)^2 + 0.8*x(2)^2 - 6*x(1) - 8*x(2) + 100;

% Initial guess
x0 = [30 30];

% Linear inequality constraint
% x1 + x2 <= 100
A = [1 1];
b = 100;

% Linear equality constraint
% 2*x1 + x2 = 120
Aeq = [2 1];
beq = 120;

% Lower bounds
lb = [10 10];

% Upper bounds
ub = [80 80];

% Nonlinear constraint
% x1^2 + x2^2 <= 6500
nonlcon = @(x) deal(x(1)^2 + x(2)^2 - 6500, []);

% Optimization options
options = optimoptions('fmincon','Display','iter','Algorithm','sqp');

% Run fmincon
[x,fval,exitflag,output] = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);

% Display results
fprintf('       OPTIMIZATION RESULTS\n');
fprintf('Optimal pumping rate x1 = %.4f m^3/h\n',x(1));
fprintf('Optimal pumping rate x2 = %.4f m^3/h\n',x(2));
fprintf('Minimum operating cost = %.4f\n',fval);

% Create grid for plotting
x1 = linspace(10,80,200);
x2 = linspace(10,80,200);
[X1,X2] = meshgrid(x1,x2);

% Cost function over the grid
C = 0.5*X1.^2 + 0.8*X2.^2 - 6*X1 - 8*X2 + 100;

% PLOT 1: CONTOUR PLOT

figure;
contourf(X1,X2,C,30);
colorbar;
hold on;

% Linear inequality: x1 + x2 = 100
x1_line = linspace(20,90,300);
x2_line = 100 - x1_line;
plot(x1_line,x2_line,'k--','LineWidth',2);

% Linear equality: 2*x1 + x2 = 120
x2_eq = 120 - 2*x1_line;
plot(x1_line,x2_eq,'r--','LineWidth',2);

% Nonlinear constraint: x1^2 + x2^2 = 6500
theta = linspace(0,2*pi,400);

xc = sqrt(6500)*cos(theta);
yc = sqrt(6500)*sin(theta);
plot(xc,yc,'b-','LineWidth',2);

% Optimal point
plot(x(1),x(2),'kp', 'MarkerSize',14,'MarkerFaceColor','w');

xlabel('x_1 (m^3/h)');
ylabel('x_2 (m^3/h)');
title('Contour Plot of Water Pumping Operating Cost');

legend('Cost contours','x_1+x_2=100','2x_1+x_2=120','x_1^2+x_2^2=6500','Optimal solution','Location','best');
grid on;
hold off;

% PLOT 2: 3-D SURFACE PLOT

figure;
surf(X1,X2,C);
colorbar;
shading interp;
hold on;

% Calculate cost at optimal point
optimalCost = fun(x);

% Mark optimal point on surface
plot3(x(1),x(2),optimalCost,  'kp', 'MarkerSize',14, 'MarkerFaceColor','w');

xlabel('x_1 (m^3/h)');
ylabel('x_2 (m^3/h)');
zlabel('Operating Cost');
title('3-D Surface Plot of Water Pumping Operating Cost');
grid on;
hold off;