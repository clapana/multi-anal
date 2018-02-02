%Funzione per chiudere il file Lilypond
%
%
function closeLily

	file_id = fopen("test.ly", "a");

	fprintf(file_id, "}} \\midi {}\n \\layout {} \n }"); %chiusura del file LilyPond

	fclose(file_id)

end