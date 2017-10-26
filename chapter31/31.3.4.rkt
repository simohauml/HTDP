;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 31.3.4) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; how-many : (Listof X) -> Number
;; how many items are on the list
(define (how-many lx)
   (how-many-accu lx 0))

;; how-many-accu : (Listof X) Number -> Number
;; accumulator: the number of items seen so far
(define (how-many-accu lx counted)
   (cond
     [(empty? lx) counted]
     [else (how-many-accu (rest lx) (+ counted 1))]))

;; Tests:
(= (how-many-accu '(a b c) 0) 3)

(= (how-many '(a b c)) 3)
