(defparameter debug T) ;Parametros de depuracion

(defun unificarEntrada(e1 e2)
	(let ((unificador nil))
		(if (eql (first e1) (first e2)) 
			(catch 'unificarException (unificar (rest e1) (rest e2) unificador))
			'no-unificable
		)
	)
)

(defun unificar(e1 e2 unificador)
	(cond 
		((eq e1 e2) unificador)
		((or (null e1) (null e2)) (throw 'unificarException 'no-unificable))
		((or (atom e1) (esvariable e1)) (when (eq debug T) (print "Camino 1: e1 es atomo o variable"))  (unif e1 e2)) 
		((or (atom e2) (esvariable e2)) (when (eq debug T) (print "Camino 2: e2 es atomo o variable"))  (unif e2 e1))
		((or (atom e1) (atom e2)) (throw 'unificarException 'no-unificable))
		(T 
			(when (eq debug T) (print "Camino 3: Son listas")) 
			(set 'f1 (first e1))
			(set 't1 (rest e1))

			(set 'f2 (first e2))
			(set 't2 (rest e2))

			(set 'z1 (unificar f1 f2 unificador))
			(cond 
				((miembro-unificador z1 unificador) unificador)
				(T (setf unificador (append unificador (list z1))))
			)
			(set 'g1 (aplicar z1 t1))
			(set 'g2 (aplicar z1 t2))

			(set 'z2 (unificar g1 g2 unificador))
		)

	)
)

(defun miembro-unificador(miembro unificador)
	;Indica si un unificador ya se encuentra dentro de la lista o no
	(cond 
		((equal miembro (first unificador)) T)
		((eq (rest unificador) '()) NIL)
		(T (miembro-unificador miembro (rest unificador)))
	)
)

(defun unif(e1 e2)
	(cond
		((esvariable e1) 
			(if (and (not(atom e2)) (member (extraerSimbolo e1) e2)) (throw 'unificarException 'no-unificable)) (list e2 e1))
		((esvariable e2) (list e1 e2))
		(T 
			(when (eq debug T) (print "Los dos son atomos"))  
			(throw 'unificarException 'no-unificable))
	)
)

(defun aplicarUnificador (unificador lista)
	(setf regla (first unificador))

	(cond
		((null unificador) lista)
		(T 	(aplicarUnificador (rest unificador) (aplicar regla lista)))
	)
)


(defun aplicar (sustitucion lista)
	(if (eq lista '())
	()
	(cons (sustituir (first sustitucion) (second sustitucion) (first lista))
		(poner (first sustitucion) (second sustitucion) (rest lista))))
)

(defun sustituir (b a elem)
	(if (eq elem a)
	b
	elem)
)

(defun poner (a b lista)
(if (eq lista '())
()
(cons (sustituir a b (first lista))(poner a b (rest lista))))
)


(defun esFuncion(algo)
	(cond 
		((atom algo) NIL)
		((esvariable algo) NIL)
		((and (listp algo) (> (list-length algo) 1)) T) ;completar
		(T NIL)
	)

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

(defparameter *literal1* '(P x))
(defparameter *literal2* '(P (? a)))
(defparameter *literal3* '(P (? x) B))
(defparameter *literal4* '(P A (? y)))
(defparameter *literal5* '(P (? x) B (? c)))
(defparameter *literal6* '(P y (? A) d))



(defparameter *literal7* 'a)
(defparameter *literal8* 'b)
(defparameter *literal9* '(? b))
(defparameter *literal10* '(? a))


;;; Here's a function for demonstrating UNIFY.
(defun show-unification (lit1 lit2)
  "Prints out both inputs and output from UNIFY."
  (format t "~%El resultado de  UNIFICAR on ~s and ~s is ~s."
          lit1 lit2 (unificarEntrada lit1 lit2) ) )

(defun test ()
  "Calls UNIFY with sample arguments."
  (show-unification *literal1* *literal2*)
  (show-unification *literal3* *literal4*)
  (show-unification *literal5* *literal6*)
)
  ;(show-unification *literal7* *literal8*)
  
  ;(let ((u (unify *literal7* *literal8*)))
  ;  (format t "~%Result of applying U to ~s is ~s."
  ;          *literal7* (do-subst *literal7* u) )
  ;  (format t "~%Result of applying U to ~s is ~s."
  ;          *literal8* (do-subst *literal8* u) )
  ;) )
