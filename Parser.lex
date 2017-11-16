%{
#include "Parser.h"
%}
digito 		[0-9]
letra 		[A-Za-z]
operador_mat 	"*"|"/"|"+"|"-"|"%"
operador_log 	"<"|">"|"<="|">="|"=="|"!="|"&&"|"||"


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



"int" {
yylval.sval = malloc(strlen(yytext));
strncpy(yylval.sval, yytext, strlen(yytext));
return(VARIAVEL);
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
yylval.valor_inteiro = (int*)yytext;
return(INTEIRO);
}

{separador} {
yylval.sval = malloc(strlen(yytext));
strncpy(yylval.sval, yytext, strlen(yytext));
return(SEPARADOR);
}
