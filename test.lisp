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

;;;

;
;
;(defun unificarEntrada(e1 e2)
;	(let ((unificador nil))
;		(if (eql (first e1) (first e2)) 
;			(catch 'unificarException (unificar (rest e1) (rest e2) unificador))
;			'no-unificable
;		)
;	)
;)
;
;(defun unificar(e1 e2 unificador)
;	(cond 
;		((eq e1 e2) unificador)
;		((or (null e1) (null e2)) (throw 'unificarException 'no-unificable))
;		((or (atom e1) (esvariable e1)) (when (eq debug T) (print "Camino 1: e1 es atomo o variable"))  (unif e1 e2)) 
;		((or (atom e2) (esvariable e2)) (when (eq debug T) (print "Camino 2: e2 es atomo o variable"))  (unif e2 e1))
;		((or (atom e1) (atom e2)) (throw 'unificarException 'no-unificable))
;		(T 
;			(when (eq debug T) (print "Camino 3: Son listas")) 
;			(set 'f1 (first e1))
;			(set 't1 (rest e1))
;
;			(set 'f2 (first e2))
;			(set 't2 (rest e2))
;
;			(set 'z1 (unificar f1 f2 unificador))
;			(cond 
;				((miembro-unificador z1 unificador) unificador)
;				(T (setf unificador (append unificador (list z1))))
;			)
;			(set 'g1 (aplicar z1 t1))
;			(set 'g2 (aplicar z1 t2))
;
;			(set 'z2 (unificar g1 g2 unificador))
;		)
;
;	)
;)
;

;
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


