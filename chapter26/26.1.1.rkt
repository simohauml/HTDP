;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 26.1.1) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t quasiquote mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; tabulate-div : NaturalNumber -> Listof[NaturalNumber]
;; to list the divisors of n starting from 1, ending in n

;; Solution 1:
(define (tabulate-div.v0 n)
   (local ((define action (lambda (d) (= (remainder n d) 0))))
     (filter action (build-list n add1))))

;; Solution 2: derived from solution 1, with lambda
(define (tabulate-div.v1 n)
  (filter (lambda (d) (= (remainder n d) 0)) (build-list n add1)))

;; Solution 3: a generative recursive solution
(define (tabulate-div n)
   (local ((define (loop i)
             (cond
               [(> i n) empty]
               [(= (remainder n i) 0) (cons i (loop (add1 i)))]
               [else (loop (add1 i))])))
     (loop 1)))

;; Examples/Tests:
(equal? (tabulate-div 0) empty)
(equal? (tabulate-div 10) (list 1 2 5 10))
(equal? (tabulate-div 20) (list 1 2 4 5 10 20))

(equal? (tabulate-div.v1 0) empty)
(equal? (tabulate-div.v1 10) (list 1 2 5 10))
(equal? (tabulate-div.v1 20) (list 1 2 4 5 10 20))

(equal? (tabulate-div.v0 0) empty)
(equal? (tabulate-div.v0 10) (list 1 2 5 10))
(equal? (tabulate-div.v0 20) (list 1 2 4 5 10 20))