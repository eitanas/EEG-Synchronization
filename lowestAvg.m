function avg = lowestAvg(values)
%this function gets an array of values and returns its lowest n values
%average

values = sort(values);
lowest = values(1:100);
avg = mean(lowest);

end