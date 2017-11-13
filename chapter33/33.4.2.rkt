;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 33.4.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(define inex (+ 1 #i1e-12))
(define exac (+ 1 1e-12))

(define (my-expt base e)
  (cond
    [(= e 0) 1]
    [else (* base (my-expt base (- e 1)))]))

(my-expt inex 30)
(my-expt exac 30)