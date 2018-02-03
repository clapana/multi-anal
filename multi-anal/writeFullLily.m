%Funzione per scrivere il contenuto musicale del file LilyPond
%
%
function writeFullLily(note, amp, header)

	filename = strcat(header, ".ly")

	openLily(header);
	writeLily(filename, note, amp, columns(note));
	closeLily(filename);

	command1 = cstrcat("/Applications/LilyPond.app/Contents/Resources/bin/lilypond ", filename);
	command2 = cstrcat("open ", header, ".pdf");
	unix(command1); %chiama lilypond che compila il file
	unix(command2); %apre il pdf

end