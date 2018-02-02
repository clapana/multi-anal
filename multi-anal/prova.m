%Programma che legge file audio, lo analizza

dim = 20;
%freqs = randi(5000.0, dim, 27.5); %genero dim frequenze randomiche tra 40 e 5000
freq = 27.5;

% Creo una serie armonica
%
openLily;
for i= 1 : dim
	pitch = freqToLily(freq*i);
	writeLily(pitch);
end
closeLily;


unix("/Applications/LilyPond.app/Contents/Resources/bin/lilypond test.ly"); %chiama lilypond che compila il file
unix ("open test.pdf"); %apre il pdf

