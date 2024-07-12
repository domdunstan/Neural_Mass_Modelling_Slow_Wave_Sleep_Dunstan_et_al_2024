function Generate_figure2


%% Function plots figure 2 from paper



%% plot PSD from data
FS1=7;
h = figure_gen(16,12);
subplot = @(m,n,p) subtightplot (m, n, p, [0.17 0.08], [0.08 0.16], [0.04 0.02]);
range = 8:384; % limit to frequency range of interest - 0.6-10Hz
% load PSD data
load('Control_freq.mat')
freq = Control_freq(range);
load('Control_psd.mat') 
Control_psd = Control_psd(range,:);
Control_psd = Control_psd./trapz(Control_psd);
load('Subject_psd.mat')
Subject_psd = Subject_psd(range,:);
Subject_psd = Subject_psd./trapz(Subject_psd);


% plot controls v patients
subplot(2,2,1)
plot_areaerrorbar(freq,Control_psd',[ 52 148 186]./255,[128 193 219]./255)
hold on
plot_areaerrorbar(freq,Subject_psd',[236 112  22]./255,[243 169 114]./255)
hold off
xlim([0.6,4])
ylim([0,0.023])
box off
set(gca,'TickDir','out');
xlabel('Frequency (Hz)','FontSize',FS1)
ylabel({'Normalised power'},'FontSize',FS1)
set(gca,'ytick', []);
set(gca,'fontsize', FS1)
t1 = title('Data (Control v patient)');
t1 = title({'Data';''});
t1.FontSize=10;
xticks([0.6,1,1.5,2,2.5,3,3.5,4])
text(1.62,0.0245,'Controls v Patients','FontSize',9)


% add only for legend
hold on
plot_areaerrorbar(nan,nan,[103 119 26]/256,[103 119 26]/256)
hold on
plot_areaerrorbar(nan,nan,[122 80 114]/256,[122 80 114]/256)
hold off
l = legend('Controls (SE)','Controls mean','Patients SE','Patients mean','Patients without seizures  SE','Patients without seizures  mean','Patients with seizures  SE','Patients with seizures  mean');
l = legend('Controls (SE)','Controls (mean)','Patients (SE)','Patients (mean)','Patients without seizures  (SE)','Patients without seizures (mean)','Patients with seizures  (SE)','Patients with seizures  (mean)');
l.NumColumns = 4;
l.Position = [0.06   0.93    0.8875    0.0570];



% repeat with serpating seizure and non seizure subjects
seizure_subs_during_admission_idx = [4,5,6,9,10,11,14];

idx = 1:15;
idx(seizure_subs_during_admission_idx)=[];

subplot(2,2,2)
plot_areaerrorbar(freq,Subject_psd(:,idx)',[103 119 26]/256,[103 119 26]/256)
hold on
plot_areaerrorbar(freq,Subject_psd(:,seizure_subs_during_admission_idx)',[122 80 114]/256,[122 80 114]/256)
xlim([0.6,4])
ylim([0,0.023])
box off
set(gca,'TickDir','out');
xlabel('Frequency (Hz)','FontSize',FS1)
ylabel({'Normalised power'},'FontSize',FS1)
set(gca,'ytick', []);
set(gca,'fontsize', 7)
xticks([0.6,1,1.5,2,2.5,3,3.5,4])
t1 = title({'Data';''});
text(.59,0.0245,'Patients with seizures v Patients without seizures','FontSize',9)
t1.FontSize=10;




%% Plot PSD from model simulations

% load model simulation data
load('Total_Simulations_ctl_Euclid.mat')
load('Total_Simulations_pat_Euclid.mat')
psd1_temp = Total_Simulations_ctl_Euclid.psd;
psd2_temp = Total_Simulations_pat_Euclid.psd;

% mean over sims
psd1 = squeeze(mean(psd1_temp,2));
psd2 = squeeze(mean(psd2_temp,2));


% psd
subplot(2,2,3)
plot_areaerrorbar(freq,psd1,[ 52 148 186]./255,[128 193 219]./255)
hold on
plot_areaerrorbar(freq,psd2,[236 112  22]./255,[243 169 114]./255)
hold off
xlim([0.6,4])
ylim([0,0.023])
xlabel('Frequency (Hz)','FontSize',FS1)
ylabel({'Normalised power'},'FontSize',FS1)
box off
set(gca,'TickDir','out');
set(gca,'fontsize', FS1)
set(gca,'ytick', []);
t1 = title({'Model simulation';''});
text(1.62,0.0245,'Controls v Patients','FontSize',9)
t1.FontSize=10;
xticks([0.6,1,1.5,2,2.5,3,3.5,4])

% repeat model simulations for non-seizure and seizure subjects
seizure_subs_during_admission_idx = [4,5,6,9,10,11,14];
idx = 1:15;
idx(seizure_subs_during_admission_idx)=[];


% psd
subplot(2,2,4)
plot_areaerrorbar(freq,psd2(idx,:),[103 119 26]/256,[103 119 26]/256)
hold on
plot_areaerrorbar(freq,psd2(seizure_subs_during_admission_idx,:),[122 80 114]/256,[122 80 114]/256)
hold off
xlim([0.6,4])
ylim([0,0.023])
xlabel('Frequency (Hz)','FontSize',FS1)
ylabel({'Normalised power'},'FontSize',FS1)
box off
set(gca,'TickDir','out');
set(gca,'fontsize', FS1)
set(gca,'ytick', []);
xticks([0.6,1,1.5,2,2.5,3,3.5,4])

t1 = title({'Model simulation';''});
text(.59,0.0245,'Patients with seizures v Patients without seizures','FontSize',9)
t1.FontSize=10;



% Save figure directly
% saveas(gcf,'Figure2.jpeg')











