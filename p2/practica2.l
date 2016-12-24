%{
#include <stdlib.h>
#include "practica2.tab.h"
%}
asignatura [A-Za-z" "]+" -"
curso	[0-9]{4}"/"[0-9]{4}
ccurso " "Curso" "
cabecera Identificador\tAlumno\tNota
nif 	[0-9]{8}"-"[A-Z]
nota 	[0-9]+("."[0-9]{1,2})?
alumno 	[A-Z][a-z]+" "[A-Z][a-z]+", "[A-Z][a-z]+
%%
{asignatura}	{yylval.valString = strdup(yytext); return ASIGNATURA;}
{ccurso}	{return CCURSO;}
{curso}		{yylval.valString = strdup(yytext); return CURSO;}
{cabecera}	{yylval.valString = strdup(yytext); return CABECERA;}
{nif} 		{yylval.valString = strdup(yytext); return NIF;}
{alumno}	{yylval.valString = strdup(yytext); return ALUMNO;}
{nota}		{yylval.valFloat = atof(yytext); return NOTA;}
\t 		{return '\t';}
\n		{return '\n';}
.		{return '@';}
%%
