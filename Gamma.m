function g = Gamma( signal1, signal2)
% this function gets two raw EEG signal and calculate thier gamma
% synchronization index using cross-modulation

a = angle(hilbert(signal1));
b = angle(hilbert(signal2));

delta = a-b;
exponent = exp(1i * delta);
g = abs(mean(exponent));

end