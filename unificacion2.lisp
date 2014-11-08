(defun unificar(e1 e2)
	(print "Argumentos")
	(print "e1") (print e1)
	(print "e2") (print e2)
	;(break)
	(cond 
		((atom e1) (print "Camino 1: e1 es atomo") (unifAtomo e2 e1)) 
		((atom e2) (print "Camino 2: e2 es atomo") (unifAtomo e1 e2))
		(T (print "Camino 3: e1 y e2 son listas") (unificarListas e1 e2))
	)
)

(defun unificarListas(e1 e2)
	(set 'f1 (first e1))
	(print "f1") (print f1) 
	(set 't1 (rest e1))
	;como rest devuelve una lista, comprobamos si t1 es un átomo en una lista 
	;si lo es, lo sacamos
	(set 'aux (rest t1))
	(when (eq aux NIL) (set 't1 (first t1)))
	(print "t1") (print t1)

	(set 'f2 (first e2))
	(print "f2") (print f2)
	(set 't2 (rest e2))
	;como rest devuelve una lista, comprobamos si t2 es un átomo en una lista 
	;si lo es, lo sacamos
	(set 'aux (rest t2))
	(when (eq aux NIL) (set 't2 (first t2)))
	(print "t2") (print t2)

	(set 'z1 (unificar f1 f2))
)





(defun unifAtomo(e1 e2)
	(break)
	(cond 
		((equal e1 e2) '(*))
		((esvariable e1) (if (member (extraersimbolo e1) e2) NIL (list (extraersimbolo e2) (extraersimbolo e1))))
		((esvariable e2) (list (extraersimbolo e1) (extraersimbolo e2)))
		(T NIL)
	)
)

(defun extraerSimbolo(simbolo)
	(if (esvariable simbolo) 
		(first (rest simbolo)))
		simbolo
)

(defun esnada (simbolo)
	(and (eq '* (first simbolo)) (eq (length simbolo) 1))
)

(defun esvariable (algo)
	(eq '? (first algo))
)

