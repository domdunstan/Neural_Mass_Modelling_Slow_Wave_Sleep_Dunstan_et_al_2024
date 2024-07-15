function makeCoderEm(TDatend,tcut)
% Function generates mex version of the model simulation

%% Inputs
% TDatend: Number of points in time series
% tcut:Number of points in transients to also simulate for
%%
% generate time vector
fhz1 = 4.991;
T1= 0:1/fhz1:(TDatend+tcut);
sws_params;

% generate mex file of model simulation and test functionality
codegen sim_model_sws.m -args {T1, paramsvec} -test forCoder
end
