;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 14.4.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
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