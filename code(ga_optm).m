clc;
clear;
close all;

% Objective function
% GA minimizes, so negative profit is used
fun = @(x) -(50*x(1) + 45*x(2) - 0.2*x(1)^2 - 0.1*x(2)^2);

% Number of decision variables
nvars = 2;

% Linear inequality constraint
% 2*x1 + x2 <= 120
A = [2 1];
b = 120;

% Linear equality constraint
% x1 + x2 = 80
Aeq = [1 1];
beq = 80;

% Lower and upper bounds
lb = [0 0];
ub = [80 80];

% Nonlinear constraint
% x1^2 + x2^2 <= 3400
nonlcon = @(x) deal(x(1)^2 + x(2)^2 - 3400, []);

% Integer constraints
IntCon = [1 2];

% GA options
options = optimoptions('ga','PopulationSize', 50,'MaxGenerations', 100,'Display', 'iter','PlotFcn', @gaplotbestf);

% Run Genetic Algorithm
[x, fval, exitflag, output] = ga(fun, nvars, A, b, Aeq, beq, lb, ub, nonlcon, IntCon, options);

% Calculate maximum profit
maximumProfit = -fval;

% Display results
fprintf('OPTIMIZATION RESULTS \n');
fprintf('Optimal x1 = %d units\n', x(1));
fprintf('Optimal x2 = %d units\n', x(2));
fprintf('Maximum Profit = %.2f\n', maximumProfit);
fprintf('Number of Generations = %d\n', output.generations);

% PLOT 2: CONTOUR PLOT OF THE PROFIT FUNCTION
x1 = linspace(0,80,200);
x2 = linspace(0,80,200);
[X1,X2] = meshgrid(x1,x2);
Profit = 50*X1 + 45*X2 - 0.2*X1.^2 - 0.1*X2.^2;

figure;
contourf(X1,X2,Profit,30);
colorbar;
hold on;

% Plot linear inequality boundary
x1_line = linspace(0,60,200);
x2_line = 120 - 2*x1_line;
plot(x1_line,x2_line,'k--','LineWidth',2);

% Plot equality constraint
x2_eq = 80 - x1_line;
plot(x1_line,x2_eq,'r--','LineWidth',2);

% Plot nonlinear constraint boundary
theta = linspace(0,2*pi,400);
x_circle = sqrt(3400)*cos(theta);
y_circle = sqrt(3400)*sin(theta);
plot(x_circle,y_circle,'b-','LineWidth',2);

% Plot optimum
plot(x(1),x(2),'kp', 'MarkerSize',14,'MarkerFaceColor','w');

text(x(1)+2,x(2),sprintf('Optimal (%.0f, %.0f)',x(1),x(2)),'FontSize',10);
xlabel('x_1');
ylabel('x_2');
title('Contour Plot of Production Profit');

legend('Profit contours','2x_1+x_2=120','x_1+x_2=80','x_1^2+x_2^2=3400', ...
       'Optimal solution');

grid on;
hold off;