%{
#include <stdio.h>
%}

// Symbols.
%union
{
	char	*sval;
	int a;
};
%token <sval> IDENTIFICADOR
%token <sval> INTEIRO
%token <sval> SEPARADOR
%token <sval> VARIAVEL
%token <sval> INSTRUCAO


%start Procedimento
%%

Procedimento:
	Continuacao
	;

Continuacao:
	|criacao_variavel_int
	;

criacao_variavel_int:
	VARIAVEL lista_variaveis {printf("CRIACAO : %s\n", $1);}
;

lista_variaveis:
	IDENTIFICADOR SEPARADOR lista_variaveis {printf("variaveis : %s\n", $1);}
	|IDENTIFICADOR  INSTRUCAO{printf("variaveis : %s\n", $1);}


%%

int yyerror(char *s) {
  printf("yyerror : %s\n",s);
}

int main(void) {
  yyparse();
}
