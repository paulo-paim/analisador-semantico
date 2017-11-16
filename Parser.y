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
%token <sval> INTEIRO
%token <sval> SEPARADOR
%token <sval> TIPO_PRIMITIVO
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
%token <sval> INICIO_FUNCAO
%token <sval> OPERADOR_MATEMATICO


%start Inicio
%%
Inicio:
	INICIO corpo_programa FIM {printf("programa ok");}

corpo_programa:
	|criacao_variaveis corpo_programa
	|comando_atribuicao corpo_programa
	|comando_escolha corpo_programa
	|comando_repeticao corpo_programa
	|chamada_funcao corpo_programa
	;

criacao_variaveis:
	|TIPO_PRIMITIVO lista_variaveis
	;

lista_variaveis:
	IDENTIFICADOR SEPARADOR lista_variaveis {printf("variaveis : %s\n", $1);}
	|IDENTIFICADOR  INSTRUCAO{printf("variaveis : %s\n", $1);}


comando_atribuicao:
	|IDENTIFICADOR ATRIBUICAO INTEIRO INSTRUCAO {printf("comando de atribuicao: %s <- %s\n", $1, $3);}
	|IDENTIFICADOR ATRIBUICAO lista_comandos_matematicos INSTRUCAO;

	;
possibilidades_atribuicao:
	|INTEIRO
	|IDENTIFICADOR
	|ABRE_CHAVE IDENTIFICADOR FECHA_CHAVE
	|ABRE_CHAVE INTEIRO FECHA_CHAVE
	;

lista_comandos_matematicos:
	|ABRE_CHAVE lista_comandos_matematicos FECHA_CHAVE
	|possibilidades_atribuicao OPERADOR_MATEMATICO lista_comandos_matematicos
	|possibilidades_atribuicao OPERADOR_MATEMATICO possibilidades_atribuicao

	;

comando_escolha:
|SE ABRE_CHAVE IDENTIFICADOR OPERADOR_LOGICO INTEIRO FECHA_CHAVE ABRE_COLCHETE comandos FECHA_COLCHETE {printf("comando logico\n");}
;

comandos:
 |corpo_programa
 ;

comando_repeticao:
	|ENQUANTO ABRE_CHAVE IDENTIFICADOR OPERADOR_LOGICO INTEIRO FECHA_CHAVE ABRE_COLCHETE comandos FECHA_COLCHETE {printf("comando repeticao\n");}

chamada_funcao:
	|INICIO_FUNCAO IDENTIFICADOR ABRE_CHAVE parametros FECHA_CHAVE INSTRUCAO {printf("chamada de funcao\n");}
	;

parametros:
	|IDENTIFICADOR SEPARADOR parametros
	|IDENTIFICADOR
	;

%%

int yyerror(char *s) {
  printf("yyerror : %s\n",s);
}

int main(void) {
  yyparse();
}
