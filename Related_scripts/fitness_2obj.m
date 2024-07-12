function fit1 = fitness_2obj(A1, paramsvec, eegdata1, paramstoest, T1, tcut, fhz1)

% Function calculates and returns the 2D fitness for a given parameter set A1. Other
% inputs are defined within the master script


%%

% set parameters
paramsinput = paramsvec;
paramsinput(paramstoest) = A1;

% load in the data to fit against
psd_data = eegdata1{1};
hvg_data = eegdata1{2};


psd_model = [];
fithvg = [];
parfor RunIter = 1:20 % run 5 times for stability: - take the mean value for the fitness func
% run current params. 
y=sim_model_sws_mex(T1,paramsinput);

% EEG output is first row
final_eeg=y(1,round(tcut*fhz1):end);

% zscore and downsample
eegz = zscore(final_eeg);
eegz2 = downsample(eegz,39);

% caluclate hvg objecitve
vg2 = fast_HVG(zscore(eegz2), linspace(0,length(hvg_data)/128,length(eegz2)), 'w');
d2 = full(sum(vg2));
[~,~,ks2stat] = kstest2(d2,hvg_data);
fithvg = [fithvg,ks2stat];

% set to 0 if no model simualtion
if isnan(final_eeg(end))||final_eeg(end)>1e8
final_eeg=0;
else
    
% caluclate model spectra
[a,lags] = pwelch(eegz,[],[],200400,fhz1,'power');
% limit to frequency range of data
lags=lags*1000;
a=a(lags>=.6&lags<=10);
a = a/trapz(a);
psd_model = [psd_model,a];

end
end

% If unable to  clauclate, set fitness to a high value
if isempty(psd_model)||isnan(psd_model(1))
    fit1 = [100,100];
else

% Calculate mean and normalise
psd_model2=mean(psd_model,2);
psd_model2=psd_model2/trapz(psd_model2);

% calculate each objective
fitobj1 = sum(((psd_model2-psd_data).^2)); 
fitobj2 = mean(fithvg);

if isnan(fitobj1)||isnan(fitobj2)
    fit1=[100,100];
else
fit1=[fitobj1,fitobj2];
end
end
