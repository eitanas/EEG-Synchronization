%%  Cross-modulated amplitudes and frequencies in PD patients EEG
% Normal walking
clear;
patient = 'FE_MC-P08';
%filename = [patient,'.txt'];
filename = 'FE_MC-P05.txt';
[data, t] = load_data(filename);
params = load_settings_params;
time_v = importdata([patient,'_time_v.xlsx']);
window_length = 10;

%%
timeline = getWalkingTimes(time_v);
start_idxs = GetWindowsStartIdx(timeline, window_length);
n = length(start_idxs);


frfr_values = [];
ampamp_values = [];
amp1fr2_values = [];
amp2fr1_values = [];

FrFr_matrix = zeros(180);
AmpAmp_matrix = zeros(180);
Amp1Fr2_matrix = zeros(180);
Amp2Fr1_matrix = zeros(180);

%%

layer_idx = 1;
tic;
for s = start_idxs
    st_time = s;
    end_time = s + window_length;
    for i=1:30
        disp(i)
        for j=1:30
            for k=1:5
                for l=1:5
                    s1 = get_signal_interval(data, params.BW{k}, i, params, st_time, end_time);
                    s2 = get_signal_interval(data, params.BW{l}, j, params, st_time, end_time);
                    [FrFr_matrix((i-1)*6 + k,(j-1)*6 + l, layer_idx),...
                        AmpAmp_matrix((i-1)*6 + k,(j-1)*6 + l, layer_idx),...
                        Amp1Fr2_matrix((i-1)*6 + k,(j-1)*6 + l, layer_idx),...
                        Amp2Fr1_matrix((i-1)*6 + k,(j-1)*6 + l, layer_idx)] = GammaFrquencyAndAmplitude(s1,s2);
                    
                end
            end
        end
    end
    layer_idx = layer_idx + 1;
end

toc;
%%
mean_FrFr_matrix = zeros(180);
mean_AmpAmp_matrix = zeros(180);
mean_Amp1Fr2_matrix = zeros(180);
mean_Amp2Fr1_matrix = zeros(180);
for i=1:180
    for j=1:180
        mean_FrFr_matrix(i,j) = mean(FrFr_matrix(i,j,:));
        mean_AmpAmp_matrix(i,j) = mean(AmpAmp_matrix(i,j,:));
        mean_Amp1Fr2_matrix(i,j) = mean(Amp1Fr2_matrix(i,j,:));
        mean_Amp2Fr1_matrix(i,j) = mean(Amp2Fr1_matrix(i,j,:));
    end
end
%% saving results
dlmwrite([patient,'_mean_FrFr_matrix'], mean_FrFr_matrix);
dlmwrite([patient, '_mean_AmpAmp_matrix'], mean_AmpAmp_matrix);
dlmwrite([patient, '_mean_Amp1Fr2_matrix'], mean_Amp1Fr2_matrix);
dlmwrite([patient, '_mean_Amp2Fr1_matrix'], mean_Amp2Fr1_matrix);

%%
figure
title([patient])
subplot(2,2,1);
imagesc(mean_AmpAmp_matrix);
title('Amplitude-Amplitude');
colorbar

subplot(2,2,2);
imagesc(mean_Amp1Fr2_matrix);
title('Amplitude - Frequency');
colorbar

subplot(2,2,3);
imagesc(mean_Amp2Fr1_matrix);
title('Amplitude - Frequency');
colorbar

subplot(2,2,4);
imagesc(mean_FrFr_matrix);
title('frequency - frequency');
colorbar






