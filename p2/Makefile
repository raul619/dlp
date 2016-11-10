FUENTE = asignaturap2
PRUEBA = textoprueba.txt

all: compile

compile:
	flex $(FUENTE).l
	gcc -o $(FUENTE) lex.yy.c -lfl

clean:
	rm $(FUENTE) lex.yy.c 

run:
	./$(FUENTE) $(PRUEBA)

