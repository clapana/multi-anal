%Programma per leggere il database di multifonici e creare un file con le prime num note di ciascun multifonico

files = glob("bcl-dyads/*"); %leggo tutti i file dentro la cartella
							% per accedervi devo chiamare fn{i}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                          %%%
%%%     CREO IL DATABASE     %%%
%%%                          %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

file_id = fopen("database.txt", "wt");
fclose(file_id);
for j = 1 : rows(files)

	[x fs nbits] = wavread(files{j});

	%Faccio la fft del file in caricato
	N = 65536;
	X = abs(fft(x, N));
	Xs = fftshift(X);
	F = [-N/2:N/2-1]/N;

	num_notes = 2; %il numero di note che voglio salvare per ciascun multifonico
	freqs_max = zeros(1, num_notes);

	Spec = X(1:N/2, 1); %per comodità prendo metà spettro

	i = 1;
	for i = 1 : num_notes
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
	end

	freqs_max = sort(freqs_max);

	file_id = fopen("database.txt", "a");
		for l = 1 : num_notes
			fprintf(file_id, "%f ", freqs_max(l));
		end
		fprintf(file_id, "%s \n", files{j});
	fclose(file_id);
	end

%unix("/Applications/LilyPond.app/Contents/Resources/bin/lilypond test.ly"); %chiama lilypond che compila il file
%unix ("open test.pdf"); %apre il pdf