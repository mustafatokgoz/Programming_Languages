%{
  #include "y.tab.h"
%}


%%

,                     {return OP_COMMA;}
\*\*                  {return OP_DBLMULT;}
\-                     {return OP_MINUS;}
\*                    {return OP_MULT;}
\+                    {return OP_PLUS;}
\/                    {return OP_DIV;}
false                 {return KW_FALSE;}
disp                  {return KW_DISP;}
load                  {return KW_LOAD;}
exit                  {return KW_EXIT;}
if                    {return KW_IF;}
for                   {return KW_FOR;}
deffun                {return KW_DEFFUN;}
set                   {return KW_SET;}
concat                {return KW_CONCAT;}
append                {return KW_APPEND;}
nil                   {return KW_NIL;}
less                  {return KW_LESS;}
equal                 {return KW_EQUAL;}
not                   {return KW_NOT;}
and                   {return KW_AND;}
or                    {return KW_OR;}
true                  {return KW_TRUE;}
;;(.*)                {return COMMENT;}
list                  {return KW_LIST;}
\(                    {return OP_OP;}
\)                    {return OP_CP;}
(\r\n|\r|\n)          {return 0;}
[0-9]|[1-9][0-9]*     {yylval.val =atoi(yytext) ; return  VALUE;}
[[1-9][:digit:]]+         {yylval.val = atoi(yytext); return VALUE;}
[[:space:]]+          {}

[[:alpha:]][[:alnum:]]*  {strcpy(yylval.id,yytext); return IDENTIFIER;}


%%
int yywrap(){}
