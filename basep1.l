%{
unsigned charCount = 0, minusCount = 0, lineCount = 0, fraseCount = 0, mayusCount = 0, palabras = 0, frases = 0;
%}
/*word [^ \t\n\46]+*/
minusculas [^ A-Z\t\n"."]+
mayusculas [^ a-z\t\n"."]+
frases "."
eol \n
%%
{frases} {frases++;}/*
{word}	{palabras++;}*/
{minusculas}	{minusCount++; charCount += yyleng;}
{mayusculas}	{mayusCount++; charCount += yyleng;}
{eol}	{charCount++; lineCount++; }
.	{charCount++;}
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
			printf("\n\tFrases: %d\n\tPalabras: %d\n\tMinusculas: %d\n\tMayusculas: %d\n\tLineas: %d\n\n", frases, palabras, minusCount, mayusCount, lineCount);
		} else{
			printf("ERROR: No se ha podido abrir el fichero '%s'\n",argv[1]);
		}
	} else{
		printf("ERROR: Falta argumento entrada\nSintaxis: '%sfichero_entrada'\n\n",argv[0]);
	}
	return 0;
}
