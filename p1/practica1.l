%{
unsigned caracteres = 0, minusculas = 0, frases = 0, mayusculas = 0, palabras = 0;
%}
palabra [^ \t\n\"."]+
minusculas [a-z]+
mayusculas [A-Z]+
frase "."+
eol \n
%%
{frase} 	{frases++; caracteres += yyleng;}
{minusculas}	{minusculas++; caracteres += yyleng;}
{mayusculas}	{mayusculas++; caracteres += yyleng;}
{palabra}	{palabras++; caracteres += yyleng;}
{eol}	{}
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
			printf("\n\tCaracteres: %d\n\tFrases: %d\n\tPalabras: %d\n\tMinusculas: %d\n\tMayusculas: %d\n\n", 
				caracteres, frases, palabras += minusculas + mayusculas, minusculas, mayusculas);
		} else{
			printf("ERROR: No se ha podido abrir el fichero '%s'\n",argv[1]);
		}
	} else{
		printf("ERROR: Falta argumento entrada\nSintaxis: '%sfichero_entrada'\n\n",argv[0]);
	}
	return 0;
}
