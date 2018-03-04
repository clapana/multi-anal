%Programma che date delle note lilypond in input trova il multifonico nel database che più gli si avvicina

data = dlmread("database_oboe.txt"); %leggo la matrice del database che ha come ultima colonna il nome del multifonico
								%Definisco una variabile ausiliaria data_col in cui indico quante frequenze della matrice voglio
								% il vettore lily dovrà avere stessa dimensione di data_col
data_col = 4;  % <<<<<--------------------------------------

% Deve ricevere una nota in formato NOTA di lilypond_OTTAVA (notazione scientifica)
% IMPORTANTE: scrivere come un vettore colonna
%lily = ["f4"; "e5"; "dis6"];
%lily = ["gis5"; "dis6"; "a6"; "c7"]; %deve avere stessa dimensinoe di data_col
dim = size(lily, 1);
mfind = zeros(1, dim);

for i = 1 : dim
	mfind(i) = LilyToFreq(lily(i, :));
	printf("La nota %s corrisponde a %f \n", lily(i, :), mfind(i));
end


% Sottraggo i valori cercati dalle righe della matrice del database
aux = zeros(rows(data), data_col);
for i = 1 : rows(data)
	aux(i, :) = mfind - data(i, 1:data_col);
end

%Calcolo la norma su ogni riga.
%Ordinando poi i risultati ottenuti in maniera crescente avrò l'ordine
%dei multifonici in ordine decrescente di compatibilità
norma = zeros(1, rows(data));
for i = 1 : rows(data)
	norma(i) = aux(i, 1)^2 + aux(i, 2)^2;
end

norma_ordinata = zeros(size(norma));
index = zeros(size(norma));
[norma_ordinata, index] = sort(norma); %il vettore INDEX contiene gli indici originali
norma_ordinata;
index;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                            %%%
%%%   SCRIVO I FILE LILYPOND   %%%
%%%                            %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Chiamo la funzione writeFullLily che riceve 5 parametri:
%	1) L'array di note
%	2) L'array delle ampiezze
%	3) Quanti multifonici voglio stampare sulla pagina:
%						se > 1 allora come primi due parametri devo passare delle matrici
%	4) Il titolo della pagina
%	5) Il titolo per ciascun rigo
%Quindi compila il file di lily e lo apre
%
a = [-20, -20, -20, -20];
writeFullLily(mfind, a, 1, "Multifonico_richiesto", " ");

%Stampo i primi LUN multifonici che mi interessano
% N.B.: sto passando la matrice ordinata secondo l'array index
lun = 4;
writeFullLily(data(index, 1:data_col), data(index, (data_col+1):(data_col*2)), lun, "Multifonici_consigliati", index);



%EOF