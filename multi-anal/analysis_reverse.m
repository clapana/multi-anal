%Programma che data una nota lilypond trova il bicordo che più gli si avvicina
clf;  %clear the current figure window

% Deve ricevere una nota in formato NOTA di lilypond _ OTTAVA (notazione scientifica)
% IMPORTANTE: scrivere come un vettore colonna
lily = ["aih3"; "disih5"; "g6"];
dim = size(lily, 1);

for i = 1 : dim
	freq(i) = LilyToFreq(lily(i, :));
	printf("La nota %s corrisponde a %f \n", lily(i, :), freq(i));
end