/********************************************************
*                                                       *
*   Disciplina: Compiladores    Turma: 2017             *
*                                                       *
*               Analisador Sintatico                    *
*                                                       *
*   Dupla:                                              *
*       Bruno Ferreira Leal     -        RA: 151042161  *
*       Paulo Henrique Paim dos Santos - RA: 151040745  *   
*                                                       *
*********************************************************/



%{
#include <stdio.h>

	extern int linha;
	extern int erro;
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
%token <sval> ABRE_PAR
%token <sval> FECHA_PAR
%token <sval> OPERADOR_LOGICO
%token <sval> ABRE_CHAVE
%token <sval> FECHA_CHAVE
%token <sval> ENQUANTO
%token <sval> INICIO
%token <sval> FIM
%token <sval> INICIO_FUNCAO
%token <sval> OPERADOR_MATEMATICO
%token <sval> LINHA
%token <sval> ERRO 


%start Inicio
%%
Inicio:
	INICIO corpo_programa FIM {printf("programa ok\n");}
    ;

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
    ;

comando_atribuicao:
	|IDENTIFICADOR ATRIBUICAO INTEIRO INSTRUCAO {printf("comando de atribuicao: %s <- %s\n", $1, $3);}
	|IDENTIFICADOR ATRIBUICAO lista_comandos_matematicos INSTRUCAO;
	;

possibilidades_atribuicao:
	|INTEIRO
	|IDENTIFICADOR
	|ABRE_PAR IDENTIFICADOR FECHA_PAR
	|ABRE_PAR INTEIRO FECHA_PAR
	;

lista_comandos_matematicos:
	|ABRE_PAR lista_comandos_matematicos FECHA_PAR
	|possibilidades_atribuicao OPERADOR_MATEMATICO lista_comandos_matematicos
	|possibilidades_atribuicao OPERADOR_MATEMATICO possibilidades_atribuicao
	;

comando_escolha:
    SE ABRE_PAR instrucao_logica FECHA_PAR ABRE_CHAVE comandos FECHA_CHAVE {printf("comando logico\n");}
    ;

instrucao_logica:
	 possibilidades_atribuicao OPERADOR_LOGICO possibilidades_atribuicao
	|ABRE_PAR instrucao_logica FECHA_PAR
	|possibilidades_atribuicao OPERADOR_LOGICO instrucao_logica
    ;

comandos:
    |corpo_programa
    ;

comando_repeticao:
	|ENQUANTO ABRE_PAR instrucao_logica FECHA_PAR ABRE_CHAVE comandos FECHA_CHAVE {printf("comando repeticao\n");}
    ;

chamada_funcao:
	|INICIO_FUNCAO IDENTIFICADOR ABRE_PAR parametros FECHA_PAR INSTRUCAO {printf("chamada de funcao\n");}
	;

parametros:
	|IDENTIFICADOR SEPARADOR parametros
	|IDENTIFICADOR
	;


%%

int yyerror(char *s) {
  erro++;
  printf("\n\nyyerror: %s - Linha: %d - Erro: %d\n\n",s, linha, erro);
}

int main(void) {
  printf("\n\n=============== Analisador Sintático ===============\n\n");
  yyparse();
}
