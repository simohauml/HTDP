;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 17.7.3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
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

;; EXAMPLES

;; (f (+ 1 1))
;(make-app 'f (make-add 1 1))
;
;;; (* 3 (g 2))
;(make-mul 3 (make-app 'g 2))

; -------------------------------------------------------------------------

#|

A scheme-def is:
  (make-def symbol symbol scheme-expr)

|#

(define-struct def (name arg body))

;; 1. (define (f x) (+ 3 x)) 
;(make-def 'f 'x (make-add 3 'x))
;
;;; 2. (define (g x) (* 3 x)) 
;(make-def 'g 'x (make-mul 3 'x))
;
;;; 3. (define (h u) (f (* 2 u))) 
;(make-def 'h 'u (make-app 'f (make-mul 2 'u)))
;
;;; 4. (define (i v) (+ (* v v) (* v v))) 
;(make-def 'i 'v (make-add (make-mul 'v 'v) (make-mul 'v 'v)))
;
;;; 5. (define (k w) (* (h w) (i w))) 
;(make-def 'k 'w (make-mul (make-app 'h 'w) (make-app 'i 'w)))
;
;;; (define (f2c f) (* 5/9 (+ f -32)))
;(make-def 'f2c 'f (make-mul 5/9 (make-add 'f -32)))
;
;;; (define (circle-area r) (* 3.1415926535 (* r r)))
;(make-def 'circle-area 'r (make-mul 3.1415926535 (make-mul 'r 'r)))

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

;; EXAMPLES AS TESTS

(define f-def (make-def 'f 'x (make-mul 5/9 (make-add 'x -32))))


;(subst 1 'x 2)
;"should be"
;1
;
;(subst 'x 'x 2)
;"should be"
;2
;
;(subst 'x 'y 2)
;"should be"
;'x
;
;(subst (make-mul 'x 'y) 'x 2)
;"should be"
;(make-mul 2 'y)
;
;(subst (make-add 'x 'y) 'x 2)
;"should be"
;(make-add 2 'y)
;
;(subst (make-app 'f 'x) 'x 2)
;"should be"
;(make-app 'f 2)
;
;(define f2c-def (make-def 'f2c 'f (make-mul 5/9 (make-add 'f -32))))

;(evaluate-with-one-def (make-app 'f2c 32) f2c-def)
;"should be"
;0
;
;(evaluate-with-one-def (make-app 'f2c 212) f2c-def)
;"should be"
;100
;
;(evaluate-with-one-def (make-app 'f2c -40) f2c-def)
;"should be"
;-40

; (evaluate-with-one-def (make-app 'radius 3) f2c-def)
; error!