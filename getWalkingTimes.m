function t = getWalkingTimes(timeline)
%this function gets a timeline eeg vector and returns the times of regular
%walking epochs
%regular walking is marked by 1 on time vector and end is 11

if (isstruct(timeline)==1)
    timeline = timeline.data;
end


t = [];
[m, n] = size(timeline);

if (n==3)
    annotations = [timeline(:,2) timeline(:,3)];
    n = length(annotations);
    for i=1:n
        if (annotations(i,1)==1 || annotations(i,2)==1)        % && annotations(1,i+1)==11)
            t = [t timeline(i,1) timeline(i+1,1)];
        end
    end
else if (n==2)
        annotations = [timeline(:,2)];
        n = length(annotations);
        for i=1:n
            if (annotations(i,1)==1)        % && annotations(1,i+1)==11)
                t = [t timeline(i,1) timeline(i+1,1)];
            end
        end
    end
    
    t = t';
end