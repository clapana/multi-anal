%Funzione per scrivere il contenuto musicale del file LilyPond
%
%
function writeLily(note, amp)

	file_id = fopen("test.ly", "a");

	%setNoteSize(amp);
	fprintf(file_id, "%s \n", note); %contenuto musicale

	fclose(file_id)

end