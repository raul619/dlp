%{
unsigned caracteres = 0, minusculas = 0, mayusculas = 0, palabras = 0, frases = 0;
%}
minusculas [a-z]+
mayusculas [A-Z]+
word [^ \t\n"."]+
frases "."
%%
{frases} {frases++; caracteres++;}
{minusculas}	{minusculas++; caracteres += yyleng;}
{mayusculas}	{mayusculas++; caracteres += yyleng;}
{word}		{palabras++; caracteres += yyleng;}
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
			printf("\n\tCaracteres: %d\n\tFrases: %d\n\tPalabras: %d\n\tMinusculas: %d\n\tMayusculas: %d\n\tLineas: %d\n\n", 
				caracteres, frases, palabras += mayusculas + minusculas, minusculas, mayusculas, lineCount);
		} else{
			printf("ERROR: No se ha podido abrir el fichero '%s'\n",argv[1]);
		}
	} else{
		printf("ERROR: Falta argumento entrada\nSintaxis: '%sfichero_entrada'\n\n",argv[0]);
	}
	return 0;
}
