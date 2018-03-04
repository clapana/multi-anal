%Funzione che converte le ampiezze (normalizzate) in dinamiche
%
%
function Y = ampToLily(amp)

    if(amp <= 0 && amp > -1)
        dynamic = "\\fff";
    elseif(amp <= -1 && amp > -2)
            dynamic = "\\ff";
    elseif(amp <= -2 && amp > -3)
        dynamic = "\\f";
    elseif(amp <= -3 && amp > -6)
        dynamic = "\\mf";
    elseif(amp <= -6 && amp > -9)
        dynamic = "\\mp";
    elseif(amp <= -9 && amp > -12)
        dynamic = "\\p";
    elseif(amp <= -12 && amp > -15)
        dynamic = "\\pp";
    elseif(amp <= -15 && amp > -18)
        dynamic = "\\ppp";
    elseif(amp <= -18)
        dynamic = " ";
    endif

    Y = strcat(dynamic);
end