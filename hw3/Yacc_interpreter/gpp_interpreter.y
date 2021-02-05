%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int yylex();
int yyerror (char *s);

void yyrestart (FILE *input_file);
extern FILE *yyin;


typedef struct table {
	char id[50];
	int value;
}table;


table tableT[100];
int arr[500];
int sizearr=0;
int null=0;

int exist_id = 0;

void print_arr(int *array);
int* concat_arr(int*, int*);
void append_arr(int*, int);
int power(int num,int exp);

int put_entry(char id[50], int value);
int get_entry(char id[50]);

%}

/* To compile all:
yacc -d gpp_interpreter.y
lex gpp_lexer.l
cc -g lex.yy.c y.tab.c -ll
*/
%union{
		int *arr_val;
    int val;
    char id[50];
}

%start START
%token OP_DBLMULT OP_MINUS OP_MULT OP_PLUS OP_DIV KW_FALSE KW_DISP KW_LOAD KW_EXIT KW_IF
      KW_FOR KW_DEFFUN KW_SET KW_CONCAT KW_APPEND KW_NIL KW_LESS KW_EQUAL KW_NOT KW_AND KW_OR KW_TRUE
      COMMENT KW_LIST OP_OP OP_CP OP_COMMA


%token <val> VALUE
%token <id> IDENTIFIER


%type <val> INPUT
%type <val> EXPI
%type <val> EXPB
%type <arr_val> VALUES
%type <arr_val> LISTVALUE
%type <arr_val> EXPLISTI



%%
START: | INPUT;

INPUT:
    EXPI {
			if($$==-1){
				printf("SYNTAX OK. \nResult: ");
				print_arr(arr);
				sizearr=0;
			}
			else{	printf("SYNTAX OK. \nResult: %d\n", $$);
					}

			}
    |
    EXPLISTI {
			if(null==1){
				printf("SYNTAX OK. \nResult: nil\n");
				null=0;
			}
			else{
				printf("SYNTAX OK. \nResult: ");
				print_arr(arr);
				sizearr=0;
			}

		}
    |
		OP_OP KW_EXIT OP_CP {return 1;}
		|
    EXPB {  if($$==1)
                printf("SYNTAX OK. \nTRUE\n");
            else{  printf("SYNTAX OK. \nFALSE\n");
            }
    }
    ;


EXPI:
    OP_OP OP_PLUS EXPI EXPI OP_CP  {$$=$3+$4;} /* (+ EXPI EXPI) */
    |
    OP_OP OP_MINUS EXPI EXPI OP_CP {$$=$3-$4;} /* (- EXPI EXPI) */
    |
    OP_OP OP_MULT EXPI EXPI OP_CP  {$$=$3*$4;} /* (* EXPI EXPI) */
    |
    OP_OP OP_DIV EXPI EXPI OP_CP   {$$=$3/$4;} /* (/ EXPI EXPI) */
    |
    OP_OP OP_DBLMULT EXPI EXPI OP_CP {$$ = power($3, $4);}
    |
    IDENTIFIER {$$ = get_entry($1);}
    |
    VALUE {$$ = $1;}
    |
    OP_OP KW_SET IDENTIFIER EXPI OP_CP {$$ = put_entry($3, $4);}/* (set Id EXPI) */
    |
    OP_OP KW_IF EXPB EXPLISTI OP_CP {$$ = (1 == $3) ? -1 : 0;} /* (if EXPB EXPI) */
    |
    OP_OP KW_FOR EXPB EXPLISTI OP_CP { $$ = (1 == $3) ? -1 : 0; } /*like while loop*/
    |
    OP_OP KW_DISP EXPI OP_CP { $$ = $3;}
    ;

EXPB:
    OP_OP KW_AND EXPB EXPB OP_CP {$$ = $3 && $4;}   /* (and EXPB EXPB) */
    |
    OP_OP KW_OR EXPB EXPB OP_CP  {$$ = $3 || $4;}    /* (or EXPB EXPB) */
    |
    OP_OP KW_NOT EXPB OP_CP  {$$ = !($3);}      /* (not EXPB) */
    |
    OP_OP KW_EQUAL EXPB EXPB OP_CP {$$ = ($3 == $4);}  /* (equal EXPB EXPB) */
    |
    OP_OP KW_EQUAL EXPI EXPI OP_CP {$$ = ($3 == $4);}  /* (equal EXPI EXPI) */
    |
    OP_OP KW_LESS EXPI EXPI OP_CP {$$ = $3 < $4;} /* (less EXPI EXPI) */
    |
    KW_TRUE {$$ = 1;}   /* true */
    |
    KW_FALSE {$$ = 0;} /* false */
    |
    OP_OP KW_DISP EXPB OP_CP { $$ = $3;}
    ;

EXPLISTI:
    OP_OP KW_CONCAT EXPLISTI EXPLISTI OP_CP {}
    |
    OP_OP KW_APPEND EXPI EXPLISTI OP_CP {append_arr(arr, $3); sizearr++;}
    |
    OP_OP KW_LIST VALUES OP_CP {$$ = $3;}
    |
    LISTVALUE  {$$ = $1;}
    |
    OP_OP KW_DISP LISTVALUE OP_CP { $$ = $3; printf("Result: "); print_arr($3);}
    ;



LISTVALUE:
    OP_OP VALUES OP_CP {$$ = $2;}
    |
    OP_OP OP_CP {null=1;}
    |
    KW_NIL { null=1;}
    ;

VALUES:
    VALUES VALUE  {arr[sizearr]=$2; sizearr++;}
    |
    VALUE {$$ = 0; arr[sizearr]=$1;sizearr++;}
    ;


%%

/* For printing error messages */
int yyerror(char *s) {
    printf("SYNTAX_ERROR Expression not recognized\n");
    exit(1);
}

void print_arr(int *array){

    printf("(");
    for(int i=0;i<sizearr; ++i){
				if(i!=sizearr-1)
        	printf("%d ", array[i]);
				else
					printf("%d", array[i]);
    }
    printf(")\n");

}

// will be used both in init and append situations.
void append_arr(int *arr, int num){
      for(int i=sizearr-1 ; i>=0 ; i--){
        arr[i+1]=arr[i];
      }
      arr[0]=num;
}


int power(int num, int exp) {
    int i;
    if(exp==0)
        return 1;
    int temp=num;
    for(i=1;i<exp;i++){
        num=num*temp;
    }
    return num;

}

int put_entry(char id[50], int value){
	int i;
	for(i=0;i<exist_id;i++){
		if(strcmp(id, tableT[i].id)==0){
			tableT[i].value = value;
			return value;
		}
	}

	strcpy(tableT[i].id,id);
	tableT[i].value = value;
	exist_id = exist_id + 1;
  return value;
}

int get_entry(char id[50]){

	int i;
	for(i=0;i<exist_id;i++){
		if(strcmp(id,tableT[i].id)==0)
			return tableT[i].value;
	}
	printf("SYNTAX_ERROR Expression not recognized\n");
	exit(1);
}


int main(int argc, char **argv)
{
  	if (argc > 1 && argv[1]){
				yyin=fopen(argv[1],"r");
				yyrestart(yyin);
				while(1) {
							 if(yyparse()==1) {
								 		fclose(yyin);
									 	return 0;
							 	}
	 			}
				fclose(yyin);

		}
		yyin=stdin;
		yyrestart(yyin);
    while(1){
			if(yyparse()==1) {
					 return 0;
			 }
    }

    return 0;
}
