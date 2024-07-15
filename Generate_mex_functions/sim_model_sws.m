function y = sim_model_sws(t, params)


% Function simulates, using the Euler Marayama numerical scheme, the neural mass model developed by Weigenand et al
% 2014 https://doi.org/10.1371/journal.pcbi.1003923.

%% Inputs
% t: time vector to simulate the model for
% params: vector of model parameters. See main script for order

%% output
% y: 11xlength(t) state equations dervied from solving the model with 0
% inital conditions

%%

% set model parameters
tau_e=params(1);
tau_i=params(2);
Q_e_max=params(3);
Q_i_max=params(4);
theta_e=params(5);
theta_i=params(6);
sigma_e=params(7);
sigma_i=params(8);
gamma_e=params(9);
gamma_i=params(10);
Nee=params(11);
Nei=params(12);
Nie=params(13);
Nii=params(14);
Cm=params(15);
gl=params(16);
El=params(17);
Ee=params(18);
Ek=params(19);
Eampa=params(20);
Egaba=params(21);
alpha_Na=params(22);
tau_Na=params(23);
R_pump=params(24);
Naeq=params(25);
g_ampa=params(26);
g_gaba=params(27);
g_kna=params(28);
EC = params(29);
n_e = params(30);
kp = params(31);
phi_n=params(32);

dt=t(2)-t(1);


% Define rhs of model
Napump =@(Na)(R_pump * ( Na^3 / (Na^3 + kp^3) - Naeq^3 / (Naeq^3 + kp^3)));
fatigue =@(Na) ( 0.37 / (1 + (EC / abs(Na)).^n_e));

fe=@(x)(Q_e_max / (1 + exp(-(pi/sqrt(3))*(x - theta_e) / sigma_e)));
fi=@(x)(Q_i_max / (1 + exp(-(pi/sqrt(3))*(x - theta_i) / sigma_i)));

% pre load Guassian noise
noise = randn(1,length(t))*phi_n*sqrt(dt)*gamma_e*gamma_e;

% group parameters for speed
ge1 = gamma_e*gamma_e;
gi1 = gamma_i.*gamma_i;


f=@(y)([(-gl.*(y(1) - Ee) - g_ampa*y(3).*(y(1) - Eampa) - g_gaba*y(5).*(y(1) - Egaba))./tau_e- (1/Cm).*fatigue(y(11)).*g_kna.*(y(1)-Ek);...
(-gl.*(y(2) - El) - g_ampa*y(7).*(y(2) - Eampa) - g_gaba*y(9).*(y(2) - Egaba))./ tau_i;...
y(4);...
ge1*(Nee.*fe(y(1))- y(3)) - 2.*gamma_e.* y(4);...
y(6);...
gi1*(Nie.*fi(y(2)) - y(5)) - 2.* gamma_i.* y(6);...
y(8);...
ge1* (Nei.* fe(y(1)) - y(7)) - 2.* gamma_e.*y(8);...
y(10);...
gi1*(Nii.*fi(y(2)) - y(9)) - 2.* gamma_i.* y(10);...
((-Napump(y(11)) + alpha_Na.* fe(y(1)))./ tau_Na)]);

y=zeros(11,length(t));
% solve using Euler Marayama method
for ii=2:length(t)
    y(:,ii)=y(:,ii-1)+dt*f(y(:,ii-1));
    y(4,ii) =  y(4,ii)+ noise(ii);
end
end




