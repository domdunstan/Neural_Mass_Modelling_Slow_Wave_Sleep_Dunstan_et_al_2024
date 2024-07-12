

%% %% %% %% %% %%  MASTER SCRIPT FOR GENERATING FIGURES %% %% %% %% %% %% %%% %
%                                                                             %
%    Neural mass modelling reveals that hyperexcitability underpins           %
%        slow wave sleep changes in children with epilepsy                    %
%                                                                             %           
% Dominic M. Dunstan*, Samantha YS Chan, Marc Goodfellow                      %
%                                                                             %
%  [LINK TO PREPRINT ]                                                        %
%                                                                             %
% Execution of this script recreates all main results figures in the above    %
% manuscipt. See the paper for details.                                       %
%                                                                             %
% This software uses a number of external toolboxes. We are grateful to the   %
% authors of these toolboxes. In each case, the licenses are stated within    %
% the corresponding header.                                                   %
%                                                                             %
% University of Exeter, 2024.                                                  %
% Please email me if you have any questions                                   %
% *dmd206@exeter.ac.uk                                                        %
% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% % % %





%% Generate mex function for model simulations
% The capability to build MEX functions from matlab needs to be enabled for this to be compatable
% This step shoudl generate and save all the mex functions needed
% throughout
Generate_mex_function;



% Simulate and plot figures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% add dependencies to path
addpath('Related_scripts')
addpath('Related_scripts\Data')

%% Plot Figure 2 - Normalised power from controls and patients

Generate_figure2


%% Plot Figure 3 - Firing rates and currents from controls and patients

Generate_figure3


%% Plot Figure 4 - Power spectra after adjusting model synaptic conductances

Generate_figure4


%% Plot Figure 5 - Spike wave discharge simulation and distance from resting states


Generate_figure5







