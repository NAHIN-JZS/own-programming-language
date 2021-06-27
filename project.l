%{
	#include <stdio.h>
	#include <string.h>
	#include <math.h>
	#include "project.tab.h"
	extern int yylval;
	int yylineno = 0 ;
	
	
%}

digit	(-|\+)*[0-9]

ID		[a-zA-Z][a-zA-Z0-9_]*


%%

{digit}+	    			{yylval = atoi(yytext); return NUMBER; }
"purno" 			        {return INT;		}
"doshomik"  			    	{return FLOAT;     }
"okkhor"        			{return CHAR; 		}
"for_loop"       			{return FOR; 		}
"while_loop"    			{return WHILE; 	}
"jodi_hoi"      			{return IF;		}
"owthoba"        			{return ELSE;		}
"folafol"      			    {return RETURN; 	}
"value_milau"        		{return SWITCH;	}
"kisui_na"       			{return VOID; 		}
"baad_deu"     			    {return BREAK;     }
"value"         			{return CASE;      }
"niche_baad_choloman"       {return CONTINUE; 	}
"onnothai"       			{return DEFAULT; 	}



"+" 						{return PLUS;		}
"-" 						{return MINUS;  	}
"*" 						{return MULTIPLY; 	}
"/"			    			{return DIVIDE;    }
"%"			    			{return MODULAR;	}


"^+" 						{return DPLUS; 	}	
"^-" 						{return DMINUS;	}
"@+" 						{return UPLUS; 	}
"@-" 						{return UMINUS; 	}


">"    						{return GREATERTHAN; 		}
"<"   						{return LESSTHAN; 			} 
">@"  						{return GREATERTHANEQUAL;	}
"<@"  						{return LESSTHANEQUAL;		}
"@@"          				{return EQUALEQUAL;	    }
"!@" 						{return NOTEQUAL; 			}


"/&" 						{return AND;		}
"/|" 						{return OR;		}
"/!" 						{return NOT; 		}
						

"@"  						{return EQUAL; 	 }
"+@" 						{return PLUSEQUAL;	 }
"-@" 						{return MINUSEQUAL; }
"*@" 						{return MULEQUAL;	 }
"/@" 						{return DIVEQUAL; 	 }
"%@" 						{return MODEQUAL; 	 }


"dekhau" 					{return PRINT;		}
"neu"  						{return TAKE; 		}
						


","  						{return COMA;		}
"?"  						{return COLON;		}
"."  						{return SEMI;		}


"("							{return FBRS; 		}
")"							{return FBRE;  	}
"{"							{return SBRS; 		}
"}"							{return SBRE; 		}
"["							{return TBRS;		}
"]"							{return TBRE; 		}

						

"purno main"	    		{return MAIN; }

[ \t]		;
[ \n]   { yylineno = yylineno + 1;}
{ID}          			{	char *vari;
								vari = yytext;
								int value11 = -27;
								int i;
								
								for( ;*vari !='\0';*vari++){
									value11 = value11 + *vari-'a'+27;
								}
								yylval = value11;
							
							
							 return VARIABLE; }	
								           ;
[#].*						{printf("\nSingle line comment. \n");}										   
. {
	printf("Nothing matched  %s %d \n",yytext,yylineno+1);
	exit(0);
}
%%

int yywrap()
{
	return 1;
}

int main()
{
		yyin = freopen("input.c", "r",stdin);
		freopen("output.txt","w",stdout);
		yyparse();
		return 0;
}