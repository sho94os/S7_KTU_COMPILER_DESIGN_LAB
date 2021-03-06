%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<string.h>

		
	FILE *fp;
%}


name "import"([a-z]|[A-Z])+
hash #

%%
{hash}" "(.*)\n	 {    char *commenttext = strdup(yytext);
		      commenttext[0]=' ' ; 
		      fprintf(fp," COMMENT<%s\>",commenttext);		   
		  }	
"if"	 {   fprintf(fp," TOKEN<IF> ");			   }
"def" 	 {   fprintf(fp," TOKEN<DEF> ");  		   }
"else"   {   fprintf(fp," TOKEN<ELSE> ");		   }
"elif"   {   fprintf(fp," TOKEN<ELIF> ");	           }
"while"  {   fprintf(fp," TOKEN<WHILE> ");	           }
"range"  {   fprintf(fp," TOKEN<RANGE> ");		   }
"in"	 {   fprintf(fp," TOKEN<IN> ");			   }
"return" {  fprintf(fp," TOKEN<RET> ");			   }
"print"  {  fprintf(fp," TOKEN<PRINT> ");		   }
{name}	 {  fprintf(fp, "TOKEN <IMPORT>");		   }

[a-z]([a-z]|[0-9])*	  { fprintf(fp,"  < TOKEN<IDENTIFIER> %s >  ",yytext); }
[+|-|*|%|/|=|(|)|:|<|<=|>=|>|==] 		  { fprintf(fp,"TOKEN<%s> ",yytext);   } 

[0-9][0-9]* { fprintf(fp,"< TOKEN<NUMBER> %s >",yytext);		 	}
[\n]    {  fprintf(fp,"\n");					}

":exit" {   fclose(fp); exit(0); 			   }
		
%%

int main(int argc , char*argv[])
{
	fp = fopen("output.txt","w");
	yylex();
	

}

