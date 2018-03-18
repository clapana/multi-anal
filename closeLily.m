%Funzione per chiudere il file Lilypond
%
%
function closeLily(filename)

	file_id = fopen(filename, "a");

	fprintf(file_id, "}} \\midi {}\n \\layout {} \n }"); %chiusura del file LilyPond

	fclose(file_id)

end