%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
typedef struct alumno {
	int linea;
	char *nombre;
	char *dni;
	float nota;
}listaAlumnos;
typedef struct error{
	int linea;
	char const *tipoError;
}error;
//typedef struct alumnos *listaAlumnos;

listaAlumnos alumnosSuspensos[10];
listaAlumnos alumnosAprobados[10];
error listaErrores[10];
int num_linea = 0, numSuspensos = 0, numAprobados = 0, numErrores = 0;
void yyerror (char const *);
int yylex();
%}
%union{
	char * valString;
	float valFloat;
}
%token <valString> ASIGNATURA CABECERA CCURSO CURSO NIF ALUMNO
%token <valFloat> NOTA
%type <valString> lista linea titulo
%start S
%%
S : titulo CABECERA lista {free($2);} 
    | titulo CABECERA {free($2);}
	;
titulo : ASIGNATURA CCURSO CURSO '\n'{
		printf("- Asignatura: %s\n- Curso: %s\n", $1, $3); num_linea+=2;
		free($1);
		free($3);
	}
	;
lista : lista linea {}
	| linea {}
	;
linea : NIF'\t'ALUMNO'\t'NOTA '\n'{
		num_linea++;
		if ($5 > 10) {
			free($1);
			free($3);
			yyerror("Nota mayor de 10");
			yyclearin;
		}else if ($5 < 5) {
			alumnosSuspensos[numSuspensos].linea = num_linea;
			alumnosSuspensos[numSuspensos].dni = $1;
			alumnosSuspensos[numSuspensos].nombre = $3;
			alumnosSuspensos[numSuspensos].nota = $5;
			numSuspensos++;
		} else{
			alumnosAprobados[numAprobados].linea = num_linea;
			alumnosAprobados[numAprobados].dni = $1;
			alumnosAprobados[numAprobados].nombre = $3;
			alumnosAprobados[numAprobados].nota = $5;
			numAprobados++;
		}
	}
	| error'\t'ALUMNO'\t'NOTA '\n'{
		free($3);
		num_linea++; 
		yyerror("NIF incorrecto");
		yyclearin;
		

	}
	| NIF'\t'error'\t'NOTA '\n' {
		free($1); 
		num_linea++;
		yyerror("Alumno incorrecto");
		yyclearin;
		

	}
	| NIF'\t'ALUMNO'\t'error '\n' { 
		free($1);
		free($3);
		num_linea++;
		yyerror("Nota incorrecta");
		yyclearin;
	}
	| error '\n'{
		yyclearin;
	}

%%
int main(int argc, char *argv[]) {
	int i = 0;
	yyparse();
	printf("- Alumnos suspensos:\n");
	for (i = 0; i<numSuspensos; i++){
		printf("Línea %i: %s;%s\n",alumnosSuspensos[i].linea, alumnosSuspensos[i].dni, alumnosSuspensos[i].nombre);
		free(alumnosSuspensos[i].nombre);
		free(alumnosSuspensos[i].dni);	
	}
	printf("- Alumnos aprobados:\n");
	for (i = 0; i<numAprobados; i++){
		printf("Línea %i: %s;%s;%.2f\n",alumnosAprobados[i].linea, alumnosAprobados[i].dni, alumnosAprobados[i].nombre, alumnosAprobados[i].nota);
		free(alumnosAprobados[i].nombre);
		free(alumnosAprobados[i].dni);	
	}
	printf("- Errores:\n");
	for (i = 0; i<numErrores; i++){
		printf("Línea %i: %s\n", listaErrores[i].linea, listaErrores[i].tipoError);	
	}
	return 0;
}
void yyerror (char const *message) {
	
	if (strcmp(message,"syntax error")){
		listaErrores[numErrores].linea = num_linea;
		listaErrores[numErrores].tipoError = message;	
		numErrores++;
	}
}


