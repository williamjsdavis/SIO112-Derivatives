%%% SIO112 
%%% Chapter 5 + ε
%%% Section 2: Demonstration
% William Davis, April 2023
clearvars,close all

%% Plotting variables
big_font = 20;


%% Demonstration
% Experimenting on sin(x)

x_eval = 0.55;

z_eval = Dual(x_eval,1);

dual_result = sinm(z_eval);

real_part = st(dual_result);
inft_part = in(dual_result);

disp(real_part)
disp(inft_part)

disp(inft_part - cos(0.55))

%% Data example
global y_data_noisy x_data

m_true = @(x) expm(-4.5/x^2);
x_true_plot = linspace(0,8,100);
y_true_plot = arrayfun(m_true,x_true_plot);

n_data = 100;
x_data = linspace(0.5,8,n_data);
y_data = arrayfun(m_true,x_data);
y_data_noisy = max(0,y_data + 0.05*randn(size(x_data)));

figure
hold on
plot(x_true_plot,y_true_plot)
scatter(x_data,y_data_noisy)
legend('True','Data','Location','northwest')
xlabel('x')
xlabel('y')
title('Data from experiments')
set(findall(gcf,'-property','FontSize'),'FontSize',big_font)

%% Setting up model, data, and error

% Function at m_prediction.m
%m_prediction = @(x,gamma) expm(-gamma/x^2);

m_data = @(gamma) arrayfun(@(x) m_prediction(x,gamma), x_data);

% True loss landscape
gamma_range = linspace(0.1,10,100);
error_range = arrayfun(@model_error,gamma_range);

figure
plot(gamma_range,error_range)
xlabel('gamma')
ylabel('error')
title('Error as a function of gamma')
set(findall(gcf,'-property','FontSize'),'FontSize',big_font)

% Gradient of error metric

x_eval = 5.5;

z_eval = Dual(x_eval,1);
dual_result = model_error(z_eval);
real_part = st(dual_result);
inft_part = in(dual_result);

disp(real_part)
disp(inft_part)

%% Finite difference gradient

disp(model_error(x_eval))
disp((model_error(x_eval+0.000001)-model_error(x_eval))/0.000001)

%% Optimising

options = optimoptions('fminunc','Algorithm','trust-region', ...
    'SpecifyObjectiveGradient',true);

x0 = 100;
x = fminunc(@model_and_gradient,x0,options)

%% Functions
function err = model_error(gamma)
err = 0;
global y_data_noisy x_data
for i = 1:length(y_data_noisy)
    err = err + (y_data_noisy(i)*gamma^0 - ...
                        m_prediction(x_data(i),gamma))^2;
end
end
function [real_part,inft_part] = model_and_gradient(gamma)
% Calculate objective f
z_eval = Dual(gamma,1);
dual_result = model_error(z_eval);
real_part = st(dual_result);
inft_part = in(dual_result);
end