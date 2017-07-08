 function start_idxs = GetWindowsStartIdx(timeline, window_length)
%this function needs to be checked
n = length(timeline);
i=1;
idx = 1;
start_idxs = [];

while (i<n)
    
    dif = timeline(i+1) - timeline(i);
    if dif (dif > window_length)
        m = fix(dif/window_length);     %fix rounds to zero
        rem = mod(dif,window_length);
        start_idxs(idx) = timeline(i) + floor((dif  - m * window_length) / 2);   % check if can be replaced with rem
        idx = idx+1;
        
        for j=1:m-1
            start_idxs(idx) = start_idxs(idx-1) + window_length;
            idx = idx +1;
        end
    end
    i = i+2;
end




end