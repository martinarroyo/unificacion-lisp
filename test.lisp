(load "unificar-cond.lisp")

;Probar miembro unificador

(setf test1 '())
(setf test2 '((? x) A))
(setf test3 '((? b) C))

;Unificador de prueba
(setf test4 '(((? x) A)) )
(setf test5 '(((? x) (? b))) )
(setf test6 '(((? x) A) ((? b) C)))


(print "Probando miembro-unificador")

(format t "miembro-unificador retorna ~s para ~s y ~s~%" (miembro-unificador test1 test4) test1 test4)
(format t "miembro-unificador retorna ~s para ~s y ~s~%" (miembro-unificador test3 test4) test3 test4)
(format t "miembro-unificador retorna ~s para ~s y ~s~%" (miembro-unificador test3 test5) test3 test5)
(format t "miembro-unificador retorna ~s para ~s y ~s~%" (miembro-unificador test3 test6) test3 test6)
(format t "miembro-unificador retorna ~s para ~s y ~s~%" (miembro-unificador test3 '()) test3 '())


(print "Probando aplicarUnificador")

;Probar miembro unificador

(setf test1 '())
(setf test2 '((? x) A))
(setf test3 '(((? b) C) ((? x) A)))

;Unificador de prueba
(setf test4 '())
(setf test5 '(? x))
(setf test6 '((? x) C))

;(format t "aplicarUnificador retorna ~s para ~s y ~s" (aplicarUnificador test1 test4) test1 test4)
;(format t "aplicarUnificador retorna ~s para ~s y ~s" (aplicarUnificador test2 test5) test2 test5)
;(format t "aplicarUnificador retorna ~s para ~s y ~s" (aplicarUnificador test3 test6) test3 test6)




;
;(defun aplicarUnificador (unificador lista)
;	(setf regla (first unificador))
;
;	(cond
;		((null unificador) lista)
;		(T 	(aplicarUnificador (rest unificador) (aplicar regla lista)))
;	)
;)
;
;
;(defun aplicar (sustitucion lista)
;	(if (eq lista '())
;	()
;	(cons (sustituir (first sustitucion) (second sustitucion) (first lista))
;		(poner (first sustitucion) (second sustitucion) (rest lista))))
;)
;
;(defun sustituir (b a elem)
;	(if (eq elem a)
;	b
;	elem)
;)
;
;(defun poner (a b lista)
;(if (eq lista '())
;()
;(cons (sustituir a b (first lista))(poner a b (rest lista))))
;)
;

(format t "Probando esvariable~%")

(setf test1 '())
(setf test2 '(? x))
(setf test3 '(C))
(setf test4 '(((? x) A)) )
(setf test5 '(((? x) (? b))))
(setf test6 '(C D))

(format t "esvariable retorna ~s para ~s~%" (esvariable test1) test1)
(format t "esvariable retorna ~s para ~s~%" (esvariable test2) test2)
(format t "esvariable retorna ~s para ~s~%" (esvariable test3) test3)
(format t "esvariable retorna ~s para ~s~%" (esvariable test4) test4)
(format t "esvariable retorna ~s para ~s~%" (esvariable test5) test5)
(format t "esvariable retorna ~s para ~s~%" (esvariable test6) test6)


(setf test1 '())
(setf test2 '(? x))
(setf test3 '(C))
(setf test4 '(((? x) A)) )
(setf test5 '(((? x) (? b))))
(setf test6 '(A))

(format t "extraerSimbolo~%")

(format t "extraerSimbolo retorna ~s para ~s~%" (extraerSimbolo test1) test1)
(format t "extraerSimbolo retorna ~s para ~s~%" (extraerSimbolo test2) test2)
(format t "extraerSimbolo retorna ~s para ~s~%" (extraerSimbolo test3) test3)
(format t "extraerSimbolo retorna ~s para ~s~%" (extraerSimbolo test4) test4)
(format t "extraerSimbolo retorna ~s para ~s~%" (extraerSimbolo test5) test5)
(format t "extraerSimbolo retorna ~s para ~s~%" (extraerSimbolo test6) test6)

(format t "~%~%Probando miembro-unificador~%")

(setf test1 '(? x))
(setf test2 '(A (? x)))
(setf test3 '(B (? y)))


(setf test4 '(((? x) A)))
(setf test5 '((B (? y))))
(setf test6 '((A (? X)) (B (? Y))))

(format t "miembro-unificador retorna ~s para ~s y ~s~%" (miembro-unificador test1 test4) test1 test4)
(format t "miembro-unificador retorna ~s para ~s y ~s~%" (miembro-unificador test2 test5) test2 test5)
(format t "miembro-unificador retorna ~s para ~s y ~s~%" (miembro-unificador test3 test6) test3 test6)

(setf test1 '(? x))
(setf test2 'A)
(setf test3 '(A))

(setf test4 '(? y))
(setf test5 'B)
(setf test6 '(C))

(format t "poner retorna ~s para ~s, ~s y ~s~%" (poner test1 test2 test3) test1 test2 test3)
(format t "poner retorna ~s para ~s, ~s y ~s~%" (poner test4 test5 test6) test4 test5 test6)


(format t "~%~%Probando sustituir~%")

(setf test1 'A)
(setf test2 'B)
(setf test3 'A)

(setf test4 '(? y))
(setf test5 'B)
(setf test6 '(? y))

(setf test7 'A)
(setf test8 '(? y))
(setf test9 '(? y))


(format t "sustituir retorna ~s para ~s, ~s y ~s~%" (sustituir test1 test2 test3) test1 test2 test3)
(format t "sustituir retorna ~s para ~s, ~s y ~s~%" (sustituir test4 test5 test6) test4 test5 test6)
(format t "sustituir retorna ~s para ~s, ~s y ~s~%" (sustituir test7 test8 test9) test7 test8 test9)


(setf test1 '(? x))
(setf test2 '(P x))
(setf test3 '(x))
(setf test4 '(f r))
(setf test5 '())
(setf test6 'a)
(setf test7 '(q h m (? x)))

(format t "~%~%Probando esFuncion~%")
(format t "esFuncion retorna ~s para ~s~%" (esFuncion test1) test1)
(format t "esFuncion retorna ~s para ~s~%" (esFuncion test2) test2)
(format t "esFuncion retorna ~s para ~s~%" (esFuncion test3) test3)
(format t "esFuncion retorna ~s para ~s~%" (esFuncion test4) test4)
(format t "esFuncion retorna ~s para ~s~%" (esFuncion test5) test5)
(format t "esFuncion retorna ~s para ~s~%" (esFuncion test6) test6)
(format t "esFuncion retorna ~s para ~s~%" (esFuncion test7) test7)

(setf test1 '(P x))
(setf test2 '(P y))
(setf test3 '(P (? x)))
(setf test4 '(P (? y)))
(setf test5 '(P x))
(setf test6 '(P (? y)))
(setf test7 '(P x))
(setf test8 '(Q x))
(setf test9 '(P (? x) y))
(setf test10 '(P M (? n)))
(setf test11 '(P (? x) (? y)))
(setf test12 '(P (? x) (? x)))
(setf test13 '(P (f y) y))
(setf test14 '(P (? x) (? n)))

(format t "~%~%Probando la unificacion~%")
(format t "La unificacion de ~s y ~s es ~s~%" test1 test2 (unificarEntrada test1 test2))
(format t "La unificacion de ~s y ~s es ~s~%" test3 test4 (unificarEntrada test3 test4))
(format t "La unificacion de ~s y ~s es ~s~%" test5 test6 (unificarEntrada test5 test6))
(format t "La unificacion de ~s y ~s es ~s~%" test7 test8 (unificarEntrada test7 test8))
(format t "La unificacion de ~s y ~s es ~s~%" test9 test10 (unificarEntrada test9 test10))
(format t "La unificacion de ~s y ~s es ~s~%" test11 test12 (unificarEntrada test11 test12))
(format t "La unificacion de ~s y ~s es ~s~%" test13 test14 (unificarEntrada test13 test14))


;Probar unificar y unificarEntrada tienen como diferencia procesar o no el primer elemento


(setf test1 '(? x))
(setf test2 '(? y))


(setf test3 '(? x))
(setf test4 'y)
(setf test5 'P)
(setf test6 'P)
(setf test7 'a)
(setf test8 'b)

(defun probarUnif(e1 e2)
	(catch 'unificarException (unif e1 e2))
)

(format t "~%~%Probando la unificación de dos elementos individuales (Función unif)~%")
(format t "La unificación de ~s y ~s es ~s~%" test1 test2 (probarUnif test1 test2))
(format t "La unificación de ~s y ~s es ~s~%" test3 test4 (probarUnif test3 test4))
(format t "La unificación de ~s y ~s es ~s~%" test5 test6 (probarUnif test5 test6))
(format t "La unificación de ~s y ~s es ~s~%" test7 test8 (probarUnif test7 test8))




;(defun unif(e1 e2)
;	(cond
;		((esvariable e1) 
;			(if (and (not(atom e2)) (member (extraerSimbolo e1) e2)) (throw 'unificarException 'no-unificable)) (list e2 e1))
;		((esvariable e2) (list e1 e2))
;		(T 
;			(when (eq debug T) (print "Los dos son atomos"))  
;			(throw 'unificarException 'no-unificable))
;	)
;)
