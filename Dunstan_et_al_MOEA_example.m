

%% %% %% %% %% %%  MASTER SCRIPT FOR Running example MOEA %% %% %% %% %% %% %%%
%                                                                             %
%    Neural mass modelling reveals that hyperexcitability underpins           %
%        slow wave sleep changes in children with epilepsy                    %
%                                                                             %           
% Dominic M. Dunstan*, Samantha YS Chan, Marc Goodfellow                      %
%                                                                             %
%  [LINK TO PREPRINT ]                                                        %
%                                                                             %
% Execution of this script runs a single example of the                       %
% Multiobjecitve evolutionary algorithm (MOEA).                               %
% For full details on the MOEA used, see the paper and references therein.    %           
%                                                                             %
% This software uses a number of external toolboxes. We are grateful to the   %
% authors of these toolboxes. In each case, the licenses are stated within    %
% the corresponding header.                                                   %
%                                                                             %
% University of Exeter, 2024.                                                  %
% Please email me if you have any questions                                   %
% *dmd206@exeter.ac.uk                                                        %
% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% % % %


% Note that 30s psdeuo data is used in this example
% A single MOEA is simulated on the psdeuo data. To generate the
% distirbutions in the paper N=100 MOEA repeats are done (with the best Euclidean point chosen in each case) across all
% subjects 

% Note, the mex function 'sim_model_sws_mex' must have been created for
% this script to run. If mex generation is disabled, use sim_model_sws.m
% (computaitonal cost will be higher).

% Also note that the parallel pool is generated within this script


%% Generate mex function for model simulations
% The capability to build MEX functions from matlab needs to be enabled for this to be compatable
% This step shoudl generate and save all the mex functions needed
% throughout
Generate_mex_function;


%% 

% add dependency scripts to path
addpath('MOEA')
addpath('Related_scripts')
addpath('Related_scripts\Data')


% load slow wave sleep data
load('Example_data.mat')
psd = Example_data.psd;
hvg = Example_data.hvg;

% Define time vector for model simulation
n = 30; % length of time series
fhz1 = 4.991;
tcut = 5000; % 5 second buffer for transients
TDatend=n*1000; % convert to ms
T1= 0:1/fhz1:(TDatend+tcut);

% define model parameters
paramnames={'\tau_e';'\tau_i';'Q_e^{max}';'Q_i^{max}';'\theta_e';...
    '\theta_i';'\sigma_e';'\sigma_i';'\gamma_e';'\gamma_i';...
    'N_{ee}';'N_{ie}';'N_{ei}';'N_{ii}';'C_m';'g_l';'E_l';'E_e';'E_k';...
    'E_{ampa}';'E_{gaba}';'\alpha_{Na}';'\tau_{Na}';'R_{pump}';'N_a^{eq}';'g_{ampa}';'g_{gaba}';'g_k^{na}';'EC';'n_e';'K_p';'\phi'};
paramstoest=1:32; % parameters to optimize over
npars_est = length(paramstoest);

% 2 objecitve data
eeg_data = {psd,hvg};

% load default parameters and lower/upper bounds
sws_params;

% set up fitness function
ff = @(x) fitness_2obj(x, paramsvec, eeg_data, paramstoest, T1, tcut, fhz1);

% population size
npop = 500;

% generate latin hyper cube for inital population
pop = lhsdesign_scale1(npop, npars_est, [lb(paramstoest);ub(paramstoest)]);

% set up parallel pool
parpool


% Calculate inital pop. scores
scores1 = [];
for i=1:size(pop,1)
    scores1(i,:) = ff(pop(i,:));
end


% set MOEA options
options1 = optimoptions('gamultiobj','UseParallel', true, ...
    'PopulationSize', size(pop,1));%,'PlotFcn',@gaplotscorediversity); % uncomment to visualise GA
options2 = options1;

% apply crososver function
options2.CrossoverFcn = @crossoverscattered;

options2.MaxTime = 60*60*5; % maximum GA time
options2.Display = 'none';
options2.InitialPopulationMatrix = pop;
options2.InitialScoresMatrix = scores1;   
options2.MaxStallGenerations = 20;
options2.MaxGenerations = 20;


% Run MOEA. Note this step is time consuimg 
[x,fval,exitflag,output,population,scores] = gamultiobj(ff, npars_est, [],[],[],[], lb(paramstoest),ub(paramstoest),[], options2);

% combine output and save result
sim_number = 1;
out = {x,fval,exitflag,output,population,scores};
save(['MOEA_example_subject1_sim_' num2str(sim_number) '.mat'],'out');







