%Programma che date delle note lilypond in input trova il multifonico nel database che più gli si avvicina

data = dlmread("database.txt"); %leggo la matrice del database che ha come ultima colonna il nome del multifonico
								%quindi definisco una variabile ausiliaria col = columns(data) - 1
data_col = columns(data) - 1;

% Deve ricevere una nota in formato NOTA di lilypond_OTTAVA (notazione scientifica)
% IMPORTANTE: scrivere come un vettore colonna
lily = ["f4"; "e5"];
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

%calcolo la norma e ne cerco il minimo. L'indice index relativo sarà il multifonico cercato.
norma = zeros(1, rows(data));
for i = 1 : rows(data)
	norma(i) = aux(i, 1)^2 + aux(i, 2)^2;
end

[value, index] = min(norma);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                            %%%
%%%   SCRIVO I FILE LILYPOND   %%%
%%%                            %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Chiamo la funzione che date le note, le ampiezze e il titolo produce il file lilypond relativo e lo apre
writeFullLily(mfind, [ ], "Multifonico_richiesto");

st = cstrcat("Suggerito_multifonico_n.", num2str(index));
writeFullLily(data(index, :), [ ], st);