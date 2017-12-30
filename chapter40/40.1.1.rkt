;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 40.1.1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(define (f-make-posn x0 y0)
  (local ((define x y0)
	  (define y y0)
	  (define (service-manager msg)
	    (cond
	      [(symbol=? msg 'x) x]
	      [(symbol=? msg 'y) y]
	      [else (error 'posn "...")])))
    service-manager))

(define (f-posn-x p)
  (p 'x))

(define (f-posn-y p)
  (p 'y))

;; the simulation does not provide function define different structures,
;; such as define-struct
;; it only works like make-posn, posn-x, posn-y