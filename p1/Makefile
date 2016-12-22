FUENTE = practica1
PRUEBA = practica1_prueba1.txt
PRUEBA2 = practica1_prueba2.txt

all: compile

compile:
	flex $(FUENTE).l
	gcc -o $(FUENTE) lex.yy.c -lfl

clean:
	rm $(FUENTE) lex.yy.c 

run:
	./$(FUENTE) $(PRUEBA)

run2:
	./$(FUENTE) $(PRUEBA2)

