%Programma che legge file audio, lo analizza
clf;  %clear the current figure window

[x fs nbits] = wavread("bcl-dyads/bass_clarinet_dyad_113.wav");

%Faccio la fft del file in caricato
N = 65536;
X = abs(fft(x, N));
Xs = fftshift(X);
F = [-N/2:N/2-1]/N;

Spec = X(1:N/2, 1); %per comodità prendo metà spettro
size(X);
size(Spec);

i = 1;
do
	%Cerco il massimo nello spettro e ne individuo il bin.
	[maxval, bin] = max(max(Spec, [], 2));
	freqs_max(i) = fs/N*bin;
	amps(i) = maxval;
	%Quindi calcolo una deviazione di 1/4 di tono attorno a quella frequenza a azzero
	%tutti i bin corrispondenti a al range individuato da quelle due frequenze (che avranno freqs_max(i) come centro).
	f_quarterlower = freqs_max(i)/(2^(1/24));
	f_quarterhigher = freqs_max(i)*(2^(1/24));
	bin_quarterlower = round(f_quarterlower*N/fs);
	bin_quarterhigher = round(f_quarterhigher*N/fs);
	Spec(bin_quarterlower:bin_quarterhigher) = 0;
	i++;
until(10*log10(amps(i-1)/amps(1)) < -18) %continuo la ricerca finché non cado sotto una certa soglia di ampiezza dei bin

dim = i-2;

writeFullLily(freqs_max, amps, "Multifonico_richiesto");


plot(F, Xs)
xlabel("Frequency/fs")
axis([0 0.5])


%sinc = 1/fs;
%dur = sinc*size(x, 1);
%t = [0:sinc:dur-sinc];
%[y, e, v] = onset4(x);


%plot(t(fs:fs*10), y(fs:fs*10))
%plot(t(1:fs*10), x(1:fs*10), t(1:fs*10), y(1:fs*10)*0.5, t(1:fs*10), e(1:fs*10), t(1:fs*10), v(1:fs*10))
%plot(t(1:fs*10), v(1:fs*10))
%axis([0.9 1.3 -0.5 0.5])
%axis([0 1])