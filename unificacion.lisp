(defparameter debug NIL) ;Parametros de depuracion


(defun unificacion(e1 e2)
  (let ((u nil))
    (if (eql (first e1) (first e2)) 
      (catch 'unificarException (reverse (unificar (rest e1) (rest e2) u)))
      'no-unificable
    )
  )


)


(defun anadir(e1 e2 u)
   (cond
      ((esvariable e1) 
        (if (and (not(atom e2)) (member (extraerSimbolo e1) e2)) (throw 'unificarException 'no-unificable)) (cons (list e2 e1) (sustituir e2 e1 u)))
      ((esvariable e2) (cons (list e1 e2)(sustituir e1 e2 u)))
      (T 
        (when (eq debug T) (print "Los dos son atomos"))  
        (throw 'unificarException 'no-unificable))
    )
  )

(defun hacer-sustitucion(expresion lista)
  (cond 
    ((null lista) expresion)
    (t (sustituir (first (first lista)) (second (first lista))
        (hacer-sustitucion expresion (rest lista))))
  )
)


(defun unificar(e1 e2 u)
  (cond 
    ((eq e1 e2) u)
    ((or (null e1) (null e2)) (throw 'unificarException 'no-unificable))
    ((or (atom e1) (esvariable e1)) (when (eq debug T) (print "Camino 1: e1 es atomo o variable"))  (anadir e1 e2 u)) 
    ((or (atom e2) (esvariable e2)) (when (eq debug T) (print "Camino 2: e2 es atomo o variable"))  (anadir e2 e1 u))
    ((or (atom e1) (atom e2)) (throw 'unificarException 'no-unificable))
    
    (T (setf u (unificar (hacer-sustitucion (first e1) u)
                         (hacer-sustitucion (first e2) u)

                u))

    (unificar (rest e1) (rest e2) u)
    )
  )
)


(defun esvariable (algo)
  (cond 
    ((atom algo) NIL)
    ((eq '? (first algo)) T)
  )
)

(defun extraerSimbolo(simbolo)
  (if (esvariable simbolo)

    (first (rest simbolo))
    simbolo
  )
)

(defun sustituir(a b lista)
  (cond
    ((null lista) nil)
    ((eq (extraersimbolo lista) (extraersimbolo b)) a)
    ((or (atom lista) (esvariable lista)) lista)
    ((eq (extraersimbolo b) (extraersimbolo (first lista)))
      (cons a (sustituir a b (rest lista))))
    ((or (atom (first lista)) (esvariable (first lista)))
      (cons (first lista) (sustituir a b (rest lista))))
    (t (cons (sustituir a b (first lista))
             (sustituir a b (rest lista))))
  )
)
