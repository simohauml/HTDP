;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 29.3.4) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; vector-sum : (vectorof number)  ->  number
;; to compute the sum of the numbers in v
(define (vector-sum v) 
  (vector-sum-aux v (vector-length v)))
;; vector-sum-aux : (vectorof number) N  ->  number
;; to sum the numbers in v with index in [0, i)
(define (vector-sum-aux v i) 
  (cond
    [(zero? i) 0]
    [else (+ (vector-ref v (sub1 i)) 
	     (vector-sum-aux v (sub1 i)))]))

(vector-sum-aux (vector -1 3/4 1/4) 3)