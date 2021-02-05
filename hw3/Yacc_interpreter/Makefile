gpp_interpreter.out:	gpp_lexer.c
		flex -o gpp_lexer.c gpp_lexer.l
		yacc -d gpp_interpreter.y
		gcc -g gpp_lexer.c y.tab.c -ll

clean:
		rm a.out gpp_lexer.c
