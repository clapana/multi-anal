%Programma che legge file audio del multifonico e ne trova le note. Qui utilizzo interpolazione sui bin adiacenti
clf;  %clear the current figure window

%file_id = "bass_clarinet_dyad_111";
%filename = strcat("bcl-dyads/", file_id, ".wav")
file_id = "oboe_001";
filename = strcat("oboe_multi/", file_id, ".wav")
[x fs nbits] = wavread(filename);

%Faccio la fft del file in caricato
N = 2^14; %16384
X = abs(fft(x, N));
Xs = fftshift(X);
F = [-N/2:N/2-1]/N;

Spec = X(1:N/2, 1); %per comodità prendo metà spettro
size(X);
size(Spec);

%Azzero lo spettro fuori dal range di udibilità
bin_inf = round(20*N/fs);
bin_sup = round(2e4*N/fs);
Spec(1:bin_inf) = 0;
Spec(bin_sup:N/2) = 0;

i = 1;
do
	%Cerco il massimo nello spettro e ne individuo il bin.
	[maxval, bin] = max(max(Spec, [], 2));
	freq_temp1 = (bin-1)*fs/N;
	freq_temp2 = bin*fs/N;
	freq_temp3 = (bin+1)*fs/N;
	[freqs_max(i), amps(i)] = findInterpFreq(freq_temp1, freq_temp2, freq_temp3, Spec(bin-1), Spec(bin), Spec(bin+1));
	%Quindi calcolo una deviazione di 1/4 di tono attorno a quella frequenza a azzero
	%tutti i bin corrispondenti a al range individuato da quelle due frequenze (che avranno freqs_max(i) come centro).
	f_quarterlower = freqs_max(i)/(2^(1/24));
	f_quarterhigher = freqs_max(i)*(2^(1/24));
	bin_quarterlower = round(f_quarterlower*N/fs);
	bin_quarterhigher = round(f_quarterhigher*N/fs);
	Spec(bin_quarterlower:bin_quarterhigher) = 0;
	i++;
	amps_norm(i-1) = 10*log10(amps(i-1)/amps(1)); %ampiezze normalizzate al picco
until(amps_norm(i-1) < -12) %continuo la ricerca finché non cado sotto una certa soglia di ampiezza dei bin

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                            %%%
%%%   SCRIVO I FILE LILYPOND   %%%
%%%                            %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Chiamo la funzione writeFullLily che riceve 5 parametri:
%	1) L'array di note
%	2) L'array delle ampiezze
%	3) Quanti multifonici voglio stampare sulla pagina:
%						se > 1 allora come primi due parametri devo passare delle matrici
%	4) Il titolo della pagina
%	5) Il titolo per ciascun rigo
%Quindi compila i
writeFullLily(freqs_max, amps_norm, 1, "Multifonico_richiesto", file_id);


%%%%%%%%%%%%%%%%%%%%
%%%              %%%
%%%     PLOT     %%%
%%%              %%%
%%%%%%%%%%%%%%%%%%%%
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