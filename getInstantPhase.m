function phase = getInstantPhase(signal)
%this function gets a signal and returns its instantaneous amplitude and
%instantenous amplitude phase

signal = signal - mean(signal);
signal = hilbert(signal));
phase  = angle(signal);

end