function Generate_figure3


%% Function plots figure 3 from paper

% The firing rates and currents of model simulations are loaded from saved
% data sets in this file.

% See 'Firing_rate_calculation.m' and 'Current_calculation.m' files for info to
% clauclate these from model simulations


%%
% Load all simulations from saved datasets
simulations1 = 100; % number of simulations for a given subject
simulations2 = 100; % number of simulations for a given subject

load('FR_total.mat')
fr_e_ctl = FR_total.ctl_e(:,1:simulations1);
fr_i_ctl = FR_total.ctl_i(:,1:simulations1);

fr_e_pat = FR_total.pat_e(:,1:simulations2);
fr_i_pat = FR_total.pat_i(:,1:simulations2);

% load caluclated currents in
load('Currents_total.mat')
current1_e = Currents_total.ctl_e(:,1:simulations1);
current1_i = Currents_total.ctl_i(:,1:simulations1);
current1_leak = Currents_total.ctl_leak(:,1:simulations1);
current1_KNa = Currents_total.ctl_KNa(:,1:simulations1);

current2_e = Currents_total.pat_e(:,1:simulations1);
current2_i = Currents_total.pat_i(:,1:simulations1);
current2_leak = Currents_total.pat_leak(:,1:simulations1);
current2_KNa = Currents_total.pat_KNa(:,1:simulations1);



%% plot firing rate
seizure_subs_during_admission_idx = [4,5,6,9,10,11,14];
idx = 1:15;
idx(seizure_subs_during_admission_idx)=[];

fr_e_ctl2 = mean(fr_e_ctl,2);
fr_i_ctl2 = mean(fr_i_ctl,2);
fr_e_pat2 = mean(fr_e_pat,2);
fr_i_pat2 = mean(fr_i_pat,2);

g = [zeros(1,16),ones(1,15)];
g2 = [zeros(1,16),ones(1,8),2*ones(1,7)];
x = [fr_e_ctl2;fr_e_pat2];
x2 = [fr_i_ctl2;fr_i_pat2];
x3 = [fr_e_ctl2;fr_e_pat2(idx);fr_e_pat2(seizure_subs_during_admission_idx)];
x4 = [fr_i_ctl2;fr_i_pat2(idx);fr_i_pat2(seizure_subs_during_admission_idx)];

r1 = ranksum(fr_e_ctl2,fr_e_pat2);
r2 = ranksum(fr_i_ctl2,fr_i_pat2);
r3 = ranksum(fr_e_ctl2,fr_e_pat2(idx));
r4 = ranksum(fr_e_ctl2,fr_e_pat2(seizure_subs_during_admission_idx));
r5 = ranksum(fr_i_ctl2,fr_i_pat2(idx));
r6 = ranksum(fr_i_ctl2,fr_i_pat2(seizure_subs_during_admission_idx));


h = figure_gen(22,15);
subplot = @(m,n,p) subtightplot (m, n, p, [0.17 0.02], [0.1 0.1], [0.09 0.12]);
subplot(2,4,1)
v1 = violinplot(x,g);
v1(1).ViolinColor = {[0,118,192]/256};
v1(2).ViolinColor = {[227,124,29]/256};
box off
set(gca,'TickDir','out');
ylabel('Mean excitatory firing rate')
xticks(1:2)
xticklabels({'Controls';'Patients'})
H2=sigstar({ {'Controls';'Patients'}},r1);
set(H2,'color','k')
title(  '                                               Excitatory','FontSize',10)
ylim([0,0.027])
subplot(2,4,2)
v1 = violinplot(x3,g2);
v1(1).ViolinColor = {[0,118,192]/256};
v1(2).ViolinColor={[103 119 26]/256};
v1(3).ViolinColor={[122 80 114]/256};
box off
set(gca,'TickDir','out');
xticks(1:3)
row1 = {'Controls' 'Patients' 'Patients'};
row2 = {'' ' without' '   with'};
row3 = {'' 'seizures' 'seizures'};
labelArray = [row1; row2;row3]; 
tickLabels = sprintf('%s\\newline%s\\newline%s\n', labelArray{:});
ax = gca(); 
ax.XTick = 1:3; 
ax.XTickLabel = tickLabels; 
xtickangle(0)
ylim([0,0.02])
H3=sigstar([1,2],r3);
ylim([0,0.025])
H2=sigstar([1,3],r4);
set(H2,'color','k')
text(1.39,0.0217, 'NS','Fontsize',9)
set(gca,'Ytick',[])
set(gca,'Yticklabels',[])
ylim([0,0.027])

