function [f1f2, a1a2] = GammaFrquencyAndAmplitude(signal1, signal2)
% this function gets two raw EEG signal and calculate thier gamma
% synchronization index using cross-modulation, for four combinations --
% Amplitude-Amplitude, frequency-frequency, amplitude-frequency and
% frequency-Amplitude

[~,a1] = getInstantAmpAndAmpPhase(signal1);
[~,a2] = getInstantAmpAndAmpPhase(signal2);

%the function getInstantAmpAndAmpPhase already perform subtraction of the
%mean, but to get gamma for the frequencies we need to do it here - 
signal1 = signal1 - mean(signal1);
signal2 = signal2 - mean(signal2);

dt = 1/256;

f1 = hilbert(signal1);
f2 = hilbert(signal2);


f1 = diff(f1)/dt;
f2 = diff(f2)/dt;

f1 = angle(hilbert(f1));
f2 = angle(hilbert(f2));

delta = f1-f2;
exponent = exp(1i * delta);
f1f2 = abs(mean(exponent));

delta = a1-a2;
exponent = exp(1i * delta);
a1a2 = abs(mean(exponent));


end