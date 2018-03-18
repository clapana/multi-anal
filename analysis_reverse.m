%Programma che date delle note lilypond restituisce le relative frequenze

% Deve ricevere una nota in formato NOTA di lilypond_OTTAVA (notazione scientifica)
% IMPORTANTE: scrivere come un vettore colonna
lily = ["aih3"; "disih5"; "g6"];
dim = size(lily, 1);

for i = 1 : dim
	freq(i) = LilyToFreq(lily(i, :));
	printf("La nota %s corrisponde a %f \n", lily(i, :), freq(i));
end

freq