%Funzione per scrivere il contenuto musicale del file LilyPond
%
%
function writeLily(filename, freqs_max, amps, dim, multi_title)

	file_id = fopen(filename, "a");

	fprintf(file_id, "\\score { \n \\new PianoStaff { \n  \\autochange { \n"); %apertura del blocco musicale
	%fprintf(file_id, "%s \n", note); %contenuto musicale
	for i = 1 : dim
		%note = setNoteSize(i);
		%fprintf(file_id, "%s \n", note); %contenuto musicale

		pitch = freqToLily(freqs_max(i));
		fprintf(file_id, "%s \n", pitch); %contenuto musicale
	end

	fprintf(file_id, "}}\n"); %chiusura del blocco musicale
	fprintf(file_id, "\\header {\n piece = \"%s\"\n}", multi_title); %creo titolo del rigo
	fprintf(file_id, "\\midi {}\n \\layout {} \n }"); %creo file midi

	fclose(file_id)
end