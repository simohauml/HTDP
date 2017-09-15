;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 23.3.7) (read-case-sensitive #t) (teachpacks ((lib "gui.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "gui.rkt" "teachpack" "htdp")) #f)))
;; series : N (N  ->  number)  ->  number
;; to sum up the first n numbers in the sequence a-term,
(define (series n a-term)
  (cond
    [(= n 0) (a-term n)]
    [else (+ (a-term n)
	     (series (- n 1) a-term))]))

(define (ln x)
  (local
    [(define (odd i) (+ 1 (* 2 i)))
     (define (lg-taylor i)
       (*
        (/ 2 (odd i))
        (expt (/ (- x 1) (+ x 1)) (odd i))))]
    (series 25 lg-taylor)))

(ln 3)
(log 3)