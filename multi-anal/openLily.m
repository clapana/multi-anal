%Funzione per scrivere l'intestazinoe del file LilyPond
%
%
function openLily

	file_id = fopen("test.ly", "wt");

	fprintf(file_id, "\\version \"2.18.2\" \n \\score { \n \\new PianoStaff { \n  \\autochange { \n"); %intestazione del file LilyPond

	fclose(file_id)

end