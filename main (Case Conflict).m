%%
clear; clc;
group = 'EC'   %%this variable needs to be changed for every group

files = dir('*.txt');
files_num = length(files);
FR_FR = cell(1,files_num);
AMP_AMP = cell(1,files_num);
FOG_group_sixBySix_amp = cell(1,files_num);
FOG_group_sixBySix_fr = cell(1,files_num);
freq_180_storage = [];
amp_180_storage = [];

params = load_settings_params;
window_length = 10;

M_FOG = zeros(6);

tic;
file_idx = 1;
parfor idx=1:files_num
    file = files(idx);
    idx
    file
    
    data = importdata(file.name);
    data = data.data;
    t = data(:,1);
    data = data(:,2:end);
    data(:,21) = [];
    patient = strsplit(file.name,'.');
    time_v = importdata([patient{1},'_time_v.xlsx']);
    timeline = getWalkingTimes(time_v);
    start_idxs = GetWindowsStartIdx(timeline, window_length);
    n = length(start_idxs);
    
    frfr_values = [];
    ampamp_values = [];
    
    FrFr_layer_matrix = zeros(174);
    AmpAmp_layer_matrix = zeros(174);
    
    layer_idx = 1;
    
    %main calculation
    for s = start_idxs
        s
        st_time = s;
        end_time = s + window_length;
        for i=1:29
            for j=1:29
                for k=1:6
                    for l=1:6
                        s1 = get_signal_interval(data, params.BW{k}, i, params, st_time, end_time);
                        s2 = get_signal_interval(data, params.BW{l}, j, params, st_time, end_time);
                        [FrFr_layer_matrix((i-1)*6 + k,(j-1)*6 + l, layer_idx),...
                            AmpAmp_layer_matrix((i-1)*6 + k,(j-1)*6 + l, layer_idx)] = GammaFrquencyAndAmplitude(s1,s2);
                    end
                end
            end
        end
        layer_idx = layer_idx + 1;
    end
    %averaging for one patient through all time windows
    FrFr_mean = mean(FrFr_layer_matrix,3);
    AmpAmp_mean = mean(AmpAmp_layer_matrix,3);
    freq_180_storage(:,:,idx) = FrFr_mean;
    amp_180_storage(:,:,idx) =  AmpAmp_mean;
    %storing averaged matrix
    
    
    %here we need to calculate the 6x6 matrix for each patient and
    %store it:
    curr_patientSixSixFrFrBlocksMat = getSixBySixBlocksMean(FrFr_mean);
    curr_patientSixSixAmpAmpBlocksMat = getSixBySixBlocksMean(AmpAmp_mean);
    dlmwrite([patient{1},'frfr.txt'], curr_patientSixSixFrFrBlocksMat);
    dlmwrite([patient{1},'ampamp.txt'], curr_patientSixSixAmpAmpBlocksMat);
    FOG_group_sixBySix_amp{idx} =  curr_patientSixSixAmpAmpBlocksMat;
    FOG_group_sixBySix_fr{idx} = curr_patientSixSixFrFrBlocksMat;
    
    dlmwrite([patient{1},'180_frfr.txt'], FrFr_mean);
    dlmwrite([patient{1},'180_ampamp.txt'], AmpAmp_mean);

    disp('so far so good, finished working on another patient');
    
end
toc;
%these are matricEC_group_sixBySix_ampes we need to take the t-test later from
save ([group,'_group_sixBySix_amp'], 'EC_group_sixBySix_amp');
save ([group,'_group_sixBySix_fr'], 'EC_group_sixBySix_fr');

%averaging fr and amp storage to get the final averaged 180x180 matrix for
%group

EC_group_fr_180_avg = mean(freq_180_storage,3);
EC_group_amp_180_avg = mean(amp_180_storage,3);
dlmwrite([group,'_total_fr_180_avg.txt'], EC_group_fr_180_avg);
dlmwrite([group,'_total_amp_180_avg.txt'], EC_group_amp_180_avg);


%% 6*6 matrix
sixSixFrFrBlocksMat = getSixBySixBlocksMean(FrFr_mean);
sixSixAmpAmpBlocksMat = getSixBySixBlocksMean(AmpAmp_mean);

figure;
imagesc(sixSixFrFrBlocksMat,[0 1]);
title([group, ' fr-fr cross modulation mean 6*6 matrix']);
colormap('jet');
colorbar;

figure;
imagesc(sixSixAmpAmpBlocksMat,[0 1]);
title([group, ' amp-amp cross modulation mean 6*6 matrix']);
colormap('jet');
colorbar;

%% electrodes matrix
elecFrFrBlocksMat = getElectrodesAverageMatrix(FrFr_mean);
elecAmpAmpBlocksMat = getElectrodesAverageMatrix(AmpAmp_mean);
dlmwrite('EC_ElectrodesFrFrBlocksMat.txt', elecFrFrBlocksMat);
dlmwrite('EC_ElectrodesAmpAmpBlocksMat.txt', elecAmpAmpBlocksMat);
%%
figure;
imagesc(elecFrFrBlocksMat);
title('EC fr-fr cross modulation electrodes mean matrix');
colormap('jet');
colorbar;

figure;
imagesc(elecAmpAmpBlocksMat);
title('EC amp-amp cross modulation electrodes mean matrix');
colormap('jet');
colorbar;e('EC_Fr_Fr_180_matrix.txt',FrFr_mean);
dlmwrite('EC_Amp_Amp_180_matrix.txt',AmpAmp_mean);