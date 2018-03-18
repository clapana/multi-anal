%Funzione per modificare la dimensione della testa della nota in funzione dell'ampiezza
%
%
function setNoteSize(amp)

   	switch(amp)
    	case 1
         	num = " 0 ";
      	case 2
          	num = " -1 ";
       	case 3
         	num = " -2 ";
     	case 4
           	num = " -3 ";
      	case 5
        	num = " -4 ";
    	case 6
        	num = " -5 ";
       	case 7
          	num = " -6 ";
 	endswitch

    X = strcat("\\set fontSize = ", num);
	%fprintf(file_id, X);

end