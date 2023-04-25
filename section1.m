%%% SIO112 
%%% Chapter 5 + ε
%%% Section 1: Numerical derivatives, a.k.a. finite differences
% William Davis, April 2023
clearvars,close all

%% Plotting variables
big_font = 20;

%% Example function

x_domain = linspace(0,1,100);

f = @(x) sin(x);
dfdx = @(x) cos(x);

f_sample = f(x_domain);

dfdx_sample = dfdx(x_domain);

figure
hold on
plot(x_domain,f_sample)
plot(x_domain,dfdx_sample)
xlabel('x')
ylabel('f(x) and f''(x)')
title('Example function')
legend('Function','True derivative')
set(findall(gcf,'-property','FontSize'),'FontSize',big_font)

%% Exercise 1.3 -- Finite differences

n_sample = 10;
x_finite_sample = linspace(0,1,n_sample);

dx = x_finite_sample(2) - x_finite_sample(1);

f_finite_sample = f(x_finite_sample);
dfdx_finite_diff = (f_finite_sample(2:end) - f_finite_sample(1:end-1))/dx;
x_domain_finite_diff = x_finite_sample(1:end-1);

figure
hold on
plot(x_finite_sample,f_finite_sample)
plot(x_domain,dfdx_sample)
plot(x_domain_finite_diff,dfdx_finite_diff)
xlabel('x')
ylabel('f(x) and f''(x)')
title('Exercise 1.3')
legend('Function','True derivative','Finite derivative')
set(findall(gcf,'-property','FontSize'),'FontSize',big_font)

%% Exercise 1.4 -- Finite difference errors

x_point = 0.55;

dfdx_true_point = dfdx(x_point);

dx_range = logspace(-1,-4,10);

dfdx_finite_diff_point = zeros(size(dx_range));
for i = 1:length(dx_range)
    dx = dx_range(i);
    dfdx_finite_diff_point(i) = (f(x_point+dx) - f(x_point))/dx;
end

figure
hold on
yline(dfdx_true_point)
plot(dx_range,dfdx_finite_diff_point)
xlabel('dx')
ylabel(sprintf('f''(%.2f)',x_point))
title('Exercise 1.4')
legend('True derivative','Finite derivative')
set(gca,'XScale','log')
set(findall(gcf,'-property','FontSize'),'FontSize',big_font)

%% Exercise 1.4 continued

dx_range = logspace(-1,-16,10);

error_finite_diff_point = zeros(size(dx_range));
for i = 1:length(dx_range)
    dx = dx_range(i);
    dfdx_finite_diff_point = (f(x_point+dx) - f(x_point))/dx;
    error_finite_diff_point(i) = ...
        abs(dfdx_finite_diff_point - dfdx_true_point);
end

figure
hold on
plot(dx_range,error_finite_diff_point)
xlabel('dx')
ylabel('Abs. error on derivative')
title('Exercise 1.4')
set(gca,'XScale','log')
set(gca,'YScale','log')
set(findall(gcf,'-property','FontSize'),'FontSize',big_font)

