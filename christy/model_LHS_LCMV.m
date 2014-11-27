%% The results should be compared to the PRCC results section in
%% Supplementary Material D and Table D.1 for different N (specified by
%% "runs" in the script below
clear all;
close all;

%% Sample size N
runs=100;

%% LHS MATRIX  %%
Parameter_settings_LHS_LCMV;

%s_LHS=LHS_Call(1e-2, s, 50, 0 ,runs,'unif'); % baseline = 10
%muT_LHS=LHS_Call(1e-4, muT, 0.2, 0 ,runs,'unif'); % baseline = 2e-2
%r_LHS=LHS_Call(1e-3, r, 50, 0, runs,'unif'); % baseline = 3e-2
%k1_LHS=LHS_Call(1e-7,k1,1e-3, 0 ,runs,'unif'); % baseline = 2.4e-5
%k2_LHS=LHS_Call(1e-5, k2, 1e-2, 0, runs,'unif'); % baseline = 3e-3
%mub_LHS= LHS_Call(1e-1 , mub , 0.4 , 0 , runs , 'unif');  % baseline = 0.24
%N_LHS=LHS_Call(1,N,2e3, 0 ,runs,'unif'); % baseline = 1200
%muV_LHS=LHS_Call(1e-1,muV,1e1, 0 ,runs,'unif'); % baseline = 2.4
%dummy_LHS=LHS_Call(1,1,1e1, 0 ,runs,'unif'); % dummy parameter


%s=latin_hs(xmean,xsd,nsample,nvar)
%  lb = [ .0012 .0072 420 420 .5 .5 4 0.42 0.42 0 0 0]; % lower bounds 
%  ub = [.0020 .0090 500 500 1.5 1.5 4.2 .5 .5 0 0 0]; % upper bounds 

%{
betai_LHS = LHS_Call(.0012, betai, .0020, 0 ,runs,'unif'); 
betac_LHS = LHS_Call(.0072, betac, .0090, 0 ,runs,'unif'); 
lambdai_LHS = LHS_Call(420, lambdai, 500, 0, runs,'unif');
lambdac_LHS = LHS_Call(420, lambdac, 500, 0 ,runs,'unif'); 
fi_LHS = LHS_Call(.5, fi, 1.5, 0, runs,'unif'); 
fc_LHS = LHS_Call(.5, fc, 1.5, 0 , runs , 'unif');  
v_LHS = LHS_Call(4, v, 4.2, 0 ,runs,'unif'); 
mui_LHS = LHS_Call(0.42, mui, .5, 0 ,runs,'unif'); 
muc_LHS = LHS_Call(0.42, muc, .5, 0 ,runs,'unif'); 
alphai_LHS = LHS_Call(0, alphai, 0, 0 ,runs,'unif'); 
alphac_LHS = LHS_Call(0, alphac, 0, 0 ,runs,'unif'); 
delta_LHS = LHS_Call(0, delta, 0, 0, runs,'unif');
%}

betai_LHS=LHS_Call(.0012, .0020, 50, 0 ,runs,'unif'); % baseline = 10
betac_LHS=LHS_Call(.0072, .0090, 0.2, 0 ,runs,'unif'); % baseline = 2e-2
lambdai_LHS=LHS_Call(420, 500, 50, 0, runs,'unif'); % baseline = 3e-2
lambdac_LHS=LHS_Call(420, 500, 1e-3, 0 ,runs,'unif'); % baseline = 2.4e-5
fi_LHS=LHS_Call(.5, 1.5, 1e-2, 0, runs,'unif'); % baseline = 3e-3
fc_LHS= LHS_Call(.5, 1.5, 0.4 , 0 , runs , 'unif');  % baseline = 0.24
v_LHS=LHS_Call(4, 4.2 ,2e3, 0 ,runs,'unif'); % baseline = 1200
mui_LHS=LHS_Call(0.42,.5,1e1, 0 ,runs,'unif'); % baseline = 2.4
muc_LHS=LHS_Call(0.42,.5,1e1, 0 ,runs,'unif'); % baseline = 2.4
alphai_LHS=LHS_Call(0,0,1e1, 0 ,runs,'unif'); % baseline = 2.4
alphac_LHS=LHS_Call(0,0,1e1, 0 ,runs,'unif'); % baseline = 2.4
delta_LHS=LHS_Call(0,0,1e1, 0 ,runs,'unif'); % dummy parameter

%% LHS MATRIX and PARAMETER LABELS
%LHSmatrix=[s_LHS muT_LHS r_LHS k1_LHS k2_LHS ...
%              mub_LHS N_LHS muV_LHS  dummy_LHS];

LHSmatrix=[betai_LHS betac_LHS lambdai_LHS lambdac_LHS fi_LHS fc_LHS v_LHS mui_LHS muc_LHS alphai_LHS alphac_LHS delta_LHS]; 


for x=1:runs %Run solution x times choosing different values
    f=@ODE_LHS_LCMV;
    x
    LHSmatrix(x,:)
    [t,y]=ode15s(@(t,y)f(t,y,LHSmatrix,x,runs),tspan,y0,[]); 
    A=[t y]; % [time y]
    %% Save the outputs at ALL time points [tspan]
    %T_lhs(:,x)=Anew(:,1);
    %CD4_lhs(:,x)=Anew(:,2);
    %T1_lhs(:,x)=Anew(:,3);
    %T2_lhs(:,x)=Anew(:,4);
    %V_lhs(:,x)=Anew(:,5);
       
    %% Save only the outputs at the time points of interest [time_points]:
    %% MORE EFFICIENT
    
    S_lhs(:,x)=A(time_points+1,1);
    %CD4_lhs (:,x)=A(time_points+1,2);
    I_lhs(:,x)=A(time_points+1,2);
    R_lhs(:,x)=A(time_points+1,3);
    C_lhs(:,x)=A(time_points+1,4);
    %{
    T_lhs(:,x)=A(time_points+1,1);
    CD4_lhs(:,x)=A(time_points+1,2);
    T1_lhs(:,x)=A(time_points+1,3);
    T2_lhs(:,x)=A(time_points+1,4);
    V_lhs(:,x)=A(time_points+1,5);
    %}
end
%% Save the workspace
save Model_LHS.mat;
% CALCULATE PRCC
%[prcc sign sign_label]=PRCC(LHSmatrix,V_lhs,1:length(time_points),PRCC_var,alpha);