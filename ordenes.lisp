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
