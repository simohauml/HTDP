;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 23.3.6) (read-case-sensitive #t) (teachpacks ((lib "gui.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "gui.rkt" "teachpack" "htdp")) #f)))
;; series : N (N  ->  number)  ->  number
;; to sum up the first n numbers in the sequence a-term,
(define (series n a-term)
  (cond
    [(= n 0) (a-term n)]
    [else (+ (a-term n)
	     (series (- n 1) a-term))]))

;;; e-taylor : N  ->  number
;(define (e-taylor i)
;  (/ (expt x i) (! i)))
;
;;; ! : N  ->  number
;(define (! n)
;  (cond
;    [(= n 0) 1]
;    [else (* n (! (sub1 n)))]))

(define (e-power x)
  (local ((define (e-taylor i)
	    (/ (expt x i) (! i)))
	  (define (! n)
	    (cond
	      [(= n 0) 1]
	      [else (* n (! (sub1 n)))])))
    (series 20 e-taylor)))

(exp 1)
(e-power 1)