title({'                                                Firing Rates';''},'FontSize',12)

subplot = @(m,n,p) subtightplot (m, n, p, [0.15 0.02], [0.1 0.1], [0.12 0.02]);

subplot(2,4,3)
v1 = violinplot(x2,g);
v1(1).ViolinColor = {[0,118,192]/256};
v1(2).ViolinColor = {[227,124,29]/256};
box off
set(gca,'TickDir','out');
ylabel('Mean inhibitory firing rate')
xticks(1:2)
xticklabels({'Controls';'Patients'})
ylim([0.004,0.0155])
H2=sigstar({ {'Controls';'Patients'}},r2*2);
set(H2,'color','k')
title(  '                                               Inhibitory','FontSize',10)
ylim([0.004,0.0165])


subplot(2,4,4)
v1 = violinplot(x4,g2);
v1(1).ViolinColor = {[0,118,192]/256};
v1(2).ViolinColor={[103 119 26]/256};
v1(3).ViolinColor={[122 80 114]/256};
box off
set(gca,'TickDir','out');
xticks(1:3)
ylim([0.004,0.014])
row1 = {'Controls' 'Patients' 'Patients'};
row2 = {'' ' without' '   with'};
row3 = {'' 'seizures' 'seizures'};
labelArray = [row1; row2;row3]; 
tickLabels = sprintf('%s\\newline%s\\newline%s\n', labelArray{:});
ax = gca(); 
ax.XTick = 1:3; 
ax.XTickLabel = tickLabels; 
xtickangle(0)
H2=sigstar([1,2],r5*3);
ylim([0.004,0.0155])
H3=sigstar([1,3],r6*2);
set(H2,'color','k')
text(1.39,0.0148, 'NS','Fontsize',9)
yticks(0.004:0.002:0.014)
set(gca,'Ytick',[])
set(gca,'Yticklabels',[])
ylim([0.004,0.0165])



%% Plot currents

g = [zeros(1,16),ones(1,15)];
x1 = [mean(current1_leak,2);mean(current2_leak,2)];
x2 = [mean(current1_e,2);mean(current2_e,2)];
x3 = [mean(current1_i,2);mean(current2_i,2)];
x4 = [mean(current1_KNa,2);mean(current2_KNa,2)];


ind1=1:15;
seizure_subs_during_admission_idx = [4,5,6,9,10,11,14];

ind1(seizure_subs_during_admission_idx)=[];
g2 = [zeros(1,16),ones(1,length(ind1)),2*ones(1,length(seizure_subs_during_admission_idx))];

y1 = [mean(current1_leak,2);mean(current2_leak(ind1,:),2);mean(current2_leak(seizure_subs_during_admission_idx,:),2)];
y2 = [mean(current1_e,2);mean(current2_e(ind1,:),2);mean(current2_e(seizure_subs_during_admission_idx,:),2)];
y3 = [mean(current1_i,2);mean(current2_i(ind1,:),2);mean(current2_i(seizure_subs_during_admission_idx,:),2)];
y4 = [mean(current1_KNa,2);mean(current2_KNa(ind1,:),2);mean(current2_KNa(seizure_subs_during_admission_idx,:),2)];




