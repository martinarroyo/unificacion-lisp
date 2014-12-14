;;Ordenes.lisp

;(unificar 'a 'b) ;2 átomos
;(unificar '(a) 'b) ;lista + átomo
;(unificar '(? a) 'b )
;(unificar 'a '(? b))
;(unificar 'b '(? a))
;(unificar '((? x) B) '(A (? y)))
;(unificar '((? x) B (? x) A) '(A (? y) (? x) A))

;(unificar '(P M (? x) B) '(P M  A (? y)))

;(aplicar '(a b) '(a b))

;(\(print ["A-Za-z\: 0-9]+\)) ;Capturar todos los print
;(when (eq debug T) $1)  ; Reemplazar

;Añadir a test. Son todas las pruebas posibles de esFuncion
;[31]> (esFuncion '(? x))
;NIL
;[32]> (esFuncion '(p x))
;T
;[33]> (esFuncion '(x))
;NIL
;[34]> (esFuncion '(x ?))
;T
;[35]> (esFuncion '())
;NIL
;[36]> (esFuncion 'a)
;NIL
;[37]> 


;[48]> (sustituir 'A '(? X) '(f (? x)))
;(F (? X))
;[49]> (sustituir 'A '(? X) '(f a))
;(F (? X))


;[60]> (unificarentrada '(P (? x) B (? c)) '(P A (? y) (f A)))
;((A (? X)) (B (? Y)) ((F (? X)) (? C)))
;[61]> (unificarentrada '(P (? x) B (? c)) '(P A (? y) (f A B)))
;((A (? X)) (B (? Y)) ((F (? X) (? Y)) (? C)))
;[62]> 

(load "unificacion.lisp")

(setf datos (list 'unificacion '(P a) '(P (? b)) '((A (? B)))))

(defun testeo (datos)
	(compararResultados (funcall (first datos) (second datos) (third datos)) (fourth datos))
)

(defun compararResultados (resultado expected)
	(cond 
		((eq resultado 'NO-UNIFICABLE) (if (eq expected 'NO-UNIFICABLE) T nil))
		((and (eq resultado nil) (eq expected nil)) T)
		((or (eq resultado nil) (eq expected nil)) nil)
		(T
			(and (compararElemento (first resultado) (first expected)) (compararResultados (rest resultado) (rest expected))))
	)
)

(defun compararElemento (e1 e2)
	(and (eq (first (extraerSimbolo e1)) (first (extraerSimbolo e2))) 
		(eq (extraersimbolo (second e1)) (extraersimbolo (second e2)))
	)
)

(defun probar(datos)
	(setf resultado (funcall (first datos) (second datos) (third datos)))
	
	(if (compararResultados resultado (fourth datos))
		(format t "La funcion ~s con los argumentos ~s y ~s retorna ~s. Se esperaba ~s~%Test superado~%" 
			(first datos) (second datos) (third datos) resultado (fourth datos)
		)
		(format t "La funcion ~s con los argumentos ~s y ~s retorna ~s. Se esperaba ~s~%Test no superado~%" 
			(first datos) (second datos) (third datos) resultado (fourth datos)
		)
	)
)

(format t "~%~%~%~%Pruebas en LISP~%~%~%~%~%")

(probar (list 'unificacion '(P a) '(P (? b)) '((A (? B)))))
(probar (list 'unificacion '(P (? x) B) '(P A (? y)) '((A (? X)) (B (? Y)))))
(probar (list 'unificacion '((? x) B) '(A (? y)) 'NO-UNIFICABLE))

;hacer-sustitucion(expresion lista)
;esvariable
;extraersimbolo
;sustituir
;annadir




(format t "~%~%~%~%~%~%~%~%~%")

