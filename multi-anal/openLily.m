%Funzione per scrivere l'intestazinoe del file LilyPond
%
%
function openLily(header)

	filename = strcat(header, ".ly")
	file_id = fopen(filename, "wt");

	fprintf(file_id,"\\version \"2.18.2\" \n");
	fprintf(file_id, "\\header {\n title = \"%s\" \n tagline = \"Multiphonics Finder by Claudio\"\n} \n", header)

	fclose(file_id)

end