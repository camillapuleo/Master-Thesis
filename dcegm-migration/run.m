% Created following:
% "The Endogenous Grid Method for Discrete-Continuous Dynamic Choice Models 
%  with (or without) Taste Shocks" (QE, 2017)
% Written by Fedor Iskhakov, Australian National University, 2016
% See Iskhakov, Jorgensen, Rust and Schjerning 

close all
clear
clear classes % update classes in the memory
addpath('utils');



%% Simulation High Skilled
m5=model_migration
m5.ngridm=500;
m5.df=1/(1+m5.r); %flat consumption hopefully
m5.sigma=0.25;
m5.dus=-0.0563;
m5.lambda=0.045; %some EV taste shocks
m5.nsims=1000;
%m5.init=[5 20];
m5.inc0 = 0.65;
m5.minc0 = m5.inc0*1.3;
tic
m5.solve_dcegm;
t=toc;
fprintf('Migration model solved with DC-EGM in %s\n',ht(t));    
%m5.plot('policy');
%m5.plot('value');
%m5.plot('prob_stay');
m5.sim;
%m5.plot('sim');
fprintf('Simulation plots for migration model produced\n')


%% Simulation Low Skilled
m6=model_migration
m6.ngridm=500;
m6.df=1/(1+m6.r); %flat consumption hopefully
m6.sigma=0.25;
m6.dus=-0.0563;
m6.lambda=0.045; %some EV taste shocks
m6.nsims=1000;
%m6.init=[5 20];
m6.inc0 = 0.55;
m6.minc0 = m6.inc0*1.3;
tic
m6.solve_dcegm;
t=toc;
fprintf('Migration model solved with DC-EGM in %s\n',ht(t));    
%m6.plot('policy');
%m6.plot('value');
%m6.plot('prob_stay');
m6.sim;
%m6.plot('sim');
fprintf('Simulation plots for migration model produced\n')

%% Comparison by education

mean1 = 1-mean(m5.sims.prob_stay);
mean2 = 1-mean(m6.sims.prob_stay);

% Plot the first series
plot(mean1); % 'b-' specifies blue solid line

% Hold the current plot
hold on;

% Plot the second series
plot(mean2); % 'r--' specifies red dashed line

% Add title and labels
title('Probability to stay by education level');
xlabel('Age');
ylabel('Probability');

% Add a legend
legend('High', 'Low');

% Release hold
hold off;

%% Grouped graph:
mean1 = mean(m5.sims.prob_stay);
mean2 = mean(m6.sims.prob_stay);

high1 =1- mean(mean1(5:19));
high2 =1- mean(mean1(20:44));
high3 =1- mean(mean1(45:62));
grouped_high = [high1,high2,high3];
low1 =1- mean(mean2(5:19));
low2 =1- mean(mean2(20:44));
low3 =1- mean(mean2(45:62));
grouped_low = [low1,low2,low3];

% Plot the first series
plot(grouped_high); % 'b-' specifies blue solid line

% Hold the current plot
hold on;

% Plot the second series
plot(grouped_low); % 'r--' specifies red dashed line

% Add title and labels
title('Probability to leave by education level');
xlabel('Age Group');
ylabel('Probability');

% Add x-axis ticks and labels
xticks(x_values);
xticklabels({'25-39', '40-64', '65+'});

% Add a legend
legend('High education', 'Low education');

% Release hold
hold off;

%% Actual migration behavior

rhigh1 =1 -Probabilitytoleavehigh{1,9};
rhigh2 = 1-Probabilitytoleavehigh{2,9};
rhigh3 = 1-Probabilitytoleavehigh{3,9};
grouped_rhigh_real = [rhigh1,rhigh2,rhigh3];
rlow1 = 1-Probabilitytoleavelow{1,9};
rlow2 = 1-Probabilitytoleavelow{2,9};
rlow3 = 1-Probabilitytoleavelow{3,9};
grouped_rlow_real = [rlow1,rlow2,rlow3];

% Plot the first series
plot(grouped_rhigh_real); % 'b-' specifies blue solid line

% Hold the current plot
hold on;

