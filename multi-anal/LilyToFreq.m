%Funzione che converte le note di lilypond in frequenze
%
%
function FREQ = LilyToFreq(lilynote)

    tuning = 440.0; %intonazione
    %octave = 2;
    %Cerco dove sono le lettere e dove i numeri all'inteno dell'indicazione lily della nota

    pitches = ["c";"cih";"cis";"cisih";"d";"dih";"dis";"disih";"e";"eis";"f";"fih";"fis";"fisih";"g";"gih";"gis";"gisih";"a";"aih";"ais";"aisih";"b";"bih"];
    pitch = [" ", " ", " ", " ", " "];
    i = 1;
    while(isalpha(lilynote(i)))
        pitch(i) = lilynote(i);
        i++;
    endwhile

    octave = str2double(lilynote(i));

    j = 1;
    while(!strcmp(pitch, pitches(j, :)))
        j++;
    end

    nota = (j-1)*0.5; %per convertire nel numero giusto per lily
    midi = (octave+1)*12 + nota;
    FREQ = tuning*2^((midi-69)/12);
end