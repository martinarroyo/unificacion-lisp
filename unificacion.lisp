(defun unificar (e1 e2)
(cond
(((not (esvariable e1)) and (atom (first e1))) (unif e1 e2))
(((not (esvariable e2)) and (atom (first e2))) (unif e2 e1))
(T 1)
)
)


(defun unificar (e1 e2)
	(cond 
		((and (not (esvariable e1)) (atom (first e1))) (unif e1 e2))
		((and (not (esvariable e2)) (atom (first e2))) (unif e2 e1))
		(T 1)
	)
)

(defun extraerSimbolo(simbolo)
	(if (esvariable simbolo) 
		(first (rest simbolo))
		(first simbolo)
	)
)

(defun esnada (simbolo)
	(and (eq '* (first simbolo)) (eq (length simbolo) 1))
)

(defun esatomo(algo)
	(not (eq '? (first algo)))
)





(T (unificarListas e1 e2))))


(defun esvariable (algo)
(eq '? (first algo)))

(defun unif(e1 e2)
	(cond 
		((eq e1 e2) '(*))
		((esvariable e1) (if (member (first (rest e1)) e2) NIL '(e2 e1)))
		((esvariable e2) '(e1 e2))
		(T NIL)
	)
)

(defun unificarListas (e1 e2)
	(defparameter f1 (first e1))
	(defparameter t1 (rest e1))
	(defparameter f2 (first e2))
	(defparameter t2 (rest e2))
	(defparameter z1 (unificar e1 e2))
	(when (eq z1 NIL) NIL)

	(defparameter g1 (aplicar z1 t1))
	(defparameter g2 (aplicar z2 t2))
	(defparameter z2 (unificar e1 e2))
	(when (eq z2 NIL) NIL)
	"retornar la composición de z1 y z2"
	
	T
)

(defun sustituir (a b elem)
(if (eq elem a)
b
elem))

(defun poner (a b lista)
(if (eq lista '())
()
(cons (sustituir a b (first lista))(poner a b (rest lista))))
)

; ejemplo de uso: (poner 'a 'b '(a b c))

(defun aplicarRecursivo(sustitucion lista)
	(if (eq lista '())

	)
)

(defun aplicar (sustitucion lista)
(when (eq lista '(*)) lista)
(if (eq lista '())
()
(cons (sustituir (first sustitucion) (first (rest sustitucion)) (first lista))(poner (first sustitucion) (first (rest sustitucion)) (rest lista))))
)



"(defun unificar (e1 e2)
(cond
((atom e1) (unif e1 e2))
((atom e2) (unif e2 e1))
(T (unificarListas e1 e2))))"




(defun unificar(e1 e2)
	(cond 
		((esatomo e1) (unif e2 e1)) 
		((esatomo e2) (unif e1 e2))
		(T (unificarListas e1 e2))
	)
)

(defun unif(e1 e2)
	(cond 
		((equal e1 e2) '(*))
		((esvariable e1) (if (member (first (rest e1)) e2) NIL '(e2 e1)))
		((esvariable e2) '('e1 'e2))
	)
)

(defun unificarListas(e1 e2)
	(defparameter f1 (first e1))
	(defparameter t1 (rest e1))

	(defparameter f2 (first e2))
	(defparameter t2 (rest e2))

	(defparameter z1 (unificar e1 e2))
	(when (eq z1 NIL) NIL)
	(defparameter g1 (aplicar z1 t1))
	(defparameter g2 (aplicar z2 t2))
	(when (eq z2 NIL) NIL)
	(list z1 z2)
)




"(defun unificarListas (e1 e2)
	(defparameter f1 (first e1))
	(defparameter t1 (rest e1))
	(defparameter f2 (first e2))
	(defparameter t2 (rest e2))
	(defparameter z1 (unificar e1 e2))
	(when (eq z1 NIL) NIL)

	(defparameter g1 (aplicar z1 t1))
	(defparameter g2 (aplicar z2 t2))
	(defparameter z2 (unificar e1 e2))
	(when (eq z2 NIL) NIL)
	T
)"
