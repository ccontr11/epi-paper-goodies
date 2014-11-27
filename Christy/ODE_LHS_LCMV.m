function dydt=TBmodel(t,y,LHSmatrix,x,runs)
%% PARAMETERS %%
Parameter_settings_LHS_LCMV;

%s=LHSmatrix(x,1);
%muT=LHSmatrix(x,2);
%r=LHSmatrix(x,3);
%k1=LHSmatrix(x,4);
%k2=LHSmatrix(x,5);
%mub=LHSmatrix(x,6);
%N=LHSmatrix(x,7);
%muV=LHSmatrix(x,8);
%dummy_LHS=LHSmatrix(x,9);


betai = LHSmatrix(x,1);
betac = LHSmatrix(x,2);
lambdai = LHSmatrix(x,3);
lambdac = LHSmatrix(x,4);
fi = LHSmatrix(x,5);
fc = LHSmatrix(x,6);
v= LHSmatrix(x,7);
mui = LHSmatrix(x,8);
muc = LHSmatrix(x,9);
alphai = LHSmatrix(x,10);
alphac = LHSmatrix(x,11);
delta = LHSmatrix(x,12);

% [T] CD4+ uninfected: Tsource + Tprolif - Tinf
%Tsource = s - muT*y(1);
%Tprolif = r*y(1)*(1-(y(1)+y(2)+y(3))/Tmax);
%Tinf = k1*y(1)*y(4);

% [T1] CD4+ latently infected: Tinf - T1death - T1inf
%T1death = muT*y(2);
%T1inf = k2*y(2);

% [T2] CD4+ actively infected: T1inf - T2death
%T2death = mub*y(3);

% [V] Free infectious virus: Vrelease - Tinf - Vdeath
%Vrelease = N*T2death;
%Vdeath = muV*y(4);

S=y(1);%All susceptible population
I=y(2);%Infected with LCMV
R=y(3);%Recover from LCMV
C=y(4);%Carriers
N=S+I+R+C;

%Suceptible [S]
dy(1) = lambdai.*[[y(1)+y(3)+(1-fi).*y(2)+(1-fc).*y(4)]./N]-betai.*y(2).*y(1)-betac.*y(4).*y(1)-mui.*y(1);
%Infected [I]
dy(2) = betai.*y(2).*y(1)+betac.*y(4).*y(1)-alphai.*y(2)-mui.*y(2)-v.*y(2);   
%Recovered [R]
dy(3) = v.*y(2)-mui.*y(3); 
%Carrier [C]
dy(4) = lambdac.*fi.*y(2)./N+lambdac.*fc.*y(4)./N-muc.*y(4)-alphac.*y(4); 

%dydt = [Tsource + Tprolif - Tinf;
%        Tinf - T1death - T1inf;
%        T1inf - T2death;
%        Vrelease - Tinf - Vdeath];

dydt= [dy(1); dy(2); dy(3); dy(4)];