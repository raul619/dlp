%{
unsigned nif = 0, alumnos = 0, notas = 0;
%}
nif [0-9]{8}"-"[A-Z]
alumnos [A-Z][a-z]+" "[A-Z][a-z]+", "[A-Z][a-z]+
notas 1?[0-9]"."[0-9]{2}?
%%
{nif} {nif++;}
{alumnos}	{alumnos++;}
{notas}	{notas++;}
%%
int main(int argc, char *argv[])
{
	FILE *ptrFichero;

	if (argc>1){
		ptrFichero = fopen(argv[1], "r");
		if (ptrFichero!= NULL){
			yyin = ptrFichero;
			yylex();
			fclose(ptrFichero);
			printf("\n\tNIFs: %d\n\tAlumnos: %d\n\tNotas: %d\n\n", 
				nif, alumnos, notas);
		} else{
			printf("ERROR: No se ha podido abrir el fichero '%s'\n",argv[1]);
		}
	} else{
		printf("ERROR: Falta argumento entrada\nSintaxis: '%sfichero_entrada'\n\n",argv[0]);
	}
	return 0;
}
