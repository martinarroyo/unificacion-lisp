
 (defun atomo(v)
 	(cond ((atom v) T)
 		  ((eq (first v) '?) T)
 		  (T NIL)))       
   
(defun esvariable(var)
  (if (and(not(atom var))(eq (first var)'?)) T NIL))

(defun aparece(a l)
	(cond ((or (not l) (atom l))  NIL)
		  ((not(atom (first l))) (aparece  a (first l)))
		  ((and(atom (first l)) (eq a (first l))) T)
		  (T (aparece a (rest l)))))

(defun iguales (e1 e2)
  (cond ((and (atom e1) (atom e2) (eq e1 e2)) T)
        ((and (esvariable e1) (esvariable e2) (eq(first(rest e1)) (first(rest e2)))) T)
        (T NIL)))

(defun unificarAtomo(e1 e2)
  (cond ((eq e1 e2) '())
        ((and (esvariable e1) (not(aparece (first (reverse e1)) e2))) (list e2 e1))
        ((esvariable e2) (list e1 e2))
        (T '%)))
          
 (defun aplicar(l1 l2) ;aplicar l1 a l2
   (set 'lis l2)
   (cond ((not(or l1 l2))NIL) 
   		 ((atomo (first (reverse l1))) (set 'lis (sustituir l1 lis)))
  		 ((not (atomo (first(reverse l1)))) (set 'lis (sustituir (first l1) lis)) (aplicar (rest l1) lis))))
  	
(defun sustituir(a lista)
  (cond ((not(or a lista))NIL)
  	    ((and (atomo lista) (iguales lista (first (rest a)))) (first a))
  		((atomo lista) lista)	
  		((and (atomo (first lista)) (esvariable (first lista)) (iguales (first (rest a)) (first lista))) (cons (first a) (sustituir a (rest lista))))
  		((atomo (first lista)) (cons (first lista) (sustituir a (rest lista))))
  		(T (cons (sustituir a (first lista)) (sustituir a (rest lista))))))

(defun unificarNoAtomo(e1 e2)
  (set 'f1 (first e1))
  (set 't1 (rest e1))
  (set 'f2 (first e2))
  (set 't2 (rest e2))
  (set 'z1 (unificacion f1 f2))
  (cond ((eq z1 '%) '%)
  		(T(unificarNoAtomo2 t1 t2 z1))))
  
  
(defun unificarNoAtomo2(t1 t2 z1)
  (set 'g1 (aplicar z1 t1))
  (set 'g2 (aplicar z1 t2))
  (set 'z2 (unificacion g1 g2))
  (cond  ((eq z2 '%) '%) 
  	     ((not(eq z1 '%))(unificarNoAtomo3 z1 z2))))
  
(defun unificarNoAtomo3(v1 v2)
 (set 'x v1)
 (set 'y v2)
  (set 's1 (componer1 v1 v2))
  (set 's2 (componer1 v2 v1))
  (set 'z3 (componer2 s1 s2)))
              
(defun unificacion(e1 e2)
  (set 'fl '&)
  (cond ((and(atomo e1) (not(eq fl '%))) (set 'fl (unificarAtomo e1 e2)))
        ((and(atomo e2) (not(eq fl '%))) (set 'fl (unificarAtomo e2 e1)))
        ((not(eq fl '%))(set 'fl (unificarNoAtomo e1 e2)))
        (T "FALLO")))

        
	
(defun componer1(z1 z2)
   (cond ((not z1) NIL)
   	     ((not z2) z1)
  		 ((atomo (first(reverse z1))) (cons (aplicar z2 (first z1)) (rest z1)))
  		 (T (cons (componer1 (first z1) z2) (componer1 (rest z1) z2)))))
  		 
(defun componer2(l1 l2)
	(set 'lis l1)
	(cond ((not(or lis l2)) NIL)
		  ((not l1) l2)
		  ((not l2) l1)
		  ((and(atomo (first(reverse lis))) (atomo (first(reverse l2))) (not(iguales (first(reverse lis)) (first(reverse l2)))))(set 'lis (append (list lis) (list l2))))
		  ((and(atomo (first(reverse lis))) (atomo (first(reverse l2))) (iguales (first(reverse lis)) (first(reverse l2)))) lis)
		  ((and(atomo (first(reverse l2))) (comprobarRepetidos lis l2)) (set 'lis (append lis (list l2))))
		  ((and(atomo (first(reverse lis)))(comprobarRepetidos l2 lis)) (set 'lis (append (list lis) l2))) 
		  ((and(atomo (first(reverse lis)))(not(comprobarRepetidos l2 lis)))l2)
		  ((comprobarRepetidos lis (first l2)) (componer2 lis (rest l2)) (set 'lis (append lis (list (first l2)))))
		  (T (componer2 lis (rest l2)))))

(defun comprobarRepetidos(l1 l2)
	(cond 	((not l1) T)
			((and(atomo (first (reverse l1))) (iguales (first(reverse l1)) (first(reverse l2))))NIL)
			((and(atomo (first (reverse l1))) (not(iguales (first(reverse l1)) (first(reverse l2)))))T)
			((iguales (first(reverse (first l1))) (first(reverse l2))) NIL) 
			(T (comprobarRepetidos (rest l1) l2))))

;(load "/Users/juanalberto/Desktop/unificacion.lsp") 
;(aplicar '((a (? x)) (b (? y)) (c (? z))) '(P a (f(? x) (? y))))
;(first (rest (rest '(p a (f (? x) (? y))))))
;(((g (? x) (? y))(? z))(e (? w)))	
;(composicion '(((g (? x) (? y)) (? z)) (e (? w))) '((a (? x)) (b (? y))(c (? z)))) 	
;(composicion '((? y)(? z)) '((a (? x)) (b (? y)))) 
;(componer2 '((a (? x)) (b (? y))) '((c (? x)) (d (? z))))
;(componer2 '() '(a (? x)))
;(((G A B) (? Z)) (E (? W)) (A (? X)) (B (? Y)))
; (delete '(a (? x)) '((b (? w)) (a (? x)) (c (? y))))
;(append (list '(a (? x)))  (list '(c (? z))))
;(first(rest '((c (? z)) (d (? w)))))
; (componer1 '((g (? x) (? y))(? z)) '(a (? x)))
;(unificacion '((m (? x) r) (cl (? x) a)) '((m me r) (m l r) (m c5 ci) (cl me ro) (cl l a) (cl c5 a)))
;(unificacion '(p (? x) (h (? y))) '(p j (? z))) Funciona
;(unificacion '(p a (f (? x) b) (? y)) '(p (? x) (f (g (? y)) (? z)) (? w))) No funciona
;(unificacion '(p a (? x) (h (g (? z)))) '(p (? z) (h (? y)) (h (? y)))) Mehr oder weniger
;(unificarnoatomo '(p a (? x) (h (g (? z)))) '(p (? z) (h (? y))(h (? y))))
;(componer1 '(((h (? y))(? x)) ((g b) (? y))) '(b (? z)))
;(componer1 '((h (? y))(? x)) '((g a) (? y)))
;(unificacion '(p a (? x)) '(p (? x) (? y))) Mehr oder weniger
	
