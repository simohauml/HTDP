;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 23.3.8) (read-case-sensitive #t) (teachpacks ((lib "gui.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "gui.rkt" "teachpack" "htdp")) #f)))
;; series : N (N  ->  number)  ->  number
;; to sum up the first n numbers in the sequence a-term,
(define (series n a-term)
  (cond
    [(= n 0) (a-term n)]
    [else (+ (a-term n)
             (series (- n 1) a-term))]))

(define (my-sin x)
  (local
    [(define (sign i)
       (if (even? i)
           1
           -1))
     (define (odd i) (+ 1 (* i 2)))
     (define (! i)
       (cond
         [(= i 0) 1]
         [else (* i (! (sub1 i)))]))
     (define (ith i)
       (* (sign i)
          (/
           (expt x (odd i))
           (! (odd i)))))]
    (series 10 ith)))

(my-sin 5)
(sin 5)