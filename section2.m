%%% SIO112 
%%% Chapter 5 + ε
%%% Section 2: Automatic differentiation
% William Davis, April 2023
clearvars,close all

%% Plotting variables
big_font = 20;

%% Example function

x_domain = linspace(0,1,100);

f = @(x) x^2;
dfdx = @(x) 2*x;

f_sample = arrayfun(f,x_domain);

dfdx_sample = arrayfun(dfdx,x_domain);

figure
hold on
plot(x_domain,f_sample)
plot(x_domain,dfdx_sample)
xlabel('x')
ylabel('f(x) and f''(x)')
title('Example function')
legend('Function','True derivative')
set(findall(gcf,'-property','FontSize'),'FontSize',big_font)

%% Implementing dual numbers 

% Constructor (use this anonymous function, or Dual.m)
%Dual = @(a,b) [a,b;0,a];

% Standard/real part (use this anonymous function, or st.m)
%st = @(z) z(1,1);

% Infinitesimal part (use this anonymous function, or in.m)
%in = @(z) z(1,2);

% Testing

z_example = Dual(34,101);

disp(st(z_example))
disp(in(z_example))

%% Exercise 2.3 -- First dual number experiment

x_eval = 5;

z_eval = Dual(x_eval,1);

dual_result = f(z_eval);

real_part = st(dual_result);
inft_part = in(dual_result);

disp(real_part)
disp(inft_part)

%% Exercise 2.4 -- Another experiment
% Function f_1(x) in exercise 1.2

f1 = @(x) 4*x^3 + 2*x - 100*x^0;

x_eval = 1;

z_eval = Dual(x_eval,1);

dual_result = f1(z_eval);

real_part = st(dual_result);
inft_part = in(dual_result);

disp(real_part)
disp(inft_part)

%% Exercise 2.5 -- Another experiment
% Function f_4(x) in exercise 1.2

figure,plot(linspace(0,1.1,100),arrayfun(@f4,linspace(0,1.1,100)))

x_eval = 1.01;

z_eval = Dual(x_eval,1);

dual_result = f4(z_eval);

real_part = st(dual_result);
inft_part = in(dual_result);

disp(real_part)
disp(inft_part)
