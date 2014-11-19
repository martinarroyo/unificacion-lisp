(unificar '((P) (? x) (B)) '((P) (A) (? y)))
(unificar '((P) (? x) (B))'((Q) (? z)))

(set e1 '((P) (? x) (B)))
(set f1'(first(e1)))


(unificar '(P (? x) B) '(P A (? y))) ;2 listas
(unificar '(P (? x) B) '(P (? y) A))
(unificar 'a 'b) ;2 átomos
(unificar '(a) 'b) ;lista + átomo
(unificar '(? a) 'b )
(unificar 'a '(? b))
(unificar 'b '(? a))
(unificar '((? x) B) '(A (? y)))
(unificar '((? x) B (? x) A) '(A (? y) (? x) A))

(unificar '(P M (? x) B) '(P M  A (? y)))

(aplicar '(a b) '(a b))

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
