%Programma per leggere il database di multifonici e crea un file con le prime num _notes di ciascun multifonico

files = glob("oboe_multi/*"); %leggo tutti i file dentro la cartella
							% per accedervi devo chiamare fn{i}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                          %%%
%%%     CREO IL DATABASE     %%%
%%%                          %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

database_name = "database_oboe.txt";
file_id = fopen(database_name, "wt");
fclose(file_id);
for j = 1 : rows(files)

	[x fs nbits] = wavread(files{j});

	%Faccio la fft del file in caricato
	N = 65536;
	X = abs(fft(x, N));
	Xs = fftshift(X);
	F = [-N/2:N/2-1]/N;

	num_notes = 4; %<<<--------------------- il numero di note che voglio salvare per ciascun multifonico
	freqs_max = zeros(1, num_notes);

	Spec = X(1:N/2, 1); %per comodità prendo metà spettro
	%Azzero lo spettro fuori dal range di udibilità
	bin_inf = round(20*N/fs);
	bin_sup = round(2e4*N/fs);
	Spec(1:bin_inf) = 0;
	Spec(bin_sup:N/2) = 0;

	i = 1;
	k = 1;
	for i = 1 : num_notes
		%Cerco il massimo nello spettro e ne individuo il bin.
		[maxval, bin] = max(max(Spec, [], 2));
		freqs_max(i) = fs/N*bin;
		amps(i) = maxval;
		k++;
		amps_norm(k-1) = 10*log10(amps(k-1)/amps(1)); %ampiezze normalizzate al picco
		%Quindi calcolo una deviazione di 1/4 di tono attorno a quella frequenza a azzero
		%tutti i bin corrispondenti a al range individuato da quelle due frequenze (che avranno freqs_max(i) come centro).
		f_quarterlower = freqs_max(i)/(2^(1/24));
		f_quarterhigher = freqs_max(i)*(2^(1/24));
		bin_quarterlower = round(f_quarterlower*N/fs);
		bin_quarterhigher = round(f_quarterhigher*N/fs);
		Spec(bin_quarterlower:bin_quarterhigher) = 0;
	end

	%
	%Ordino le frequenze in modo crescente così da poter ordinare anche le ampiezze a loro relative
	%
	index = zeros(size(num_notes));
	[freqs_max, index] = sort(freqs_max);
	index;

	file_id = fopen(database_name, "a");
	%
	%Scrivo nel database le frequenze
		for l = 1 : num_notes
			fprintf(file_id, "%f ", freqs_max(l));
		end
	%
	%Scrivo nel database le ampiezze normalizzate
		for l = 1 : num_notes
			fprintf(file_id, "%f ", amps_norm(index(l)));
		end
	%
	%Scrivo nel database il nome del file audio analizzato
	fprintf(file_id, "%s \n", files{j});
	fclose(file_id);
end
printf("Database creato col nome \"%s\"\n", database_name);

%EOF