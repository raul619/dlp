FUENTE = practica2
PRUEBA = practica2_prueba1.txt
PRUEBA2 = practica2_prueba2.txt
PRUEBA3 = practica2_prueba3.txt

all: compile run

compile:
	flex $(FUENTE).l
	bison -o $(FUENTE).tab.c $(FUENTE).y -yd
	gcc -o $(FUENTE) lex.yy.c $(FUENTE).tab.c -lfl -ly

run:
	./$(FUENTE) < $(PRUEBA)

run2:
	./$(FUENTE) < $(PRUEBA2)

run3:
	./$(FUENTE) < $(PRUEBA3)

clean:
	rm $(FUENTE) lex.yy.c $(FUENTE).tab.c $(FUENTE).tab.h
