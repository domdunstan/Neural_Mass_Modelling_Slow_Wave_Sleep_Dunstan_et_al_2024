

% Define typical parameter values
paramsvec=[30,30,0.03,0.06,-58.5,-58.5,5,6,0.07,0.0586,120,90,72,90,1,1,...
    -64,-64,-100,0,-70,2,1.3,0.09,9.5,1,1,3,38.7,3.5,15,5];


% for reference define parameter order
paramnames={'\tau_e';'\tau_i';'Q_e^{max}';'Q_i^{max}';'\theta_e';...
    '\theta_i';'\sigma_e';'\sigma_i';'\gamma_e';'\gamma_i';...
    'N_{ee}';'N_{ie}';'N_{ei}';'N_{ii}';'C_m';'g_l';'E_l';'E_e';'E_k';...
    'E_{ampa}';'E_{gaba}';'\alpha_{Na}';'\tau_{Na}';'R_{pump}';'N_a^{eq}';'g_{ampa}';'g_{gaba}';'g_k^{na}';'EC';'n_e';'K_p';'\phi'};
% set bounds on params
per=25; % percentage bounds

ub=paramsvec+(per/100)*abs(paramsvec);
lb=paramsvec-(per/100)*abs(paramsvec);

% adjust bounds for timescale parameters
per2 = 100;
ub([9,10])=paramsvec([9,10])+(per2/100)*abs(paramsvec([9,10]));
lb([9,10])=paramsvec([9,10])-(per2/100)*abs(paramsvec([9,10]));
lb(9) = 0;
lb(10) = 0;

% adjust bounds for reversal potentials
lb(20)=-50;
ub(20)=50;
lb(21)=-200;
ub(21)=-100;
