;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 14.4.4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
#|

A scheme-expression is either:

  - number,
  - symbol,
  - (make-add scheme-expression scheme-expression)
  - (make-mul scheme-expression scheme-expression)

|#

(define-struct add (lhs rhs))
(define-struct mul (lhs rhs))

(define (numeric? a-se)
  (cond
    [(number? a-se) true]
    [(symbol? a-se) false]
    [(add? a-se) (and (numeric? (add-lhs a-se))
                      (numeric? (add-rhs a-se)))]
    [(mul? a-se) (and (numeric? (mul-lhs a-se))
                      (numeric? (mul-rhs a-se)))]))

(define (evaluate-expression-numeric exp)
  (cond
    [(number? exp) exp]
    [(add? exp) (+ (evaluate-expression-numeric (add-lhs exp))
                   (evaluate-expression-numeric (add-rhs exp)))]
    [(mul? exp) (* (evaluate-expression-numeric (mul-lhs exp))
                   (evaluate-expression-numeric (mul-rhs exp)))]))

(define (evaluate-expression exp)
  (cond
    [(empty? exp) empty]
    [(numeric? exp) (evaluate-expression-numeric exp)]
    [else (error "un-support expression")]))

(define (subst v n exp)
  (cond
    [(numeric? exp) exp]
    [(symbol? exp)
     (if (eq? v exp)
         n
         exp)]
    [(add? exp) (make-add (subst v n (add-lhs exp))
                          (subst v n (add-rhs exp)))]
    [(mul? exp) (make-add (subst v n (mul-lhs exp))
                          (subst v n (mul-rhs exp)))]
    [else (error "un-support expression")]))