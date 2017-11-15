%{
#include "Parser.h"
%}
digito 		[0-9]
letra 		[A-Za-z]
id 		{letra}({digito}*{letra}*)*
inteiro 				[0-9]+
separador				[,]
blanks          [ \t\n]+
instrucao				[;]

%%

{blanks}        { /* ignore */ }
"int" {
yylval.sval = malloc(strlen(yytext));
strncpy(yylval.sval, yytext, strlen(yytext));
return(VARIAVEL);
}

";"		return(INSTRUCAO);

{id}	{
				yylval.sval = malloc(strlen(yytext));
				strncpy(yylval.sval, yytext, strlen(yytext));
				return(IDENTIFICADOR);
}

{inteiro} {
yylval.a = yytext;
return(INTEIRO);
}

{separador} {
yylval.sval = malloc(strlen(yytext));
strncpy(yylval.sval, yytext, strlen(yytext));
return(SEPARADOR);
}
