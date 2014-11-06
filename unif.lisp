(defun unificar (e1 e2)
(cond
((atom e1) (unif e1 e2))
((atom e2) (unif e2 e1))
(T (unificarListas e1 e2))))


"
En la llamada del algoritmo hay que indicar las variables dentro de una lista
por ejemplo
(* a)
el asterisco (podría ser una patata) indica que es una variable
"


(defun esvariable (algo)
(eq '? (first algo)))

(defun unif(e1 e2)
	(when (eq e1 e2) '(*))
	(when (esvariable e1) 
		(when (member (first (rest e1)) e2) NIL)



		
		'(e2 e1)
		)
	(when (esvariable e2) '(e1 e2))
	NIL
	)


(defun unif(e1 e2)
	(cond 
		((eq e1 e2) '(*))
		((esvariable e1) (if (member (first (rest e1)) e2) NIL '(e2 e1)))
		((esvariable e2) '(e1 e2))
		(T NIL)
	)
)

(defun unif(e1 e2)
	(cond 
		((eq e1 e2) NIL)
		((esvariable e1) (when (member e1 e2) NIL) '(e2 e1))
		((esvariable e2) '(e1 e2))
		(T NIL)
	)
)


(defun print-elements-of-list (list)
       (while list
         (print (car list))
         (setq list (cdr list)))
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

(defun aplicar (sustitucion lista)
(if (eq lista '())
()
(cons (sustituir (first sustitucion) (first (rest sustitucion)) (first lista))(poner (first sustitucion) (first (rest sustitucion)) (rest lista))))
)


     
     
