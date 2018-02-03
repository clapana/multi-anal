%Funzione per scrivere il contenuto musicale del file LilyPond
%
%
function writeLily(filename, freqs_max, amps, dim)

	file_id = fopen(filename, "a");

	%fprintf(file_id, "%s \n", note); %contenuto musicale
	for i = 1 : dim
		%note = setNoteSize(i);
		%fprintf(file_id, "%s \n", note); %contenuto musicale

		pitch = freqToLily(freqs_max(i));
		fprintf(file_id, "%s \n", pitch); %contenuto musicale
	end

	fclose(file_id)

end