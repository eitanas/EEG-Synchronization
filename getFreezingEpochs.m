function frz_eeg = getFreezingEpochs(timeline, eeg)
%this function gets a timeline eeg vector and returns the times of freezing epochs

sampling_fr = 256;
frz_eeg = [];
t = [];
annotations = timeline(:,3);
n = length(annotations);

for i=1:n
    if (annotations(i)==2)
        t = [t timeline(i,1) timeline(i+1,1)];
    end
end

for i=1:2:length(t)
    start_time = t(i);
    end_time = t(i+1);
    start_idx = round(start_time * sampling_fr);
    end_idx = round(end_time * sampling_fr);
    current_epoch =  eeg(start_idx :end_idx)';
    frz_eeg = [frz_eeg current_epoch];
end

end