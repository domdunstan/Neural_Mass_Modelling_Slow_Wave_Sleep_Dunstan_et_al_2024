function Generate_figure4

%% Function plots figure 4 from paper

% The psd from adjusting the conductance's are loaded from saved datasets

% See 'generating_adjusted_spectrum.m' script for details in calculating
% the specturm after adjusting conductance parameters in the model
% simulations


%%

% define percentage change to load
per_change1 = 40;
per_change2 = 50;
per_change3 = 60;


subjects = 15;

%% load caluclated changes


load(['spectrum_info_' num2str(per_change1)])
spectrum_change_e1 =spectrum_info.excitatroy;
spectrum_change_i1 =spectrum_info.inhibitory;
spectrum_change_leak1 =spectrum_info.leak;
spectrum_change_kna1 =spectrum_info.KNa;
psd_adjusted1 = spectrum_info.psd_adjusted;

load(['spectrum_info_' num2str(per_change2)])
spectrum_change_e2 =spectrum_info.excitatroy;
spectrum_change_i2 =spectrum_info.inhibitory;
spectrum_change_leak2 =spectrum_info.leak;
spectrum_change_kna2 =spectrum_info.KNa;
psd_adjusted2 = spectrum_info.psd_adjusted;


load(['spectrum_info_' num2str(per_change3)])
spectrum_change_e3 =spectrum_info.excitatroy;
spectrum_change_i3 =spectrum_info.inhibitory;
spectrum_change_leak3 =spectrum_info.leak;
spectrum_change_kna3 =spectrum_info.KNa;
psd_adjusted3 = spectrum_info.psd_adjusted;

% load control psd
load('Total_Simulations_ctl_Euclid.mat')
psd_ctl = Total_Simulations_ctl_Euclid.psd;
psd_ctl_mean2 = squeeze(mean(psd_ctl,2));

% load patient psd
load('Total_Simulations_pat_Euclid.mat')
psd_pat = Total_Simulations_pat_Euclid.psd;
p_pat_psd2 = squeeze(mean(psd_pat,2));

range = 8:384; % limit to frequency range of interest - 0.6-10Hz
load('Control_freq.mat')
freq = Control_freq(range);

% plot 50% change
psd_adjusted = psd_adjusted2;

%% plot



figure_gen(18,15);
subplot = @(m,n,p) subtightplot (m, n, p, [0.12 0.04], [0.11 0.06], [0.09 0.02]);

% plot controls v patients for reference
subplot(3,3,6)
plot_areaerrorbar(freq,p_pat_psd2,[0.8500 0.3250 0.0980],[0.8500 0.3250 0.0980])
hold on
plot_areaerrorbar(freq,psd_ctl_mean2,[0,118,192]/256,[0,118,192]/256)
hold on
plot_areaerrorbar(nan,nan,[0,47,48]/256,[0,47,48]/256) % add for legend ony
hold off
xlabel('Frequency (Hz)')
xlim([0.6,4])
box off
set(gca,'TickDir','out');
set(gca,'Ytick',[])
ylabel('Normalised power')
set(gca,'fontsize', 8)
xticks([0.6,1,1.5,2,2.5,3,3.5,4])
title('Controls v Patients')
l1 = legend('Patients (SE)','Patients (mean)','Controls (SE)','Controls (mean)',['Patients (synaptic conductance' newline 'adjusted; SE)'],['Patients (synaptic conductance' newline 'adjusted; mean)']);
l1.FontSize=7;
ylim([0,0.023])

subplot = @(m,n,p) subtightplot (m, n, p, [0.12 0.04], [0.11 0.06], [0.09 0.02]);

% plot g_e
subplot(3,3,1)
plot_areaerrorbar(freq,p_pat_psd2,[0.8500 0.3250 0.0980],[0.8500 0.3250 0.0980])
hold on
plot_areaerrorbar(freq,squeeze(mean(squeeze(psd_adjusted(1,:,:,:)),2)),[0,47,48]/256,[0,47,48]/256)
hold off
xlabel('Frequency (Hz)')
xlim([0.6,4])
box off
set(gca,'TickDir','out');
set(gca,'Ytick',[])
ylabel('Normalised power')
set(gca,'fontsize', 8)
title({'Adjusted Excitatory';'Synaptic Conductance'},'color',[0,47,48]/256)
xticks([0.6,1,1.5,2,2.5,3,3.5,4])
ylim([0,0.023])


% plot g_KNa
subplot(3,3,5)
plot_areaerrorbar(freq,p_pat_psd2,[0.8500 0.3250 0.0980],[0.8500 0.3250 0.0980])
hold on
plot_areaerrorbar(freq,squeeze(mean(squeeze(psd_adjusted(4,:,:,:)),2)),[0,47,48]/256,[0,47,48]/256)
hold off
xlabel('Frequency (Hz)')
xlim([0.6,4])
box off
set(gca,'TickDir','out');
set(gca,'Ytick',[])
ylabel('Normalised power')
set(gca,'fontsize', 8)
title({'Adjusted KNa';'Synaptic Conductance'},'color',[0,47,48]/256)
xticks([0.6,1,1.5,2,2.5,3,3.5,4])
ylim([0,0.023])


