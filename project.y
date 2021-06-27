			%{
				#include <stdio.h>
				#include <math.h>
				#include <string.h>
				int sym[1000];
				int store[1000];
				int t4,t5;
				int cnt;
			%}

			%token BREAK CASE CHAR CONTINUE DEFAULT DO ELSE INT	FLOAT DOUBLE LONG FOR GOTO IF RETURN SWITCH	VOID WHILE PLUS 
			%token MINUS MULTIPLY DIVIDE MODULAR DPLUS DMINUS UPLUS	UMINUS 
			%token GREATERTHAN LESSTHAN GREATERTHANEQUAL LESSTHANEQUAL EQUALEQUAL NOTEQUAL
			%token AND OR NOT EQUAL PLUSEQUAL MINUSEQUAL MULEQUAL DIVEQUAL MODEQUAL PRINT TAKE COTATION HASH SAND 
			%token PI PF PD	PC PS NEWLINE TAB DOT COMA COLON SEMI FBRS FBRE	SBRS SBRE TBRS TBRE PERCENT GAP
			%token MAIN VARIABLE NUMBER

			%nonassoc IF
			%nonassoc ELSE
			%nonassoc FOR
			


			%left PLUS MINUS
			%left MULTIPLY DIVIDE
			%left MODULAR
			%right POWER
			%left OR
			%left AND
			%nonassoc LESSTHAN GREATERTHAN

			%%

			program1 : 
					| program1 program 
				 ;

			program: MAIN fbs fbe sbs stat sbe {
						printf("Program End.\n");
					}
				 ;
			stat: 
				| stat cstatement
				;
				
			cstatement: /* empty */

				| cstatement statement
				
				| cdeclaration
				;
						
			cdeclaration: TYPE ID1 SEMI
						;
						
			TYPE : INT 
				   | FLOAT 
				   | CHAR 
				 ;

			ID1  : ID1 COMA VARIABLE {
									if(store[$3] == 1)
									{
										printf("error: multiple declaration for '%c'\n", $3 + 97);
									}
									else
									{
										store[$3] = 1;
									}
						}
						
				 | VARIABLE EQUAL expr {
										if(store[$1] == 1)
									{
										printf("error: multiple declaration for '%c'\n", $3 + 97);
									}
									else
									{
										store[$1] = 1;
										sym[$1] = $3;
									}
				 }

				 |VARIABLE {
							if(store[$1] == 1)
							{	
								printf("error: multiple declaration for '%c'.\n",$1+97);
							}
							else
							{
								store[$1] = 1;
							}
						}
				 ;
				 
				 
			statement: SWITCH fbs expr fbe sbs BASE sbe 
				| expr SEMI
				| PRINT expr SEMI    		{printf("%d\n",$2);}
				| VARIABLE EQUAL expr		{sym[$1] = $3}
				| VARIABLE EQUAL expr SEMI 		{
								sym[$1] = $3 ;
								t4 = sym[$1] ;
								if(store[$1] == 1){
									//printf("Value of the variable %c is : %d\t\n",$1+97,$3);
								}
								else { 
									//printf("error: '%c' undeclared (first use in this function)\n",$1+97);
								}
								$$ = $3;
							}
				| IF fbs expr fbe sbs expr SEMI sbe{
											if($3){
												printf("Value of IF : %d \n",$6);
											}
											else {
												printf("Condition false.\n");
											}
										}
				| IF fbs expr fbe sbs expr SEMI sbe ELSE sbs expr SEMI sbe{
											if($3){
												printf("Value of If condition : %d \n" , $6);
											}
											else{
												printf("Value of else condition : %d \n", $11);
											}
										}
				| FOR fbs VARIABLE EQUAL expr SEMI expr LESSTHAN expr SEMI expr fbe SEMI{
										printf("Single For Loop.\n");
										
				}
				| FOR fbs VARIABLE EQUAL expr SEMI expr LESSTHAN expr SEMI expr fbe sbs stat sbe {
										int i;
										for(i=$5;i<$9;i++)
										{
											printf("%d ",i);
										}
										printf("\n");
										
				}
				| FOR fbs VARIABLE EQUAL expr SEMI expr GREATERTHAN expr SEMI expr fbe sbs stat sbe {
										int i;
										for(i=$5;i>$9;i--)
										{
											printf("%d ",i);
										}
										printf("\n");
										
				}
				| FOR fbs VARIABLE EQUAL expr SEMI expr LESSTHANEQUAL expr SEMI expr fbe sbs stat sbe {
										int i;
										for(i=$5;i<=$9;i++)
										{
											printf("%d ",i);
										}
										printf("\n");
										
				}
				| FOR fbs VARIABLE EQUAL expr SEMI expr GREATERTHANEQUAL expr SEMI expr fbe sbs stat sbe {
										int i;
										for(i=$5;i>=$9;i--)
										{
											printf("%d ",i);
										}
										printf("\n");
										
				}
				| WHILE fbs expr LESSTHAN expr fbe sbs statement sbe {
										int i;
										for(i=1;i<=$5;i++)
										{
											printf("%d ",i);
										}
										printf("\n");
				} 
				;

			BASE : Bas
				 | Bas Dflt
				 ;

			Bas   : /*NULL*/
				 | Bas Cs
				 ;

			Cs    : CASE NUMBER COLON expr SEMI BREAK SEMI {
						if(t4==$2){
							  cnt=1;
							  printf("\nCase No. : %d  and Result : %d \n",$2,$4);
						}
					}
				 ;

			Dflt    : DEFAULT COLON expr SEMI BREAK SEMI {
						if(cnt==0){
							printf("\nResult in default Value is :  %d \n",$3);
						}
					}
				 ;    

			expr: NUMBER 					
				| PRINT expr     			{printf("%d\n",$2);}
				| VARIABLE 					{$$ = sym[$1] ;}
				| expr EQUAL expr 			{sym[$1] = $3 ;}
				| VARIABLE tbs expr tbe 	{printf("1D Array\n");}
				| VARIABLE tbs expr COMA expr tbe {printf("2D Array\n");}
				| expr DPLUS            {$$ = $1++ }
				| expr DMINUS           {$$ = $1-- }
				| expr PLUS expr		{$$ = $1 + $3;}
				| expr MINUS expr		{$$ = $1 - $3;}
				| expr MULTIPLY expr	{$$ = $1 * $3;}
				| expr DIVIDE expr		{if($3) $$ = $1 / $3; else printf("\nDIVISION BY ZERO\n"); }
				| expr POWER expr		{$$ = pow($1, $3);}
				| expr MODULAR expr  	{$$ = $1 % $3;}
				| expr LESSTHAN expr 	{$$ = $1 < $3;}
				| expr GREATERTHAN expr {$$ = $1 > $3;}
				| fbs expr fbe 		{$$ = $2;}
				;
			fbs: FBRS
			;
			fbe: FBRE
			;
			sbs: SBRS
			;
			sbe: SBRE
			;
			tbs: TBRS
			;
			tbe: TBRE
			;
			%%

			yyerror(char *s) /* called by yyparse on error */
			{
				printf("%s\n",s);
				return (0);
			}
