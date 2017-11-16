%{
#include "Parser.h"
%}
digito 		[0-9]
letra 		[A-Za-z]
operador_mat 	"*"|"/"|"+"|"-"|"%"
operador_log 	"<"|">"|"<="|">="|"=="|"!="|"&&"|"||"

operador_matematico {operador_mat}
identificador 		{letra}({digito}*{letra}*)*
inteiro 		[+-]?{digito}+
real 		{int}[.]{digito}+
separador				[,]
blanks          [ \t\n]+
instrucao				[;]
atribuicao 			[=]

%%
{blanks}        { /* ignore */ }

";"		return(INSTRUCAO);
"="	return(ATRIBUICAO);
"(" return(ABRE_CHAVE);
")" return(FECHA_CHAVE);
"{" return(ABRE_COLCHETE);
"}" return(FECHA_COLCHETE);

"se" return(SE);
"enquanto" return(ENQUANTO);
"inicio();" return(INICIO);
"fim();" return(FIM);
"funcao" return(INICIO_FUNCAO);

{operador_matematico} return(OPERADOR_MATEMATICO);


"int"|"real"|"caractere"|"logico" {
yylval.sval = malloc(strlen(yytext));
strncpy(yylval.sval, yytext, strlen(yytext));
return(TIPO_PRIMITIVO);
}

{operador_log} {
	return(OPERADOR_LOGICO);
}

{identificador}	{
				yylval.sval = malloc(strlen(yytext));
				strncpy(yylval.sval, yytext, strlen(yytext));
				return(IDENTIFICADOR);
}

{inteiro} {
yylval.sval = malloc(strlen(yytext));
strncpy(yylval.sval, yytext, strlen(yytext));
return(INTEIRO);
}

{separador} {
yylval.sval = malloc(strlen(yytext));
strncpy(yylval.sval, yytext, strlen(yytext));
return(SEPARADOR);
}
