%Programma che date delle note lilypond in input trova il multifonico nel database che più gli si avvicina


%Chiamo la funzione writeFullLily che riceve 5 parametri:
%	1) L'array di note
%	2) L'array delle ampiezze
%	3) Quanti multifonici voglio stampare sulla pagina:
%						se > 1 allora come primi due parametri devo passare delle matrici
%	4) Il titolo della pagina
%	5) Il titolo per ciascun rigo
%Quindi compila il file di lily e lo apre
%

dim = 10;
freq = 110;
for i = 1 : dim
	pitch(i) = freq*i;
end

writeFullLily(pitch, [ ], 1, "Serie_armonica", "A partire da A2");

%EOF