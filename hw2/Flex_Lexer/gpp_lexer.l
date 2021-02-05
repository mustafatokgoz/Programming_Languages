%{
FILE *fwp;
%}


%%


,                     {fprintf(fwp,"OP_COMMA\n");}
\*\*                  {fprintf(fwp,"OP_DBLMULT\n");}
\-                     {fprintf(fwp,"OP_MINUS\n");}
\*                    {fprintf(fwp,"OP_MULT\n");}
\+                    {fprintf(fwp,"OP_PLUS\n");}
\/                    {fprintf(fwp,"OP_DIV\n");}
\”                    {fprintf(fwp,"OP_CC\n");}
\“                    {fprintf(fwp,"OP_OC\n");}
false                 {fprintf(fwp,"KW_FALSE\n");}
disp                  {fprintf(fwp,"KW_DISP\n");}
load                  {fprintf(fwp,"KW_LOAD\n");}
exit                  {fprintf(fwp,"KW_EXIT\n");}
if                    {fprintf(fwp,"KW_IF\n");}
for                   {fprintf(fwp,"KW_FOR\n");}
deffun                {fprintf(fwp,"KW_DEFFUN\n");}
set                   {fprintf(fwp,"KW_SET\n");}
concat                {fprintf(fwp,"KW_CONCAT\n");}
append                {fprintf(fwp,"KW_APPEND\n");}
nil                   {fprintf(fwp,"KW_NIL\n");}
less                  {fprintf(fwp,"KW_LESS\n");}
equal                 {fprintf(fwp,"KW_EQUAL\n");}
not                   {fprintf(fwp,"KW_NOT\n");}
and                   {fprintf(fwp,"KW_AND\n");}
or                    {fprintf(fwp,"KW_OR\n");}
true                  {fprintf(fwp,"KW_TRUE\n");}
;;(.*)                {fprintf(fwp,"COMMENT\n");}
list                  {fprintf(fwp,"LIST\n");}
\(                    {fprintf(fwp,"OP_OP\n");}
\)                    {fprintf(fwp,"OP_CP\n");}
[0-9]|[1-9][0-9]*     {fprintf(fwp,"VALUE\n");}
[[:space:]]+          {}

[[:alpha:]][[:alnum:]]*  {fprintf(fwp,"IDENTIFIER\n");}
[0][[:digit:]]*          {fprintf(fwp,"SYNTAX_ERROR %s cannot be tokenized\n",yytext);}
[[:digit:]]+[a-zA-Z]	   {fprintf(fwp,"SYNTAX_ERROR %s cannot be tokenized\n",yytext);}
[0-9]+[+-/*.]            {fprintf(fwp,"SYNTAX_ERROR %s cannot be tokenized\n",yytext);}
[*+/-][0-9a-zA-Z]        {fprintf(fwp,"SYNTAX_ERROR %s cannot be tokenized\n",yytext);}
.                        {fprintf(fwp,"SYNTAX_ERROR %s cannot be tokenized\n",yytext);}

%%
int yywrap(){}


int main(int argc,char **argv){



 FILE *fp;

fwp=fopen("parsed_cpp.txt","w");

char all[4000];

 if(argc>1){
   fp = fopen(argv[1],"r");
   if(fp!=NULL){
      yyin = fp;
      yylex();
    }
    else{
      printf("File Does Not Exist");
    }
 }
 else{
   char *bp;
   size_t size;
   fp=open_memstream(&bp,&size);
   while(all[0]!='\n'){
       fgets(all,4000,stdin);
       fprintf(fp,"%s",all);
     }
   fclose(fp);

     fp=fmemopen(bp,size,"r");
     yyin = fp;
     yylex();
  }

return 0;
}
