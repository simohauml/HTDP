;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 17.7.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
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
(make-app 'f (make-add 1 1))

;; (* 3 (g 2))
(make-mul 3 (make-app 'g 2))

; -------------------------------------------------------------------------

#|

A scheme-def is:
  (make-def symbol symbol scheme-expr)

|#

(define-struct def (name arg body))

;; 1. (define (f x) (+ 3 x)) 
(make-def 'f 'x (make-add 3 'x))

;; 2. (define (g x) (* 3 x)) 
(make-def 'g 'x (make-mul 3 'x))

;; 3. (define (h u) (f (* 2 u))) 
(make-def 'h 'u (make-app 'f (make-mul 2 'u)))

;; 4. (define (i v) (+ (* v v) (* v v))) 
(make-def 'i 'v (make-add (make-mul 'v 'v) (make-mul 'v 'v)))

;; 5. (define (k w) (* (h w) (i w))) 
(make-def 'k 'w (make-mul (make-app 'h 'w) (make-app 'i 'w)))

;; (define (f2c f) (* 5/9 (+ f -32)))
(make-def 'f2c 'f (make-mul 5/9 (make-add 'f -32)))

;; (define (circle-area r) (* 3.1415926535 (* r r)))
(make-def 'circle-area 'r (make-mul 3.1415926535 (make-mul 'r 'r)))