%%
clear; clc;
group_name = 'EC'   %%this variable needs to be changed for every group

files = dir('*.txt');
files_num = length(files);
FR_FR = cell(1,files_num);
AMP_AMP = cell(1,files_num);
group_sixBySix_amp = cell(1,files_num);
group_sixBySix_fr = cell(1,files_num);
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
    group_sixBySix_amp{idx} =  curr_patientSixSixAmpAmpBlocksMat;
    group_sixBySix_fr{idx} = curr_patientSixSixFrFrBlocksMat;
    
    dlmwrite([patient{1},'180_frfr.txt'], FrFr_mean);
    dlmwrite([patient{1},'180_ampamp.txt'], AmpAmp_mean);
    
    disp('so far so good, finished working on another patient');
    
end
toc;
%these are matrices we need to take the t-test later from
%save ('_group_sixBySix_amp', group_sixBySix_amp);
%save ([group_name,'_group_sixBySix_fr'], group_sixBySix_fr);


%averaging fr and amp storage to get the final averaged 180x180 matrix for
%group
group_total_fr_180_avg = mean(freq_180_storage,3);
group_total_amp_180_avg = mean(amp_180_storage,3);
dlmwrite([group_name,'_total_fr_180_avg.txt'], group_total_fr_180_avg);
dlmwrite([group_name,'_total_amp_180_avg.txt'], group_total_amp_180_avg);


% 6*6 matrix
sixSixFrFrBlocksMat = getSixBySixBlocksMean(group_total_fr_180_avg);
sixSixAmpAmpBlocksMat = getSixBySixBlocksMean(group_total_amp_180_avg);

figure;
imagesc(sixSixFrFrBlocksMat,[0 1]);
title([group_name, ' fr-fr cross modulation mean 6*6 matrix']);
colormap('jet');
colorbar;

figure;
imagesc(sixSixAmpAmpBlocksMat,[0 1]);
title([group_name, ' amp-amp cross modulation mean 6*6 matrix']);
colormap('jet');
colorbar;

dlmwrite([group_name,'_sixSixFrFrBlocksMat.txt'], sixSixFrFrBlocksMat);
dlmwrite([group_name,'_sixSixAmpAmpBlocksMat.txt'], sixSixAmpAmpBlocksMat);

% electrodes matrix
elecFrFrBlocksMat = getElectrodesAverageMatrix(group_total_fr_180_avg);
elecAmpAmpBlocksMat = getElectrodesAverageMatrix(group_total_amp_180_avg);

lobes_fr = returnLobesAverageSync(elecFrFrBlocksMat);
lobes_amp = returnLobesAverageSync(elecAmpAmpBlocksMat);

%plot frequncy lobes
figure;
imagesc(lobes_fr)
colormap('jet');
colorbar;

title([group_name,' frequency lobes sync.']);      %'PD-FOG Electrodes amp-amp Lobes mean');
str = {'FL'; 'POL'; 'TL'; 'FR'; 'POR'; 'TR'};
set(gca, 'XTickLabel',str, 'XTick',1:numel(str))
set(gca, 'YTickLabel',str, 'YTick',1:numel(str))

%plot amplitude lobes
figure;
imagesc(lobes_amp)
colormap('jet');
colorbar;

title([group_name,' amplitude lobes sync.']);      %'PD-FOG Electrodes amp-amp Lobes mean');
str = {'FL'; 'POL'; 'TL'; 'FR'; 'POR'; 'TR'};
set(gca, 'XTickLabel',str, 'XTick',1:numel(str))
set(gca, 'YTickLabel',str, 'YTick',1:numel(str))

dlmwrite([group_name,'_frequency lobes sync.txt'], lobes_fr);
dlmwrite([group_name,'_amplitude lobes sync.txt'], lobes_amp);

%% 

