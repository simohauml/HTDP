;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 29.1.1) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define t0 (list 3 5))

(define t1 (list
            (list 1 2)
            (list 3 4)))

(define t2 (list
            (list
             (list 1 2)
             (list 3 4))
            (list
             (list 3 4)
             (list 7 8))))

(define t3 (list
            (list
             (list 1 2)
             (list 3 4))
            (list
             (list
              (list 3 4)
              (list 2 9))
             (list
              (list 7 4)
              (list 4 5)))))

(define (sum-tree T)
  (cond
    [(empty? T) 0]
    [(number? T) T]
    [else (+ (sum-tree (left T))
             (sum-tree (right T)))]))

(define left first)
(define right second)

; a tree of N nodes, abstract running time is order of N, coefficient is 3/2?