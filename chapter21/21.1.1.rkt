;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 21.1.1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; tabulate-sin : number  ->  lon
;; to tabulate sin between n 
;; and 0 (inclusive) in a list
;(define (tabulate-sin n)
;  (cond
;    [(= n 0) (list (sin 0))]
;    [else
;      (cons (sin n)
;	(tabulate-sin (sub1 n)))]))
(define (tabulate-sin n)
  (tabulate sin n))

;; tabulate-sqrt : number  ->  lon
;; to tabulate sqrt between n 
;; and 0 (inclusive) in a list
;(define (tabulate-sqrt n)
;  (cond
;    [(= n 0) (list (sqrt 0))]
;    [else
;      (cons (sqrt n)
;	(tabulate-sqrt (sub1 n)))]))
(define (tabulate-sqrt n)
  (tabulate sqrt n))

;; tabulate : number -> number number -> list of number
(define (tabulate f n)
  (cond
    [(= n 0) (list (f 0))]
    [else
     (cons (f n)
           (tabulate f (sub1 n)))]))