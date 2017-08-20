;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 17.7.4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;;17.7.2 | Problem Statement | Table of Contents | 17.7.4
#|

A scheme-expression is either:

  - number,
  - symbol,
  - (make-add scheme-expression scheme-expression)
  - (make-mul scheme-expression scheme-expression)
  - (make-app symbol scheme-expression)
|#

(define-struct add (lhs rhs))
(define-struct mul (lhs rhs))
(define-struct app (rator rand))

; -------------------------------------------------------------------------

#|

A scheme-def is:
  (make-def symbol symbol scheme-expr)

|#

(define-struct def (name arg body))


; -------------------------------------------------------------------------

#|
NOTE: The if and let construct aren't introduced in HtDP. 
We encourage you to learn more about programming languages 
than books teach. Please use the Help Desk to read up on if
and let in htdp/intermediate.
|#

;; evaluate-with-one-def : scheme-expression scheme-def -> number
;; evaluates a program with a single definition
(define (evaluate-with-one-def a-se P)
  (cond
    [(number? a-se) a-se]
    [(symbol? a-se) (error 'evaluate-expression "got a variable")]
    [(add? a-se) (+ (evaluate-with-one-def (add-lhs a-se) P)
                    (evaluate-with-one-def (add-rhs a-se) P))]
    [(mul? a-se) (* (evaluate-with-one-def (mul-lhs a-se) P)
                    (evaluate-with-one-def (mul-rhs a-se) P))]
    [(app? a-se) 
     (cond
       [(eq? (def-name P) (app-rator a-se))
        (evaluate-with-one-def
         (subst (def-body P)
                (def-arg P)
                (evaluate-with-one-def (app-rand a-se) P))
         P)]
       [else (error 'evaluate-with-one-def "not the right def")])]))

;; subst : scheme-expression symbol number -> scheme-expression
;; replaces all occurrences of var with num in a-se
(define (subst a-se var num)
  (cond
    [(number? a-se) a-se]
    [(symbol? a-se) (if (eq? var a-se)
                        num
                        a-se)]
    [(add? a-se) (make-add (subst (add-lhs a-se) var num)
                           (subst (add-rhs a-se) var num))]
    [(mul? a-se) (make-mul (subst (mul-lhs a-se) var num)
                           (subst (mul-rhs a-se) var num))]
    [(app? a-se) (make-app (app-rator a-se)
                           (subst (app-rand a-se) var num))]))

;; lookup-def : list-of-definitions symbol -> definition
;; finds the definition named `name', and raises an
;; error if that definition isn't present.
(define (lookup-def defs name)
  (cond
    [(empty? defs) (error 'lookup-def "no such definition")]
    [else (cond
            [(symbol=? (def-name (first defs)) name)
             (first defs)]
            [else (lookup-def (rest defs) name)])]))


;; evaluate-with-defs : scheme-expression list-of-scheme-def -> number
;; evaluates a program with a single definition
(define (evaluate-with-defs a-se defs)
  (cond
    [(number? a-se) a-se]
    [(symbol? a-se) (error 'evaluate-expression "got a variable")]
    [(add? a-se) (+ (evaluate-with-defs (add-lhs a-se) defs)
                    (evaluate-with-defs (add-rhs a-se) defs))]
    [(mul? a-se) (* (evaluate-with-defs (mul-lhs a-se) defs)
                    (evaluate-with-defs (mul-rhs a-se) defs))]
    [(app? a-se) 
     (let ([the-def (lookup-def defs (app-rator a-se))])
       (evaluate-with-defs
        (subst (def-body the-def)
               (def-arg the-def)
               (evaluate-with-defs (app-rand a-se) defs))
        defs))]))


;(define (evaluate-with-defs a-se defs P)
;  (cond
;    [(empty? defs) (error 'evaluate-with-defs "function not defied")]
;    [(eq? (def-name (car defs)) P) (evaluate-with-one-def a-se (car defs))]
;    [else
;     (evaluate-with-defs a-se (rest defs) P)]))

;; EXAMPLES AS TESTS
(define defs
  (list
   (make-def 'f 'x (make-add 3 'x))
   (make-def 'g 'x (make-mul 3 'x))
   (make-def 'h 'u (make-app 'f (make-mul 2 'u)))
   (make-def 'i 'v (make-add (make-mul 'v 'v) (make-mul 'v 'v)))
   (make-def 'k 'w (make-mul (make-app 'h 'w) (make-app 'i 'w)))
   (make-def 'f2c 'f (make-mul 5/9 (make-add 'f -32)))
   (make-def 'circle-area 'r (make-mul 3.1415926535 (make-mul 'r 'r)))))

(evaluate-with-defs (make-app 'k (make-app 'f 2)) defs)

;(lookup-def defs 'f)
;"should be"
;(make-def 'f 'x (make-add 3 'x))
;
;;(lookup-def defs 'i)
;"should be"
;(make-def 'i 'v (make-add (make-mul 'v 'v) (make-mul 'v 'v)))

; (lookup-def defs 'len)
; error!

;(define f2c-def (make-def 'f2c 'f (make-mul 5/9 (make-add 'f -32))))

;(evaluate-with-defs (make-app 'f2c 32) defs)
;"should be"
;0
;
;(evaluate-with-defs (make-app 'f2c 212) defs)
;"should be"
;100
;
;(evaluate-with-defs (make-app 'f2c -40) defs)
;"should be"
;-40
;
;(evaluate-with-defs (make-app 'g (make-add 2 2)) defs)
;"should be"
;12
;
;(evaluate-with-defs (make-app 'i 2) defs)
;"should be"
;8
;
;(evaluate-with-defs (make-app 'h 3) defs)
;"should be"
;9
;
;(evaluate-with-defs (make-add 17 (make-app 'h 4)) defs)
;"should be"
;28
;
;(evaluate-with-defs (make-app 'k 3) defs)
;"should be"
;162

; (evaluate-with-one-def (make-app 'radius 3) f2c-def)
; error!