% plot g_i
subplot(3,3,2)
plot_areaerrorbar(freq,p_pat_psd2,[0.8500 0.3250 0.0980],[0.8500 0.3250 0.0980])
hold on
plot_areaerrorbar(freq,squeeze(mean(squeeze(psd_adjusted(2,:,:,:)),2)),[0,47,48]/256,[0,47,48]/256)
hold off
xlabel('Frequency (Hz)')
xlim([0.6,4])
box off
set(gca,'TickDir','out');
set(gca,'Ytick',[])
ylabel('Normalised power')
set(gca,'fontsize', 8)
title({'Adjusted Inhibitory';'Synaptic Conductance'},'color',[0,47,48]/256)
xticks([0.6,1,1.5,2,2.5,3,3.5,4])
ylim([0,0.023])


% plot leak
subplot(3,3,4)
plot_areaerrorbar(freq,p_pat_psd2,[0.8500 0.3250 0.0980],[0.8500 0.3250 0.0980])
hold on
plot_areaerrorbar(freq,squeeze(mean(squeeze(psd_adjusted(3,:,:,:)),2)),[0,47,48]/256,[0,47,48]/256)
hold off
xlabel('Frequency (Hz)')
xlim([0.6,4])
box off
set(gca,'TickDir','out');
set(gca,'Ytick',[])
ylabel('Normalised power')
set(gca,'fontsize', 8)
title({'Adjusted Leak';'Synaptic Conductance'},'color',[0,47,48]/256)
xticks([0.6,1,1.5,2,2.5,3,3.5,4])
ylim([0,0.023])



% add sensitivity comparison

s1 = mean(spectrum_change_e1,2);
s2 = mean(spectrum_change_i1,2);
s3 = mean(spectrum_change_leak1,2);
s4 = mean(spectrum_change_kna1,2);

s1_2 = mean(spectrum_change_e2,2);
s2_2 = mean(spectrum_change_i2,2);
s3_2 = mean(spectrum_change_leak2,2);
s4_2 = mean(spectrum_change_kna2,2);

s1_3 = mean(spectrum_change_e3,2);
s2_3 = mean(spectrum_change_i3,2);
s3_3 = mean(spectrum_change_leak3,2);
s4_3 = mean(spectrum_change_kna3,2);
 

subplot(3,3,7)
r1 = ranksum(s1,s2);
r2 = ranksum(s1,s3);
r3 = ranksum(s1,s4);
r1_2 = ranksum(s1_2,s2_2);
r2_2 = ranksum(s1_2,s3_2);
r3_2 = ranksum(s1_2,s4_2);
r1_3 = ranksum(s1_3,s2_3);
r2_3 = ranksum(s1_3,s3_3);
r3_3 = ranksum(s1_3,s4_3);


y1 = [s1;s2;s3;s4];
y2 = [s1_2;s2_2;s3_2;s4_2];
y3 = [s1_3;s2_3;s3_3;s4_3];

y_total = [y1;y2;y3];

g2 = [zeros(1,15),ones(1,15),2*ones(1,15),3*ones(1,15)];

v2 = violinplot(y1,g2);
box off
set(gca,'TickDir','out');
v2(1).ViolinColor = {[163,2,52]/256}; 
v2(2).ViolinColor={[103 119 26]/256}; 
v2(3).ViolinColor={[122 80 114]/256}; 
v2(4).ViolinColor={[255 223 118]/256}; 
xlim([0.5,4.5])
ylabel({'Change in normalised power';'after adjusting conductance'})
xticklabels({'Excitatory';'Inhibitory';'Leak';'KNa'});
xlabel('Synaptic conductance parameter')
ylim([0,0.00075])

sigstar({[1,2],[1,3],[1,4]},[r1,r2,r3])
title([num2str(per_change1) '% change'])


subplot(3,3,8)
v2 = violinplot(y2,g2);
box off
set(gca,'TickDir','out');
v2(1).ViolinColor = {[163,2,52]/256}; 
v2(2).ViolinColor={[103 119 26]/256}; 
v2(3).ViolinColor={[122 80 114]/256}; 
v2(4).ViolinColor={[255 223 118]/256}; 
xlim([0.5,4.5])
xticklabels({'Excitatory';'Inhibitory';'Leak';'KNa'});
xlabel('Synaptic conductance parameter')
title([num2str(per_change2) '% change'])
ylim([0,0.00095])
sigstar({[1,2],[1,3],[1,4]},[r1_2,r2_2,r3_2])


subplot(3,3,9)
v2 = violinplot(y3,g2);
box off
set(gca,'TickDir','out');
v2(1).ViolinColor = {[163,2,52]/256}; 
v2(2).ViolinColor={[103 119 26]/256}; 
v2(3).ViolinColor={[122 80 114]/256}; 
v2(4).ViolinColor={[255 223 118]/256}; 
xlim([0.5,4.5])
xticklabels({'Excitatory';'Inhibitory';'Leak';'KNa'});
xlabel('Synaptic conductance parameter')
title([num2str(per_change3) '% change'])
ylim([0,0.00125])
sigstar({[1,2],[1,3],[1,4]},[r1_3,r2_3,r3_3])
