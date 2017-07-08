function t = getFreezingTimes(timeline)
%this function gets a timeline eeg vector and returns the times of regular
%walking epochs

if (isstruct(timeline)==1)
    timeline = timeline.data;
end


t = [];
[m, n] = size(timeline);

if (n==3)
    annotations = [timeline(:,2) timeline(:,3)];
    n = length(annotations);
    for i=1:n
        if (annotations(i,1)==2 || annotations(i,2)==2)        % && annotations(1,i+1)==11)
            t = [t timeline(i,1) timeline(i+1,1)];
        end
    end
else if (n==2)
        annotations = [timeline(:,2)];
        n = length(annotations);
        for i=1:n
            if (annotations(i,1)==2)        % && annotations(1,i+1)==11)
                t = [t timeline(i,1) timeline(i+1,1)];
            end
        end
    end
    
    t = t';
end