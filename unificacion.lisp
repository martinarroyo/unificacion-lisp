;Parametros de depuracion. Fijandolo a T se muestran mensajes de depuracion en el codigo
(defparameter debug NIL)

(defun unificacion(e1 e2)
  ; Let crea una serie de variables a las cuales se les da un valor inicial
  ; y se define un conjunto de operaciones sobre ellas. En este caso, invocar un algoritmo
  ; de unificacion cuyo resultado sera almacenado en la variable u definida.
  (let ((u nil))
    ; El primer elemento de cada lista debe ser identico, dado que es el nombre del predicado
    (if (eql (first e1) (first e2)) 
      ; Si son iguales, procedemos a unificar, capturando la excepcion que indica que no es unificable el algoritmo
      (catch 'unificarException (reverse (unificar (rest e1) (rest e2) u)))
      'no-unificable ;Lanzamos la excepcion no-unificable si son diferentes los nombres de las funciones
    )
  )
)

;Incluye una pareja de elementos en el unificador, verificando las reglas necesarias
(defun anadir(e1 e2 u)
   (cond
      ((esvariable e1) ; Si e1 es variable, se annade el par e2/e1
        (if (and (not(atom e2)) (member (extraerSimbolo e1) e2)) ; Si e1 aparece en e2, no es unificable. En caso contrario, annadimos el par
          (throw 'unificarException 'no-unificable))
        (cons (list e2 e1) (sustituir e2 e1 u)))
      
      ; Si e2 es variable, se annade el par e1/e2
      ((esvariable e2) (cons (list e1 e2)(sustituir e1 e2 u)))
      ;Si ninguna de las dos condiciones se ha satisfecho, ambos son atomos, y por lo tanto, no son unificables
      (T 
        (when (eq debug T) (print "Los dos son atomos"))  
        (throw 'unificarException 'no-unificable))
    )
  )

;Realiza la sustitucion de una expresion dada sobre una lista, en orden inverso
(defun hacer-sustitucion(expresion lista)
  (cond 
    ((null lista) expresion) ;Fin de la recursividad
    (t (sustituir (first (first lista)) (second (first lista))
        (hacer-sustitucion expresion (rest lista))))
  )
)


(defun unificar(e1 e2 u)
  (cond 
    ; Si son iguales, el unificador no se altera
    ((eq e1 e2) u) 
    ((eq (extraersimbolo e1) (extraersimbolo e2)) u)
    ; Si una de las listas esta vacia y la otra no, significa que tienen diferente longitud, por lo tanto, no son unificables
    ((or (null e1) (null e2)) (throw 'unificarException 'no-unificable))  ; Si e1 es variable o atomo, consideramos el par e2/e1
    ((or (atom e1) (esvariable e1)) (when (eq debug T) (print "Camino 1: e1 es atomo o variable"))  (anadir e1 e2 u)) 
    ; Si e2 es variable o atomo, consideramos el par e1/e2
    ((or (atom e2) (esvariable e2)) (when (eq debug T) (print "Camino 2: e2 es atomo o variable"))  (anadir e2 e1 u))
    ; Si ambos son atomos, no es unificable
    ((or (atom e1) (atom e2)) (throw 'unificarException 'no-unificable))
    
    ;En el caso de que no sean variables o atomos aun, llamamos a la funcion recursiva
    (t 
      (when (eq debug T) (print "Camino 3: ninguno de los dos es atomo o variable"))
      ; Primera fase de la unificacion
      (setf f1 (first e1))
      (setf t1 (rest e1))

      (setf f2 (first e2))
      (setf t2 (rest e2))
      (setf u (unificar (hacer-sustitucion f1 u)
                         (hacer-sustitucion f2 u)

                u))
    ; Segunda fase de la unificacion
    (unificar t1 t2 u)
    
    )
  )
)

;Indica si un elemento es de tipo variable (? <simbolo>)
(defun esvariable (algo)
  (cond 
    ((atom algo) NIL)
    ((eq '? (first algo)) T)
  )
)

; Abstrae la comparacion de simbolos, evaluando si es una variable o una constante
; y extrayendo el simbolo en funcion del tipo, permitiendo realizar comparaciones
; de atomo-atomo o variable-variable en la misma sentencia
(defun extraerSimbolo(simbolo)
  (if (esvariable simbolo)

    (first (rest simbolo))
    simbolo
  )
)

;Sustituye por a todas las ocurrencias de b en lista
(defun sustituir(a b lista)
  (cond
    ; Fin de la recursividad
    ((null lista) nil)
    ; Si el simbolo de la lista es igual a b, retornamos a
    ((eq (extraersimbolo lista) (extraersimbolo b)) a)
    ; Si estamos trabajando con una variable o atomo y no es igual a b, retornamos la lista.
    ((or (atom lista) (esvariable lista)) lista)
    ; Si el simbolo b es igual al primer elemento de la lista
    ; creamos una nueva lista con la nueva regla y llamamos a la recursividad
    ((eq (extraersimbolo b) (extraersimbolo (first lista)))
      (cons a (sustituir a b (rest lista))))
    ; Si es atomo o variable y no ha superado la anterior prueba,
    ; creamos una lista con el primer elemento y el resultado de la llamada recursiva
    ((or (atom (first lista)) (esvariable (first lista)))
      (cons (first lista) (sustituir a b (rest lista))))
    ; Si no se cumple ninguna de las anteriores condiciones
    ; creamos una lista con la sustitucion del primer valor y el del resto de la lista
    (t (cons (sustituir a b (first lista))
             (sustituir a b (rest lista))))
  )
)
