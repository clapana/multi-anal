%Funzione per scrivere il contenuto musicale del file LilyPond
%
%
function writeFullLily(note, amp, lun, header, multi_title)

	filename = strcat(header, ".ly")

	openLily(header);

	%metto un ciclo perché potrei voler stampare più multifonici sulla stessa pagina
	if(lun == 1)
		writeLily(filename, note, amp, columns(note), multi_title);
	else
		for i = 1 : lun
			st = strcat("Multifonico n.", num2str(multi_title(i)));
			writeLily(filename, note(i, :), amp(i, :), columns(note(i, :)), st);
		end
	endif

	command1 = cstrcat("/Applications/LilyPond.app/Contents/Resources/bin/lilypond ", filename);
	command2 = cstrcat("open ", header, ".pdf");
	unix(command1); %chiama lilypond che compila il file
	unix(command2); %apre il pdf

end