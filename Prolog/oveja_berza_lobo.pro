/*****************************************************************************

		Copyright (c) My Company

 Project:  OVEJA_LOBO_BERZA
 FileName: OVEJA_LOBO_BERZA.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
******************************************************************************/

include "oveja_lobo_berza.inc"

domains
	orilla=symbol
	estado=e(orilla,orilla,orilla,orilla)
	solucion=estado*
predicates
	backtrack(estado,estado,solucion)
	regla(estado,estado)
	escribe(solucion)
	miembro(estado,solucion)
	opuesto(orilla,orilla)
	inseguro(estado)
  	oveja_lobo_berza()

clauses
	backtrack(A,A,Solucion):-
		escribe(Solucion).
	
	backtrack(A,B,Solucion):-
		regla(A,C),
		not(inseguro(C)),
		not(miembro(C,Solucion)),
		backtrack(C,B,[C|Solucion]). %Añado C a mi solucion (lista)
	%Hacemos una funcion para escribir listas
	escribe([]). %lista vacía
	escribe([H|T]):-
		escribe(T),
		write(H,'\n').
		
	miembro(A,[A|_]).	
	miembro(A,[_|T]):-
		miembro(A,T).
	
	opuesto(e,o).
	opuesto(o,e).
	
	%pastor sólo	
	regla(e(PI,L,O,B),e(PF,L,O,B)):-
		opuesto(PI,PF).
	%pastor-lobo
	regla(e(I,I,O,B),e(F,F,O,B)):-
		opuesto(I,F).
	%pastor-oveja
	regla(e(I,L,I,B),e(F,L,F,B)):-
		opuesto(I,F).
	%pastor-berza
	regla(e(I,L,O,I),e(F,L,O,F)):-
		opuesto(I,F).
	%seguridad lobo oveja
	inseguro(e(P,LO,LO,_)):-
		opuesto(P,LO).
	%seguridad oveja berza
	inseguro(e(P,_,LO,LO)):-
		opuesto(P,LO).
		
  	oveja_lobo_berza():-!.

goal
	backtrack(e(e,e,e,e),e(o,o,o,o),[]).
  	%oveja_lobo_berza().