% Plot the second series
plot(grouped_rlow_real); % 'r--' specifies red dashed line
plot(grouped_high);
%plot(grouped_low);

% Add title and labels
title('Probability to leave by education level (2019)');
xlabel('Age group');
ylabel('Probability');

% Add x-axis ticks and labels
xticks(x_values);
xticklabels({'25-39', '40-64', '65+'});

% Add a legend
legend('High education', 'Low education');

% Release hold
hold off;



%% Plot consumption paths

meancons_high = mean(m5.sims.consumption)
meancons_low = mean(m6.sims.consumption)

% Plot the first series
plot(meancons_high); % 'b-' specifies blue solid line

% Hold the current plot
hold on;

% Plot the second series
plot(meancons_low); % 'r--' specifies red dashed line

% Add title and labels
title('Mean Consumption by Education Level');
xlabel('Age');
ylabel('Consumption');

% Add a legend
legend('High education', 'Low education');
% Release hold
hold off;

%% Plot savings paths

meanwealth_high = mean(m5.sims.wealth1)
meanwealth_low = mean(m6.sims.wealth1)

% Plot the first series
plot(meanwealth_high); % 'b-' specifies blue solid line

% Hold the current plot
hold on;

% Plot the second series
plot(meanwealth_low); % 'r--' specifies red dashed line

% Add title and labels
title('Mean Wealth by Education Level');
xlabel('Age');
ylabel('Wealth');

% Add a legend
legend('High education', 'Low education');
% Release hold
hold off;


%% Plot income paths

meanwealth_high = mean(m5.sims.income)
meanwealth_low = mean(m6.sims.income)

% Plot the first series
plot(meanwealth_high); % 'b-' specifies blue solid line

% Hold the current plot
hold on;

% Plot the second series
plot(meanwealth_low); % 'r--' specifies red dashed line

% Add title and labels
title('Mean Wealth by Education Level');
xlabel('Age');
ylabel('Wealth');

% Add a legend
legend('High education', 'Low education');
% Release hold
hold off;

%% Plot probability to stay

meanprobstay_high = mean(m5.sims.prob_stay)
meanprobstay_low = mean(m6.sims.prob_stay)

% Plot the first series
plot(meanprobstay_high(1:47)); % 'b-' specifies blue solid line

% Hold the current plot
hold on;

% Plot the second series
plot(meanprobstay_low(1:47)); % 'r--' specifies red dashed line

% Add title and labels
title('Mean Probability to Stay by Education Level');
xlabel('Age');
ylabel('Probability to Stay');

% Add a legend
legend('High', 'Low');
% Release hold
hold off;



%% Parameter search high



% Define initial guess for the parameters
x0 = [-0.05, 0.025]; % Initial guess for parameters x and y

% Define the lower and upper bounds for each parameter
lb = [-0.1, 0.0001]; % Lower bounds for x and y
ub = [0.1, 0.1];   % Upper bounds for x and y

% Set the options for the optimization (tolerance, etc.)
options = optimoptions('fmincon', 'Display', 'iter', 'TolX', 1e-6);

% Define the constraint function
nonlcon = [];


% Solve the optimization problem
[xhigh, fval] = fmincon(@(xhigh) prob_distance(xhigh,Probabilitytoleavehigh,0), x0,[], [], [], [], lb, ub, nonlcon, options);

% Display the results
disp('Optimal solution:');
disp(xhigh);
disp('Optimal function value:');
disp(fval);


%% Parameter search low



% Define initial guess for the parameters
x0 = [-0.05, 0.025]; % Initial guess for parameters x and y

% Define the lower and upper bounds for each parameter
lb = [-0.1, 0.0001]; % Lower bounds for x and y
ub = [0.1, 0.1];   % Upper bounds for x and y

% Set the options for the optimization (tolerance, etc.)
options = optimoptions('fmincon', 'Display', 'iter', 'TolX', 1e-6);

% Define the constraint function
nonlcon = [];

% Solve the optimization problem
[xlow, fval] = fmincon(@(xlow) prob_distance(xlow,Probabilitytoleavelow,1), x0,[], [], [], [], lb, ub, nonlcon, options);

% Display the results
disp('Optimal solution:');
disp(xlow);
disp('Optimal function value:');
disp(fval);



