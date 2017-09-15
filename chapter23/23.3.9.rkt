;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 23.3.9) (read-case-sensitive #t) (teachpacks ((lib "gui.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "gui.rkt" "teachpack" "htdp")) #f)))
(define (greg n)
  (local ((define (taylor-greg-ith i)
            (* (* 4 (sign i))
               (/ 1 (make-odd i))))
          (define (sign i)
            (cond
              [(zero? (remainder i 2)) 1]
              [else (- 1)]))
          (define (make-odd i)
            (+ (* 2 i) 1)))
    (exact->inexact (series 10000 taylor-greg-ith))))

(define (series n a-term) 
  (cond 
    [(= n 0) (a-term n)] 
    [else (+ (a-term n) 
             (series (- n 1) a-term))])) 

(greg 4)
pi