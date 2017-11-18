;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 35.1.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(define x 1)
(define y 1)

(local ((define u (set! x (+ x 1)))
	(define v (set! y (- y 1))))
  (* x y))


;(define x 1)
;(define y 1)
;
;(local ((define u ...)
;	(define v ...))
;  (* x y))
; if no introduction of set!-expressions, this would produce 1,
; because x, y are not changed