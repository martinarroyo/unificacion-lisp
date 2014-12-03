/*****************************************************************************

		Copyright (c) My Company

 Project:  8-PUZZLE
 FileName: 8-PUZZLE.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
******************************************************************************/

include "8-puzzle.inc"

domains 
	casilla=integer
	fila=f(casilla,casilla,casilla)
	puzzle=p(fila,fila,fila)
	solucion=puzzle*
	
predicates
	backtrack(puzzle,puzzle,solucion)
	escribe(solucion)
	mover(puzzle, puzzle)
	moverArriba(puzzle,puzzle)
	moverIzq(puzzle,puzzle)
	miembro(puzzle,solucion)  

clauses
	/*Escritura de la lista */
        escribe([]).
        escribe([H|T]):-
        	escribe(T),
        	write(H,'\n').
        
        /*Estados repetidos */
        miembro(E,[E|_]).
        miembro(E,[_|T]):-
        	miembro(E,T).
        	
       
	/*Resolucion*/
	backtrack(A,B,Solucion):-
		mover(A,C),
		not(miembro(C,Solucion)),
		backtrack(C,B,[C|Solucion]). /*Recursividad*/
	
	/********MOVIMIENTOS********/
	mover(PIN,PFIN):- /*ARRIBA*/
		moverArriba(Pin,Pfin).
	
	mover(Pin,PFIN):- /*ABAJO*/
		moverArriba(Pfin,Pin).
		
	mover(Pin,PFIN):- /*IZQUIERDA*/
		moverIzq(Pin,Pfin).
	
	mover(Pin,PFIN):- /*DERECHA*/
		moverIzq(Pfin,Pin).
	
	/*ARRIBA/ABAJO*/		
	
	moverArriba(p(f(A,B,C),f(0,D,E),F3),
			p(f(0,B,C),f(A,D,E),F3)).
			
	moverArriba(p(f(A,B,C),f(D,0,E),F3),
			p(f(A,0,C),f(A,B,E),F3)).
			
	moverArriba(p(f(A,B,C),f(D,E,0),F3),
			p(f(A,B,0),f(D,E,C),F3)).
				
			
	moverArriba(p(F1,f(A,B,C),f(0,D,E)),
			p(F1,f(0,B,C),f(A,D,E))). 
			
	moverArriba(p(F1,f(A,B,C),f(D,0,E)),
			p(F1,f(A,0,C),f(D,B,E))).
			
	moverArriba(p(F1,f(A,B,C),f(D,E,0)),
			p(F1,f(A,B,0),f(D,E,C))).
	
	/*IZQUIERDA/DERECHA*/
	moverIzq(p(f(A,0,B),F2,F3),
			p(f(0,A,B),F2,F3)).
	moverIzq(p(f(A,B,0),F2,F3),
			p(f(A,0,B),F2,F3)).
	
	moverIzq(p(F1,f(A,0,B),F3),
			p(F1,f(0,A,B),F3)).
	moverIzq(p(F1,f(A,B,0),F3),
			p(F1,f(A,0,B),F3)).
	
	moverIzq(p(F1,F2,f(A,0,B)),
			p(F1,F2,f(0,A,B))).
	moverIzq(p(F1,F2,f(A,B,0)),
			p(F1,F2,f(A,0,B))).
			
goal
	backtrack(p(f(2,8,3),f(1,6,4),f(7,0,5)),p(f(1,2,3),f(8,0,4),f(7,6,5)),[]).