%% Nice simulation graphics using migration model
m5=model_migration
m5.ngridm=500;
m5.df=1/(1+m5.r); %flat consumption hopefully
m5.sigma=0.25;
m5.dus=xhigh(1);
m5.lambda=xhigh(2); %some EV taste shocks
m5.nsims=1000;
%m5.init=[5 20];
m5.inc0 = 0.75;
m5.minc0 = m5.inc0*1.4;
tic
m5.solve_dcegm;
t=toc;
fprintf('Migration model solved with DC-EGM in %s\n',ht(t));    
%m5.plot('policy');
%m5.plot('value');
%m5.plot('prob_stay');
m5.sim;
%m5.plot('sim');
fprintf('Simulation plots for migration model produced\n')


%% Nice simulation graphics using migration model
m6=model_migration
m6.ngridm=500;
m6.df=1/(1+m6.r); %flat consumption hopefully
m6.sigma=0.25;
m6.dus=xlow(1);
m6.lambda=xlow(2); %some EV taste shocks
m6.nsims=1000;
%m6.init=[5 20];
m6.inc0 = 0.60;
m6.minc0 = m6.inc0*1.4;
tic
m6.solve_dcegm;
t=toc;
fprintf('Migration model solved with DC-EGM in %s\n',ht(t));    
%m6.plot('policy');
%m6.plot('value');
%m6.plot('prob_stay');
m6.sim;
%m6.plot('sim');
fprintf('Simulation plots for migration model produced\n')


%% Comparison by education

mean1 = 1-mean(m5.sims.prob_stay);
mean2 = 1-mean(m6.sims.prob_stay);

% Plot the first series
plot(mean1); % 'b-' specifies blue solid line

% Hold the current plot
hold on;

% Plot the second series
plot(mean2); % 'r--' specifies red dashed line

% Add title and labels
title('Probability to leave by education level');
xlabel('Age');
ylabel('Probability');

% Add a legend
legend('High', 'Low');

% Release hold
hold off;

%% Grouped graph:
%mean1 = mean(m5.sims.prob_stay);
%mean2 = mean(m6.sims.prob_stay);

high1 = mean(mean1(5:19));
high2 = mean(mean1(20:44));
high3 = mean(mean1(45:62));
grouped_high = [high1,high2,high3];
low1 = mean(mean2(5:19));
low2 = mean(mean2(20:44));
low3 = mean(mean2(45:62));
grouped_low = [low1,low2,low3];

x_values = 1:3;

% Plot the first series
plot(grouped_high); % 'b-' specifies blue solid line

% Hold the current plot
hold on;

% Plot the second series
plot(grouped_low); % 'r--' specifies red dashed line

% Add title and labels
title('Probability to leave by education level');
xlabel('Age Group');
ylabel('Probability');

% Add x-axis ticks and labels
xticks(x_values);
xticklabels({'25-39', '40-64', '65+'});

% Add a legend
legend('High education', 'Low education');

% Release hold
hold off;

%% Actual migration behavior

rhigh1 =1 -Probabilitytoleavehigh{1,9};
rhigh2 = 1-Probabilitytoleavehigh{2,9};
rhigh3 = 1-Probabilitytoleavehigh{3,9};
grouped_rhigh_real = [rhigh1,rhigh2,rhigh3];
rlow1 = 1-Probabilitytoleavelow{1,9};
rlow2 = 1-Probabilitytoleavelow{2,9};
rlow3 = 1-Probabilitytoleavelow{3,9};
grouped_rlow_real = [rlow1,rlow2,rlow3];

% Plot the first series
plot(grouped_rhigh_real); % 'b-' specifies blue solid line

% Hold the current plot
hold on;

% Plot the second series
plot(grouped_rlow_real); % 'r--' specifies red dashed line
plot(grouped_high);
plot(grouped_low);

% Add title and labels
title('Probability to leave by education level (2019)');
xlabel('Age group');
ylabel('Probability');

% Add x-axis ticks and labels
xticks(x_values);
xticklabels({'25-39', '40-64', '65+'});

% Add a legend
legend('High education', 'Low education');

% Release hold
hold off;
