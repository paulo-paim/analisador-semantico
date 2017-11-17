/********************************************************
*                                                       *
*   Disciplina: Compiladores    Turma: 2017             *
*                                                       *
*               Analisador Léxico                       *
*                                                       *
*   Dupla:                                              *
*       Bruno Ferreira Leal     -        RA: 151042161  *
*       Paulo Henrique Paim dos Santos - RA: 151040745  *   
*                                                       *
*********************************************************/


%{
#include <stdio.h>
#include "Parser.tab.h"

int linha=1, erro=0;

%}

digito			[0-9]
letra			[A-Za-z]

operador_mat		"*"|"/"|"+"|"-"|"%"
operador_log		"<"|">"|"<="|">="|"=="|"!="|"&&"|"||"

operador_matematico	{operador_mat}
identificador		{letra}({digito}*{letra}*)*

inteiro			[+-]?{digito}+
real			{int}[.]{digito}+

enter	    	[\n]
separador		[,]
blanks			[ \t\n]+
instrucao		[;]
atribuicao		[=]

%%

{enter}         { printf("valor inteiro: %s\t\n",yytext); linha++; }
{blanks}        { /* ignore */ }


";"		{ printf("fim da instrucao: %s\n",yytext); return(INSTRUCAO); }
"="		{ printf("operador de atribuicao: %s\n",yytext); return(ATRIBUICAO); }
"("		{ printf("delimitador de escopo: %s\n",yytext); return(ABRE_PAR); }
")"		{ printf("delimitador de escopo: %s\n",yytext); return(FECHA_PAR); }
"{"		{ printf("delimitador de escopo: %s\n",yytext); return(ABRE_CHAVE); }
"}"		{ printf("delimitador de escopo: %s\n",yytext); return(FECHA_CHAVE); }

"se"		{ printf("palavra reservada: %s\n", yytext); return(SE); }
"enquanto"	{ printf("palavra reservada: %s\n", yytext); return(ENQUANTO); }
"inicio();"	{ printf("palavra reservada: %s\n", yytext); return(INICIO); }
"fim();"	{ printf("palavra reservada: %s\n", yytext); return(FIM); }
"funcao"	{ printf("palavra reservada: %s\n", yytext); return(INICIO_FUNCAO);}


{operador_matematico}	{ printf("operador matematico: %s\n",yytext); return(OPERADOR_MATEMATICO); }


"int"|"real"|"caractere"|"logico" {
	yylval.sval = malloc(strlen(yytext));
	strncpy(yylval.sval, yytext, strlen(yytext));
    printf("tipo primitivo: %s\n",yytext);
	return(TIPO_PRIMITIVO);
}

{operador_log} {
    printf("operador logico: %s\n",yytext);
	return(OPERADOR_LOGICO);
}

{identificador}	{
	yylval.sval = malloc(strlen(yytext));
	strncpy(yylval.sval, yytext, strlen(yytext));
	printf("identificador: %s\n",yytext);
	return(IDENTIFICADOR);
}

{inteiro} {
	yylval.sval = malloc(strlen(yytext));
	strncpy(yylval.sval, yytext, strlen(yytext));
    printf("inteiro: %s\n",yytext);
	return(INTEIRO);
}

{separador} {
	yylval.sval = malloc(strlen(yytext));
	strncpy(yylval.sval, yytext, strlen(yytext));
    printf("separador: %s\n",yytext);
	return(SEPARADOR);
}

.   {
        erro++;        
        return(ERRO);
}
