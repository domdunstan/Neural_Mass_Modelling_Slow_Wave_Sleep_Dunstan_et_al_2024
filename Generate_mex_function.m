


%% Generates mex file of the model function

cd('Generate_mex_functions')
mex_path = pwd;
addpath(mex_path)
n = 30; % length of time series
fhz1 = 4.991;
tcut = 5000; % 5 second buffer
TDatend=n*1000;
makeCoderEm(TDatend,tcut);
cd ..






