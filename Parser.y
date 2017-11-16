%{
#include <stdio.h>
%}

// Symbols.
%union
{
	char	*sval;
	int valor_inteiro;
};
%token <sval> IDENTIFICADOR
%token <valor_inteiro> INTEIRO
%token <sval> SEPARADOR
%token <sval> VARIAVEL
%token <sval> INSTRUCAO
%token <sval> ATRIBUICAO
%token <sval> SE
%token <sval> ABRE_CHAVE
%token <sval> FECHA_CHAVE
%token <sval> OPERADOR_LOGICO
%token <sval> ABRE_COLCHETE
%token <sval> FECHA_COLCHETE
%token <sval> ENQUANTO
%token <sval> INICIO
%token <sval> FIM


%start Inicio
%%
Inicio:
	INICIO corpo_programa FIM {printf("programa ok");}

corpo_programa:
	|criacao_variaveis corpo_programa
	|comando_atribuicao corpo_programa
	|comando_escolha corpo_programa
	|comando_repeticao corpo_programa
	;

criacao_variaveis:
	|VARIAVEL lista_variaveis
	;

lista_variaveis:
	IDENTIFICADOR SEPARADOR lista_variaveis {printf("variaveis : %s\n", $1);}
	|IDENTIFICADOR  INSTRUCAO{printf("variaveis : %s\n", $1);}


comando_atribuicao:
	|IDENTIFICADOR ATRIBUICAO INTEIRO INSTRUCAO {printf("comando de atribuicao: %s <- %s\n", $1, $3);}
	;

comando_escolha:
|SE ABRE_CHAVE IDENTIFICADOR OPERADOR_LOGICO INTEIRO FECHA_CHAVE ABRE_COLCHETE comandos FECHA_COLCHETE {printf("comando logico\n");}
;

comandos:
 |comando_atribuicao
 ;

comando_repeticao:
	|ENQUANTO ABRE_CHAVE IDENTIFICADOR OPERADOR_LOGICO INTEIRO FECHA_CHAVE ABRE_COLCHETE comandos FECHA_COLCHETE {printf("comando repeticao\n");}

%%

int yyerror(char *s) {
  printf("yyerror : %s\n",s);
}

int main(void) {
  yyparse();
}
