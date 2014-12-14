(defparameter debug NIL) ;Parametros de depuracion



(defun unificacion(e1 e2)
  (let ((unificador nil))
    (if (eql (first e1) (first e2)) 
      (catch 'unificarException (unificar (rest e1) (rest e2) unificador))
      'no-unificable
    )
  )
)

(defun unif(e1 e2)
  (cond
    ((esvariable e1) 
      (if (and (not(atom e2)) (member (extraerSimbolo e1) e2)) (throw 'unificarException 'no-unificable)) (list e2 e1))
    ((esvariable e2) (list e1 e2))
    (T 
      (when (eq debug T) (print "Los dos son atomos"))  
      (throw 'unificarException 'no-unificable))
  )
)

(defun anadir(e1 e2 u)
   (cond
      ((esvariable e1) 
        (if (and (not(atom e2)) (member (extraerSimbolo e1) e2)) (throw 'unificarException 'no-unificable)) (cons (list e2 e1) (sustituir e2 e1 u)))
      ((esvariable e2) (cons (list e1 e2)(sustituir e1 e2 u))
      (T 
        (when (eq debug T) (print "Los dos son atomos"))  
        (throw 'unificarException 'no-unificable))
    )
  )
)


;;; DO-SUBST performs all substitutions in L on EXP in
;;; reverse order.
(defun do-subst (exp l)
  "Applies the substitutions of L to EXP."
  (cond ((null l) exp)
        (t (subst1 (first (first l))
                   (second (first l))
                   (do-subst exp (rest l)) )) ) )

(defun hacer-sustitucion(expresion lista)
  (cond 
    ((null lista) expresion)
    (t (sustitucion (first (first lista)) (second (first lista)))
        (hacer-sustitucion expresion (rest lista)))
  )
)


(defun unificar(e1 e2 unificador)
  (cond 
    ((eq e1 e2) unificador)
    ((or (null e1) (null e2)) (throw 'unificarException 'no-unificable))
    ((or (atom e1) (esvariable e1)) (when (eq debug T) (print "Camino 1: e1 es atomo o variable"))  (anadir e1 e2)) 
    ((or (atom e2) (esvariable e2)) (when (eq debug T) (print "Camino 2: e2 es atomo o variable"))  (anadir e2 e1))
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



(defun miembro-unificador(miembro unificador)
  ;Indica si un unificador ya se encuentra dentro de la lista o no
  (cond 
    ((equal miembro (first unificador)) T)
    ((eq (rest unificador) '()) NIL)
    (T (miembro-unificador miembro (rest unificador)))
  )
)

(defun unif(e1 e2)
  (cond
    ((esvariable e1) 
      (if (and (not(atom e2)) (member (extraerSimbolo e1) e2)) (throw 'unificarException 'no-unificable)) (list e2 e1))
    ((esvariable e2) (list e1 e2))
    (T 
      (when (eq debug T) (print "Los dos son atomos"))  
      (throw 'unificarException 'no-unificable))
  )
)

(defun aplicarUnificador (unificador lista)
  (setf regla (first unificador))

  (cond
    ((null unificador) lista)
    (T  (aplicarUnificador (rest unificador) (aplicar (first unificador) lista)))
  )
)

(defun aplicar(sustitucion lista)
  (if (eq lista '())
  ()
  (cons (sustituir (first sustitucion) (second sustitucion) (first lista))
    (poner (first sustitucion) (second sustitucion) (rest lista)))
  )
)

(defun aplicarOld (sustitucion lista)
  (if (eq lista '())
  ()
  (cons (sustituir (first sustitucion) (second sustitucion) (first lista))
    (poner (first sustitucion) (second sustitucion) (rest lista))))
)

(defun sustituir (a b elem)
  (cond
    ;((esFuncion (first elem)) (print "Es funcion") (cons (first elem) (sustituirFuncion a b (rest elem))))
    ;((esFuncion elem) (cons (first elem) (sustituirFuncion b a (rest elem))))  
    (T 
      (if (eq (extraerSimbolo (first (rest elem))) (extraersimbolo b))
      a;(cons a (list (second elem)))
      elem)
    )
  )
)

(defun sustituirFuncion(a b lista)
  (if (eq lista '())
  ()
  (cons (sustituir a b (first lista))(poner a b (rest lista))))
)

(defun poner (a b lista)
(if (eq lista '())
()
(cons (sustituir a b (first lista))(poner a b (rest lista))))
)


(defun esFuncion(algo)
  (cond 
    ((atom algo) NIL)
    ((esvariable algo) NIL)
    ((and (listp algo) (> (list-length algo) 1)) T) ;completar
    (T NIL)
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

(defparameter *literal1* '(P x))
(defparameter *literal2* '(P (? a)))
(defparameter *literal3* '(P (? x) B))
(defparameter *literal4* '(P A (? y)))
(defparameter *literal5* '(P (? x) B (? c)))
(defparameter *literal6* '(P y (? A) d))



(defparameter *literal7* 'a)
(defparameter *literal8* 'b)
(defparameter *literal9* '(? b))
(defparameter *literal10* '(? a))


;;; Here's a function for demonstrating UNIFY.
(defun show-unification (lit1 lit2)
  "Prints out both inputs and output from UNIFY."
  (format t "~%El resultado de  UNIFICAR on ~s and ~s is ~s."
          lit1 lit2 (unificarEntrada lit1 lit2) ) )

(defun test ()
  "Calls UNIFY with sample arguments."
  (show-unification *literal1* *literal2*)
  (show-unification *literal3* *literal4*)
  (show-unification *literal5* *literal6*)
)






;;; UNIFY.CL
;;; A Unification algorithm for literals in the Predicate Calculus,
;;; implemented in Common Lisp.

;;; (C) Copyright 1995 by Steven L. Tanimoto.
;;; This program is described in Chapter 6 ("Logical Reasoning") of
;;; "The Elements of Artificial Intelligence Using Common Lisp," 2nd ed.,
;;; published by W. H. Freeman, 41 Madison Ave., New York, NY 10010.
;;; Permission is granted for noncommercial use and modification of
;;; this program, provided that this copyright notice is retained
;;; and followed by a notice of any modifications made to the program.

;;; Note: This function UNIFY does indeed perform the "occurs check"
;;; required by the strict definition of unification.

;;; UNIFY is the top-level function.
(defun unify (literal1 literal2)
  "Returns a most-general unifier for LITERAL1 and
   LITERAL2 if one exists.  Otherwise returns the
   symbol NOT-UNIFIABLE."
  (let ((u nil))   ; unifier is initially null.
    ; make sure predicate symbols match:
    (if (eql (first literal1) (first literal2))
        (catch 'unify
          (unify1 (rest literal1) (rest literal2) u) )
       'not-unifiable) ) )

;;; ADD-PAIR adds a (term-variable) pair to the front of the
;;; substitution list, after substituting TERM for each
;;; occurrence of VAR in the terms of U.  The new list
;;; of substitutions is returned.
(defun add-pair (term variable u)
  "Trys to add the pair (TERM VARIABLE) to the list U and
   return the new list.  Otherwise throws NOT-UNIFIABLE."
  (cond ((occurs-in variable term)
         (throw 'unify 'not-unifiable) )
        (t (cons (list term variable) 
                 (subst1 term variable u) )) ) )

;;; The recursive function UNIFY1 unifies the two lists
;;; of terms, TERMLIST1 and TERMLIST2, and in the course
;;; of doing so adds more pairs onto the unifier U.
;;; TERMLIST1 and TERMLIST2 can also be individual terms
;;; or individual function symbols.
(defun unify1 (termlist1 termlist2 u)
  "Tries to unify the terms in TERMLIST1 with those in
   TERMLIST2 and thereby extend the list U of substitutions.
   If any failure occurs, throws NOT-UNIFIABLE."
  (cond
    ; If equal, no substitution necessary:
    ((equalp termlist1 termlist2) u)
    ; Check for list length mismatch (a syntax error):
    ((or (null termlist1) (null termlist2))
     (throw 'unify 'not-unifiable) )
    ; If TERMLIST1 is a variable, try to add a substitution:
    ((variablep termlist1) (add-pair termlist2 termlist1 u))
    ; Handle the case when TERMLIST2 is a variable similarly:
    ((variablep termlist2) (add-pair termlist1 termlist2 u))
    ; Now, if either expression is atomic, it is a
    ; constant and there's no match since they're not equal:
    ((or (atom termlist1) (atom termlist2))
     (throw 'unify 'not-unifiable) )
    ; The expressions must be non-atomic; do recursively.
    ; Apply current substitutions before unifying the first of each.
    (t (setf u (unify1 (do-subst (first termlist1) u)
                       (do-subst (first termlist2) u) 
                       u) )
       ; Now unify the rest of each.
       (unify1 (rest termlist1) (rest termlist2) u) )
       ) )

;;; DO-SUBST performs all substitutions in L on EXP in
;;; reverse order.
(defun do-subst (exp l)
  "Applies the substitutions of L to EXP."
  (cond ((null l) exp)
        (t (subst1 (first (first l))
                   (second (first l))
                   (do-subst exp (rest l)) )) ) )

(defun subst1 (a b lst)
  "Substitutes A for each occurrence of B in LST."
    (cond
       ((null lst) nil)
       ((eql lst b) a)
       ((atom lst) lst)
       ((eql b (first lst))
        (cons a (subst1 a b (rest lst))) )
       ((atom (first lst))
        (cons (first lst)(subst1 a b (rest lst))) )
       (t (cons (subst1 a b (first lst))
                (subst1 a b (rest lst)) )) ) )

(defun occurs-in (elt exp)
  "Returns T if ELT occurs in EXP at any level."
  (cond ((eql elt exp) t)
        ((atom exp) nil)
        (t (or (occurs-in elt (first exp))
               (occurs-in elt (rest exp)) )) ) )

(defun variablep (s)
  "Returns T if S is a known variable."
  (member s '(x y z x1 x2 y1 y2 z1 z2 u v w)) )

;;; Here is some test data:
(defparameter *literal1* '(p x (f a)))
(defparameter *literal2* '(p b y))
(defparameter *literal3* '(p (f x) (g a y)))
(defparameter *literal4* '(p (f (h b)) (g x y)))
(defparameter *literal5* '(p x))
(defparameter *literal6* '(p (f x)))
(defparameter *literal7* '(p x (f y) x))
(defparameter *literal8* '(p z (f z) a))

;;; Here's a function for demonstrating UNIFY.
(defun show-unification (lit1 lit2)
  "Prints out both inputs and output from UNIFY."
  (format t "~%Result of UNIFY on ~s and ~s is ~s."
          lit1 lit2 (unify lit1 lit2) ) )

(defun test ()
  "Calls UNIFY with sample arguments."
  (show-unification *literal1* *literal2*)
  (show-unification *literal3* *literal4*)
  (show-unification *literal5* *literal6*)
  (show-unification *literal7* *literal8*)
  (let ((u (unify *literal7* *literal8*)))
    (format t "~%Result of applying U to ~s is ~s."
            *literal7* (do-subst *literal7* u) )
    (format t "~%Result of applying U to ~s is ~s."
            *literal8* (do-subst *literal8* u) )
  ) )