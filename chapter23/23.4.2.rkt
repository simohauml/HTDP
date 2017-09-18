;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 23.4.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(define R 1000)

(define (series n a-term)
  (cond
    [(= n 0) (a-term n)]
    [else (+ (a-term n)
        (series (- n 1) a-term))]))

(define (integrate f a b)
  (local
    [(define width (/ (- b a) R))
     (define step (/ width 2))
     (define (area n)
       (* width
          (f (+ a
                (* n width)
                step))))]
    (series R area)))

(define (f x)
  (sqr x))

(integrate f 1 5)
(exact->inexact 124/3)

(integrate f 1 2)
(exact->inexact 7/3)

(integrate sin 0 pi)