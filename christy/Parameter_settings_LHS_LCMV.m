% PARAMETER BASELINE VALUES
%s=10; 
%muT=2e-2;
%r=0.03;
%Tmax=1500;
%k1=2.4e-5;
%k2=3e-3;
%mub=0.24;
%N=1200;
%muV=2.4;
%dummy=1;

betai = .0016;%Transmission rate between infected state and susceptible state (individuals/year)
betac = .0081;%Transmission rate between carrier state and susceptible state (individuals/year)
lambdai = 460;% normal birth rate(individuals/year)
lambdac = 460;%birth rate of carriers (individuals/year)
fi = 1; %Fraction of vertical transmission between infected mothers and offspring
fc = 0.5; %Fraction of vertical transmission between carrier mothers and offspring
v= 4.1; %Rate of recovery (per year)
mui = 0.46; %natural death rate (per year)
muc = 0.46; % Natural death rate of carrier individuals (per year)
alphai = 0; %death due to infection (per year)
alphac = 0; %death due to chronic infection (per year)
delta = 0;%Rate of reinfection (per year)

% Parameter Labels 
%PRCC_var={'b', '\mu_T', 'r', ...
%    'k_1','k_2', '\mu_b','N_V', '\mu_V','dummy'};% 

PRCC_var={'betai','betac','lambdai','lambdac','fi', ...
    'fc','v','mui','muc','alphai','alphac','delta'}; 

%% TIME SPAN OF THE SIMULATION
t_end=4000; % length of the simulations
tspan=(0:1:t_end);   % time points where the output is calculated
time_points=[2000 4000]; % time points of interest for the US analysis

% INITIAL CONDITION FOR THE ODE MODEL
S=998;
I=1;
R=0;
C=1;

y0=[S,I,R,C];

% Variables Labels
y_var_label={'S','I','R','C'};
