%%plot diagonal graphs
x = 1:1:6;

EC_fr = load('EC patients frequency-frequency CM.txt');
%EC_fr = returnLobesAverageSync(EC_fr);
EC_fr_diag = diag(EC_fr);
e_ec = std(EC_fr_diag)*ones(size(EC_fr_diag));

PD_fr = load('PD-FOG patients frequency-frequency CM.txt');
%PD_fr = returnLobesAverageSync(PD_fr);
PD_fr_diag = diag(PD_fr);
e_pd = std(PD_fr_diag)*ones(size(EC_fr_diag));

FG_fr = load('FOG patients frequency-frequency CM.txt');
%FG_fr = returnLobesAverageSync(FG_fr);
FOG_fr_diag = diag(FG_fr);
e_fog = std(FOG_fr_diag)*ones(size(EC_fr_diag));

figure;
errorbar(EC_fr_diag,e_ec,'b');
hold on;
errorbar(PD_fr_diag,e_pd,'r');
errorbar(FOG_fr_diag,e_fog,'y');title('groups - frequencies');
ax = gca;
ax.XTickLabel = {'\delta', '\theta', '\alpha', '\sigma', '\beta', '\gamma'};
ax.XLim([0.5 6.5]);
%%
EC_amp = load('EC patients amplitude-amplitude CM.txt');
%EC_amp = returnLobesAverageSync(EC_amp);
ec_amp_diag = diag(EC_amp);
e_ec = std(ec_amp_diag)*ones(size(ec_amp_diag));
pd_amp = load('PD-FOG patients amplitude-amplitude CM.txt');
%pd_amp = returnLobesAverageSync(pd_amp);
pd_amp_diag = diag(pd_amp);
e_pd = std(pd_amp_diag)*ones(size(ec_amp_diag));

fog_amp = load('FOG patients amplitude-amplitude CM.txt');
%fog_amp = returnLobesAverageSync(fog_amp);
fog_amp_diag = diag(fog_amp);
e_fog = std(fog_amp_diag)*ones(size(ec_amp_diag));

figure;
errorbar(ec_amp_diag,e_ec,'b');
hold on;
errorbar(pd_amp_diag,e_pd,'r');
errorbar(fog_amp_diag,e_fog,'y');
title('groups - amplitudes');
ax = gca;
ax.XTickLabel = {'\delta', '\theta', '\alpha', '\sigma', '\beta', '\gamma'};
ax.XLim([0.5 6.5]);
ylabel('\gamma CM');