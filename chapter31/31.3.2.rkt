;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 31.3.2) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; ! : N  ->  N
;; to compute n  ·  (n - 1)  ·  ...  ·  2  ·  1
(define (! n0)
  (local (;; accumulator is the product of all natural numbers in [n0, n)
	  (define (!-a n accumulator)
	    (cond
	      [(zero? n) accumulator]
	      [else (!-a (sub1 n) (* n accumulator))])))
    (!-a n0 1)))

;; ! : N  ->  N
;; to compute n  ·  (n - 1)  ·  ...  ·  2  ·  1
;; structural recursion 
(define (!-r n)
  (cond
    [(zero? n) 1]
    [else (* n (!-r (sub1 n)))]))

;; many : N (N  ->  N)  ->  true
;; to evaluate (f 20) n times 
(define (many n f)
  (cond
    [(= n 0) true]
    [else (and
           (number? (f 20))
           (many (- n 1) f))]))

;(time (many 100 !))
(time (many 100 !-r))
