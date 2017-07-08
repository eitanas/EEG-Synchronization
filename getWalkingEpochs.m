function walk_eeg = getWalkingEpochs(timeline, eeg)
%this function gets a timeline eeg vector and returns the EEG signal 
%corresponding to the time of regular walking epochs

sampling_fr = 256;
walk_eeg = [];
t = [];
annotations = timeline(:,2);
n = length(annotations);
window_length = 10;

%extracting the relevant times
for i=1:n
    if (annotations(i)==1)
        t = [t timeline(i,1) timeline(i+1,1)];
    end
end


%extracting the relevent EEG signal for the time
for i=1:2:length(t)
    start_time = t(i);
    end_time = t(i+1);
    start_idx = round(start_time * sampling_fr);
    end_idx = round(end_time * sampling_fr);
    current_epoch =  eeg(start_idx :end_idx)';
    walk_eeg = [walk_eeg current_epoch];
end

end