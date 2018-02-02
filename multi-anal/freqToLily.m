%Funzione che converte le frequenze in Note per lilypond, arrotondate al quarto di tono
%
%
function Y = freqToLily(freq)

	tuning = 440.0; %intonazione
    midi = 12*log2(freq/tuning) + 69; %calcolo il valore in midi con virgola
    deviazione = midi - fix(midi); %calcolo quanto devia dal semitono

    if(deviazione < 0.25)
    	midi = fix(midi); %arrotondo per difetto
    elseif(deviazione >= 0.25 && deviazione < 0.75)
        midi = fix(midi) + 0.5; %quarto di tono crescente rispetto alla nota data
    elseif(deviazione > 0.75)
    	midi = fix(midi) +1; %arrotondo per eccesso
    endif

    %Ora che ho la nota in midi arrotondata al quarto di tono devo convertirla in nota lily,
    %identificando la nota stessa e l'ottava

    pitch = mod(midi, 12);
    octave = floor(midi/12);

    switch(pitch)
    	case 0
    		Note = "c";
    	case 0.5
    		Note = "cih";
    	case 1
    		Note = "cis";
    	case 1.5
    		Note = "cisih";
    	case 2
    		Note = "d";
    	case 2.5
    		Note = "dih";
    	case 3
    		Note = "dis";
    	case 3.5
    		Note = "disih";
    	case 4
    		Note = "e";
    	case 4.5
    		Note = "eis";
    	case 5
    		Note = "f";
    	case 5.5
    		Note = "fih";
    	case 6
    		Note = "fis";
    	case 6.5
    		Note = "fisih";
    	case 7
    		Note = "g";
    	case 7.5
    		Note = "gih"; 
    	case 8
    		Note = "gis";
    	case 8.5
    		Note = "gisih";
    	case 9
    		Note = "a";
    	case 9.5
    		Note = "aih";
    	case 10
    		Note = "ais";
    	case 10.5
    		Note = "aisih";
    	case 11
    		Note = "b";
    	case 11.5
    		Note = "bih";  
	endswitch

    %num = "";
    if(octave >= 0 && octave <= 10)
        switch(octave)
            case 0
                num = ",,,,";
            case 1
                num = ",,,";
            case 2
                num = ",,";
            case 3
                num = ",";
            case 4
                num = " ";
            case 5
                num = "'";
            case 6
                num = "''";
            case 7
                num = "'''";
            case 8
                num = "''''";
            case 9
                num = "'''''";
            case 10
                num = "''''''";
        endswitch
        Y = strcat(Note, num);
    else
        Y = " ";
    endif
end