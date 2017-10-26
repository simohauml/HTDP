;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 31.3.1) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; sum : (listof number)  ->  number
;; to compute the sum of the numbers on alon
;; structural recursion 
(define (sum-r alon)
  (cond
    [(empty? alon) 0]
    [else (+ (first alon) (sum-r (rest alon)))]))

;; sum : (listof number)  ->  number
;; to compute the sum of the numbers on alon0
(define (sum alon0)
  (local (;; accumulator is the sum of the numbers that preceded
	  ;; those in alon on alon0
	  (define (sum-a alon accumulator)
	    (cond
	      [(empty? alon) accumulator]
	      [else (sum-a (rest alon) (+ (first alon) accumulator))])))
    (sum-a alon0 0)))


(define (g-series n)
  (cond
    [(zero? n) empty]
    [else (cons (expt -0.99 n) (g-series (sub1 n)))]))

(sum-r (g-series #i1000))
(sum (g-series #i1000))

;#i-0.49746596003269394
;#i-0.4974659600326953

(* 10e5 #i-0.49746596003269394)
(* 10e5 #i-0.4974659600326953)