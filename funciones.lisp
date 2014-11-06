;Entrada al algoritmo
;Los mensajes print son 'puntos de depuración'
(defun unificar(e1 e2)
	(print "Argumentos")
	(print "e1") (print e1)
	(print "e2") (print e2)
	(cond 
		((esatomo e1) (print "Camino 1") (unif e2 e1)) 
		((esatomo e2) (print "Camino 2") (unif e1 e2))
		(T (print "Camino 3") (unificarListas e1 e2))
	)
)

;Subrutina para tratar símbolos

(defun unif(e1 e2)
	(cond 
		((equal e1 e2) '(*))
		((esvariable e1) (if (member (extraersimbolo e1) e2) NIL (list (extraersimbolo e2) (extraersimbolo e1))))
		((esvariable e2) (list (extraersimbolo e1) (extraersimbolo e2)))
		(T NIL)
	)
)


;Imprimir elementos
(defun print-elements-of-list (list)
       (while list
         (print (car list))
         (setq list (cdr list)))
)


;Procesado de listas
(defun unificarListas(e1 e2)
	(defparameter f1 (first e1))
	(print "f1") ;Depuracion
	(print f1) ;Depuracion
	(defparameter t1 (rest e1))
	(print "t1") ;Depuracion
	(print t1) ;Depuracion

	(defparameter f2 (first e2))
	(print "f2")
	(print f2)

	(defparameter t2 (rest e2))
	(print "t2")
	(print t2)

	(defparameter z1 (unificar f1 f2))
	(when (eq z1 NIL) NIL)
	(print "z1")
	(print z1)

	(defparameter g1 (aplicar z1 t1))
	(print "g1") (print g1)
	
	(defparameter g2 (aplicar z1 t2))
	(print "g2") (print g2)

	(defparameter z2 (unificar g1 g2))

	(when (eq z2 NIL) NIL)
	(print "z2")
	(print z2)

	(print "Resultado final")
	(cond 
		((and (esnada z1) (esnada z2)) NIL)
		((and (esnada z1) (not (esnada z2))) (list z2))
		((and (esnada z2) (not (esnada z1))) (list z1))
		(T (list (copy-list z1) (copy-list z2)))
	)
)


;Funcion reescrita para trabajar con listas en vez de elementos. La primera lista indica la sustitucion: (a b) significa reemplazar b por a
(defun aplicar (sustitucion lista)
	(when (eq lista '(*)) lista)
	(if (eq lista '())
	()
	(cons (sustituir (first sustitucion) (first (rest sustitucion)) (first lista))(poner (first sustitucion) (first (rest sustitucion)) (rest lista))))
)

(defun sustituir (a b elem)
	(if (eq elem a)
	b
	elem)
)

(defun poner (a b lista)
(if (eq lista '())
()
(cons (sustituir a b (first lista))(poner a b (rest lista))))
)

;Indica si es un atomo o no. Simplement comprueba si no comienza por ? . ¿Comprobar si comienza por *?
(defun esatomo(algo)
	(and (not (eq '? (first algo))) (atom (first algo)))
)

;Comprueba si es variable
(defun esvariable (algo)
(eq '? (first algo)))


;Tanto si se pasa una variable o un atomo retorna el simbolo. Permite trabajar con ambos elementos de la misma forma
(defun extraerSimbolo(simbolo)
	(if (esvariable simbolo) 
		(first (rest simbolo))
		(first simbolo)
	)
)


;Comprueba el tipo de dato nada
(defun esnada (simbolo)
	(and (eq '* (first simbolo)) (eq (length simbolo) 1))
)

(defun esfuncion(simbolo)
	(cond 
		((esvariable simbolo) NIL)
		((eq * (first simbolo)) NIL)
		((not (eq (rest simbolo) NIL)) T)
	)


	;(and (not (esvariable simbolo)) (not (atom simbolo)) (not (eq '(*) simbolo)))
)



(defun aplicarRecursivo (sustitucion lista)
		(when (eq lista '(*)) lista)
		(if (eq lista '())
		()
		(cons (sustituir (first sustitucion) (first (rest sustitucion)) (first lista))(poner (first sustitucion) (first (rest sustitucion)) (rest lista))))

)

(defun aplicarRecursivo(sustitucion lista)
	(defparameter s1 (first sustitucion)) ; (nth 0 sustitucion) es otro método
	(defparameter s2 (first (rest sustitucion))) ; (nth 1 sustitucion) es otro método
	(when (eq lista '(*)) lista)
		(if (eq lista '())
		()
		(if (esfuncion (first lista)) (cons (aplicarRecursivo(sustitucion (first lista))) (rest lista)) (cons (sustituir s1 s2 (first lista))(poner s1 s2 (rest lista)))))
)

;(defun aplicar (sustitucion lista)
;	(when (eq lista '(*)) lista)
;	(if (eq lista '())
;	()
;	(cons (sustituir (first sustitucion) (first (rest sustitucion)) (first lista))(poner (first sustitucion) (first (rest sustitucion)) (rest lista))))
;)