%Funzione che trova la frequenza calcolando la parabola che passa perle ampiezze
% dei tre bin adiacenti e poi trova il Vertice (che dunque è la freq cercata)
%
function [VX, VY] = findInterpFreq(x1, x2, x3, y1, y2, y3)

    x = [x1, x2, x3];
    y = [y1, y2, y3];

    %Calcolo i coefficienti della parabola con l'interpolazione
    p = polyfit(x, y, 2);
    %
    %Trovo il vertice
    delta = p(2)^2 - p(1)*p(3);
    VX = -p(2)/(2*p(1)); % Dunque questa sarà la frequenza cercata
    VY = -delta/(4*p(1)); %e questa la sua ampiezza