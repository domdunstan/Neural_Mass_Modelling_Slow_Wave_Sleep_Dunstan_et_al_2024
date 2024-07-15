% Example test of mex function
sws_params;
n = 30; % length of time series
fhz1 = 4.991;
tcut = 5000; % 5 second buffer
T1= 0:1/fhz1:(TDatend+tcut);
y = sim_model_sws(T1, paramsvec);
