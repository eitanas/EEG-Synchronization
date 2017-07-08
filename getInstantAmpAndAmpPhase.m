function [amp,amp_phase] = getInstantAmpAndAmpPhase(signal)
%this function gets a signal and returns its instantaneous amplitude and
%instantenous amplitude phase

signal = signal - mean(signal);
signal = abs(hilbert(signal));
signal = signal - mean(signal);
amp = hilbert(signal);
amp_phase = angle(amp);

end