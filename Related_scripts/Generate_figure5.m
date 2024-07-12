function Generate_figure5

%% Function plots figure 5 from paper

% The SWD model simulation is loaded from fitting to the SWD data. The
% currents are loaded from saved data sets

% See 'Current_calculation_swd.m' file for info to clauclate these currents from model simulations


% Note, the raw SWD data has been omitted from this figure. 
% Please email the corresponding author about further information regaring sharing of raw data 

%%

% load saved data
load('SWD_figure_data.mat')

current_swd_e_mean = SWD_figure_data.SWD_current;
% swd_segment = SWD_figure_data.SWD_data;
time_segment = SWD_figure_data.SWD_time;
eegz = SWD_figure_data.SWD_model_sim;
current1_e = SWD_figure_data.resting_current_ctl;
current2_e = SWD_figure_data.resting_current_pat;
current2_e_pat_nsz = SWD_figure_data.resting_current_pat_nsz;
current2_e_pat_sz = SWD_figure_data.resting_current_pat_sz;

ind1=1:15;
seizure_subs_during_admission_idx = [4,5,6,9,10,11,14];
ind1(seizure_subs_during_admission_idx)=[];

% calculate difference between resting current and swd current
x1 = abs(current_swd_e_mean-mean([current2_e;current1_e],2));
x2 = abs(current_swd_e_mean-mean([current2_e_pat_sz;current2_e_pat_nsz],2));


x3 = [x2;x1];
g3 = [zeros(1,7),ones(1,8),2*ones(1,15),3*ones(1,16)];


%% plot


figure_gen(15,13);
subplot = @(m,n,p) subtightplot (m, n, p, [0.13 0.05], [0.13 0.01], [0.08 0.14]);

subplot(3,3,[1,2,3])
plot(time_segment,eegz,'LineWidth',2,'Color',[162,2,52]/256)
hold on
hold off
xlabel('Time (s)')
box off
set(gca,'TickDir','out');
ylim([-2.9,5.7])
xlim([0,2.3])
set(gca,'ytick', []);
row1 = { '   Model' 'SWD  '};
row2 = {'simulation  ' ' data'};
labelArray = [row1; row2]; 
tickLabels = sprintf('%s\\newline%s\n', labelArray{:});
ax = gca(); 
ax.YTick = [0,4]; 
ax.YTickLabel = tickLabels; 
ax = gca;
ax.YAxisLocation = "right";
 set(gca,'fontsize',9)


subplot = @(m,n,p) subtightplot (m, n, p, [0.13 0.05], [0.13 0.11], [-0.1 0.14]);


[r0,~,stats0] = ranksum(abs(mean(current1_e,2)-current_swd_e_mean),abs(mean(current2_e,2)-current_swd_e_mean));
[r1,~,stats1] = ranksum(abs(mean(current1_e,2)-current_swd_e_mean),abs(mean(current2_e(seizure_subs_during_admission_idx,:),2)-current_swd_e_mean));
[r2,~,stats2] = ranksum(abs(mean(current1_e,2)-current_swd_e_mean),abs(mean(current2_e(ind1,:),2)-current_swd_e_mean));
[r3,~,stats3] = ranksum(abs(mean(current2_e(seizure_subs_during_admission_idx,:),2)-current_swd_e_mean),abs(mean(current2_e(ind1,:),2)-current_swd_e_mean));



subplot(3,3,[5:6,8,9])
v1 = violinplot(x3,g3);
box off
set(gca,'TickDir','out');
v1(4).ViolinColor = {[0,118,192]/256};
v1(3).ViolinColor = {[227,124,29]/256};
v1(2).ViolinColor={[103 119 26]/256};
v1(1).ViolinColor={[122 80 114]/256};


ylabel({'Distance to mean SWD excitatory'; 'synaptic current'})
row1 = {'Patients','Patients' 'Patients' 'Controls' };
row2 = {'   with' ' wihtout' '' ''};
row3 = { 'seizures' 'seizures' '' ''};


labelArray = [row1; row2;row3]; 
tickLabels = sprintf('%s\\newline%s\\newline%s\n', labelArray{:});
ax = gca(); 
ax.XTick = 1:4; 
ax.XTickLabel = tickLabels; 
camroll(-180)
ax = gca;
c = ax.Color;
ax.XAxisLocation = "top";
ax.YAxisLocation = "left";
ylim([0,110])


s1 = sigstar2({[3,4]},[r0],-102);
s2 = sigstar2({[1,4]},[r1],-111);
s2 = sigstar2({[2,4]},[r3],-105.5);
text(3.08,3.8, 'NS','Fontsize',7)


subplot = @(m,n,p) subtightplot (m, n, p, [0.13 0.05], [0.13 0.11], [-0.1 0.12]);

% add points
subplot(3,3,[4,7])
% add arrow
addpath('C:\Documents\PhD\Subcutaneous EEG project\Inital model fitting\SUB0016\Liley_resting_sz1\Analysis')
ylim([0,110])
arrow([-0.2 110],[-0.2 1],'Width',12,'Length',50,'TipAngle',25)

ylim([0,110])
camroll(-180)
axis off
xlim([-0.5,0.5])
hold on
plot(-0.2,0,'x','markersize',15,'Color',[162,2,52]/256,'LineWidth', 2)
plot(-0.2,mean(x3(31:46)),'x','markersize',15,'Color',[0,118,192]/256,'LineWidth', 2)
plot(-0.2,mean(x3(16:30)),'x','markersize',15,'Color',[227,124,29]/256,'LineWidth', 2)
plot(-0.2,mean(x3(8:15)),'x','markersize',15,'Color',[103 119 26]/256,'LineWidth', 2)
plot(-0.2,mean(x3(1:7)),'x','markersize',15,'Color',[122 80 114]/256,'LineWidth', 2)

hold off
axis off
h = text(0.05,100,'Seizure susceptibility','FontSize',12);
 set(h,'Rotation',90)
 set(gca,'fontsize',9)

 % add text describign ditance to seizure
 text(-0.29,100, {'Far from';' seizure'})
 text(-0.29,11, {'Close to';' seizure'})

pause(0.1);

 l2 = legend('','SWD mean','Controls mean distance','Patients mean distance','Patients (no seizures) mean distance','Patients (seizures) mean distance');
  l2 = legend('','SWD (mean)','Controls (mean)','Patients (mean)','Patients without seizures (mean)','Patients with seizures (mean)');
 l2.FontSize=8;
 l2.NumColumns=2;
l2.Position = [0.25   0.6109    0.5624    0.0891];

% % save directly
%  f = gcf;
% exportgraphics(f,'Figure5.jpg','Resolution',300)

