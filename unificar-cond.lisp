(defun unificarEntrada(e1 e2)
	(let ((unificador nil))
		(if (eql (first e1) (first e2)) 
			(catch 'unificarException (unificar (rest e1) (rest e2) unificador))
			'no-unificable
		)
	)
)

(defun unificarPrueba(e1 e2)
	(let ((unificador nil))
			(catch 'unificarException (unificar e1 e2 unificador))			
	)
)

(defun unificar(e1 e2 unificador)
	(cond 
		((eq e1 e2) unificador)
		((or (null e1) (null e2)) (throw 'unificarException 'no-unificable))
		((or (atom e1) (esvariable e1)) (print "Camino 1: e1 es atomo o variable") (unif e1 e2)) 
		((or (atom e2) (esvariable e2)) (print "Camino 2: e2 es atomo o variable") (unif e2 e1))
		((or (atom e1) (atom e2))
    		(throw 'unificarException 'no-unificable))
		(T 
			(print "Camino 3")
			(set 'f1 (first e1))
			(set 't1 (rest e1))

			(set 'f2 (first e2))
			(set 't2 (rest e2))

			(set 'z1 (unificar f1 f2 unificador))
			(setf unificador (append unificador (list z1)))
			
			(set 'g1 (aplicar z1 t1))
			(set 'g2 (aplicar z1 t2))

			(set 'z2 (unificar g1 g2 unificador))
			;(when (not (member z2 unificador)) (setf unificador (append unificador (list z2))))
			;(setf unificador (append unificador (list '(a b))))
		)

	)
)


(defun unif(e1 e2)
	(cond
		((esvariable e1) 
			(if (and (not(atom e2)) (member (extraerSimbolo e1) e2)) NIL) (list e2 e1))
		((esvariable e2) (list e1 e2))
		(T (print "Los dos son atomos") NIL)
	)
)


(defun aplicar (sustitucion lista)
	(when (eq lista '(*)) lista)
	(if (eq lista '())
	()
	(cons (sustituir (first sustitucion) (first (rest sustitucion)) (first lista))
		(poner (first sustitucion) (first (rest sustitucion)) (rest lista))))
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


(defun esvariable (algo)
	(cond 
		((atom algo) NIL)
		((eq '? (first algo)) T)
	)
)
(defun extraerSimbolo(simbolo)
	(first (rest simbolo))
)