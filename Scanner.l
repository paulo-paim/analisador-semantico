
%{
#include <stdio.h>
#include "Parser.tab.h"
int linha=1;
%}

digito 		[0-9]
letra 		[A-Za-z]
operador_mat 	"*"|"/"|"+"|"-"|"%"
operador_log 	"<"|">"|"<="|">="|"=="|"!="|"&&"|"||"
enter 		[\n]
tab 		[\t]
espaco 		" "

int 		[+-]?{digito}+
real 		{int}[.]{digito}+
string 		{letra}({digito}*{letra}*)*

comentario 	"//"[^\n]*
tipo 		"int"|"real"|"string"

%%

{int} 		{	printf("valor inteiro: %s\t-> linha: %d\n",yytext, linha);			return INTEIRO;		}
{real} 		{	printf("valor real: %s\t-> linha: %d\n",yytext, linha);				return REAL;		}

se		{	printf("palavra reservada: SE\t-> linha: %d\n", yytext, linha);			return SE;		}
senao		{	printf("palavra reservada: SENAO\t-> linha: %d\n", yytext, linha);		return SENAO;		}
para		{	printf("palavra reservada: PARA\t-> linha: %d\n", yytext, linha);		return PARA;		}
enquanto	{	printf("palavra reservada: ENQUANTO\t-> linha: %d\n", yytext, linha);		return ENQUANTO;	}
main		{	printf("palavra reservada: MAIN\t-> linha: %d\n", yytext, linha);		return MAIN;		}
void		{	printf("palavra reservada: VOID\t-> linha: %d\n", yytext, linha);		return VOID;		}

"="		{	printf("operador de atribuicao: %s\t-> linha: %d\n",yytext, linha);		return ATRIBUICAO;	}
";"		{	printf("fim da instrucao: %s\t-> linha: %d\n",yytext, linha);			return PONTO_VIR;	}
","		{	printf("separador de operandos: %s\t-> linha: %d\n",yytext, linha);		return VIRGULA;		}

"("		{	printf("delimitador de escopo: %s\t-> linha: %d\n",yytext, linha);		return ABRE_PAR;	}
")"		{	printf("delimitador de escopo: %s\t-> linha: %d\n",yytext, linha);		return FECHA_PAR;	}
"{"		{	printf("delimitador de escopo: %s\t-> linha: %d\n",yytext, linha);		return ABRE_CHA;	}
"}"		{	printf("delimitador de escopo: %s\t-> linha: %d\n",yytext, linha);		return FECHA_CHA;	}
"["		{	printf("delimitador de escopo: %s\t-> linha: %d\n",yytext, linha);		return ABRE_COL;	}
"]"		{	printf("delimitador de escopo: %s\t-> linha: %d\n",yytext, linha);		return FECHA_COL;	}

{tipo} 		{	printf("tipo: %s\t-> linha: %d\n", yytext, linha);				return TIPO;		}

{string} 	{	printf("string de identificadores: %s\t-> linha: %d\n",yytext, linha);		return STRING;		}
{comentario} 	{	printf("comentario em linha: %s\t-> linha: %d\n",yytext, linha);		return COMENTARIO;	}

{operador_mat} 	{	printf("operador matematico: %s\t-> linha: %d\n",yytext, linha);		return OPERADOR_MAT;	}
{operador_log} 	{	printf("operador logico: %s\t-> linha: %d\n",yytext, linha);			return OPERADOR_LOGICO;	}


{tab} 		{	printf("tabulacao: TAB\t-> linha: %d\n",linha);					return TAB;		}
{enter} 	{	printf("delimitador de linha: ENTER\t-> linha: %d\n",linha); linha++;		return ENTER;		}
{espaco} 	{	printf("espaco em branco localizado. \t-> linha: %d\n",linha);			return ESPACO;		}
. 		{	printf("ERRO. Caracter desconhecido: %s\t-> linha: %d\n",yytext, linha);	return ERRO;		}

%%

int main(int argc, char **argv){
  printf("nome do arquivo carregado: %s\n\nTokens encontrados no arquivo:\n\n",argv[1]);
  yyin=fopen(argv[1], "r");
  yylex();
}
