%Programma che legge file audio, lo analizza
clf;  %clear the current figure window

%[x fs nbits] = wavread("sin10kHz05amp.wav");
%[x fs nbits] = wavread("sin440Hz05amp.wav");
%[x fs nbits] = wavread("sin261-880Hz.wav");
%[x fs nbits] = wavread("sin_cluster.wav");
%[x fs nbits] = wavread("sin440-450.wav");
%[x fs nbits] = wavread("piano_A3.wav");
%[x fs nbits] = wavread("oboe_soft_dyad.wav");
%[x fs nbits] = wavread("bass_clarinet_dyad1.wav");
[x fs nbits] = wavread("oboe_multi121.wav");

sinc = 1/fs;
dur = sinc*size(x, 1);
t = [0:sinc:dur-sinc];
[y, e, v] = onset4(x);

%plot(t(fs:fs*10), y(fs:fs*10))
%plot(t(1:fs*10), x(1:fs*10), t(1:fs*10), y(1:fs*10)*0.5, t(1:fs*10), e(1:fs*10), t(1:fs*10), v(1:fs*10))
%plot(t(1:fs*10), v(1:fs*10))
plot(t, v)
%axis([0.9 1.3 -0.5 0.5])
%axis([0 1])