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

(format t "~%Probando unificacion~%~%")

(probar (list 'unificacion '(P a) '(P (? b)) '((A (? B)))))
(probar (list 'unificacion '(P (? x) B) '(P A (? y)) '((A (? X)) (B (? Y)))))
(probar (list 'unificacion '((? x) B) '(A (? y)) 'NO-UNIFICABLE))
(probar (list 'unificacion '((? x) B (? x) A) '(A (? y) (? x) A) 'NO-UNIFICABLE))
(probar (list 'unificacion '(P M (? x) B) '(P M  A (? y)) '((A (? X)) (B (? Y)))))
(probar (list 'unificacion '(P (? x) B (? c)) '(P A (? y) (f A)) '((A (? X)) (B (? Y)) ((F A) (? C))))) ;TODO
(probar (list 'unificacion '(P (? x) B (? c)) '(P A (? y) (f A B)) '((A (? X)) (B (? Y)) ((F A B) (? C))))) ;TODO

(format t "~%Probando esvariable~%~%")

(format t "esvariable retorna ~s para ~s~%" (esvariable '(? X)) '(? X))
(format t "esvariable retorna ~s para ~s~%" (esvariable 'A) 'A)
(format t "esvariable retorna ~s para ~s~%" (esvariable '(f X)) '(f X))
(format t "esvariable retorna ~s para ~s~%" (esvariable '(X)) '(X))

(format t "~%~%Probando extraersimbolo~%~%")
;TODO: ¿Retornar error en caso de que no sea una variable/átomo?
(format t "~%extraersimbolo retorna ~s para ~s~%" (extraersimbolo '(? X)) '(? X))
(format t "~%extraersimbolo retorna ~s para ~s~%" (extraersimbolo '(X)) '(X))
(format t "~%extraersimbolo retorna ~s para ~s~%" (extraersimbolo 'A) 'A)
(format t "~%extraersimbolo retorna ~s para ~s~%" (extraersimbolo '(f X)) '(f X))

(format t "~%~%Probando hacer-sustitucion~%~%")

(format t "~%hacer-sustitucion retorna ~s para ~s sobre ~s" (hacer-sustitucion '((? X) A) '(A)) '((? X) A) '((A)))

;Funciones que faltan por probar
;hacer-sustitucion(expresion lista)
;sustituir
;annadir

(format t "~%~%~%~%~%~%~%~%~%")