subplot = @(m,n,p) subtightplot (m, n, p, [0.15 0.02], [0.1 0.1], [0.09 0.12]);
subplot(2,4,5)
v1 = violinplot(x2,g);
box off
set(gca,'TickDir','out');
v1(1).ViolinColor = {[0,118,192]/256};
v1(2).ViolinColor = {[227,124,29]/256};
ylabel({'Mean excitatory synaptic';'current'})
xticklabels({'Controls';'Patients'})
[r1,~,stats1] = ranksum(mean(current1_e,2),mean(current2_e,2));
ylim([0,150])
sigstar({[1,2]},[r1*4])
ytickformat('%.0f')
title(  '                                               Excitatory','FontSize',10)


subplot(2,4,6)
v2 = violinplot(y2,g2);
box off
set(gca,'TickDir','out');
v2(1).ViolinColor = {[0,118,192]/256};
v2(2).ViolinColor={[103 119 26]/256};
v2(3).ViolinColor={[122 80 114]/256};
row1 = {'Controls' 'Patients' 'Patients'};
row2 = {'' ' without' '   with'};
row3 = {'' 'seizures' 'seizures'};

labelArray = [row1; row2;row3]; 
tickLabels = sprintf('%s\\newline%s\\newline%s\n', labelArray{:});
ax = gca(); 
ax.XTick = 1:3; 
ax.XTickLabel = tickLabels; 
xtickangle(0)
r5 = ranksum(mean(current1_e,2),mean(current2_e(seizure_subs_during_admission_idx,:),2));
    ylim([0,90])
H3=sigstar([1,2],1);
text(1.39,98.5, 'NS','Fontsize',9)
ylim([0,150])
sigstar({[1,3]},[r5*4])
ytickformat('%.0f')
set(gca,'Ytick',[])
set(gca,'Yticklabels',[])
title({'                                                Synaptic Currents on the Excitatory Population ';''},'FontSize',12)


subplot = @(m,n,p) subtightplot (m, n, p, [0.15 0.02], [0.1 0.1], [0.12 0.02]);
subplot(2,4,7)
v1 = violinplot(x3,g);
box off
set(gca,'TickDir','out');
v1(1).ViolinColor = {[0,118,192]/256};
v1(2).ViolinColor = {[227,124,29]/256};
    ylabel({'Mean inhibitory synaptic';'current'})
xticklabels({'Controls';'Patients'})
[r2,~,stats1] = ranksum(mean(current1_i,2),mean(current2_i,2));
ylim([-50,-5])
sigstar({[1,2]},[r2*4])
ytickformat('%.0f')
ylim([-50,0])
text(1.42,-1.8,'NS','FontSize',9)


title(  '                                               Inhibitory','FontSize',10)


subplot(2,4,8)
v2 = violinplot(y3,g2);
box off
set(gca,'TickDir','out');
v2(1).ViolinColor = {[0,118,192]/256};
v2(2).ViolinColor={[103 119 26]/256};
v2(3).ViolinColor={[122 80 114]/256};
row1 = {'Controls' 'Patients' 'Patients'};
row2 = {'' ' without' '   with'};
row3 = {'' 'seizures' 'seizures'};

labelArray = [row1; row2;row3]; 
tickLabels = sprintf('%s\\newline%s\\newline%s\n', labelArray{:});
ax = gca(); 
ax.XTick = 1:3; 
ax.XTickLabel = tickLabels; 
xtickangle(0)
r7 = ranksum(mean(current1_i,2),mean(current2_i(seizure_subs_during_admission_idx,:),2));
ylim([-50,-7.5])
H3=sigstar([1,2],1);
text(1.39,-4.3, 'NS','Fontsize',9)
ylim([-50,-3])
sigstar({[1,3]},[r7*4])
ytickformat('%.0f')

set(gca,'Ytick',[])
set(gca,'Yticklabels',[])
ylim([-50,0])











