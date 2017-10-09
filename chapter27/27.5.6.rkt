;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 27.5.6) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; search : matrix -> (union (listof num) #f)
;; Purpose : produce first row in mat whose cofficient is not 0, #f otherwise
;; Example: (search a-sw-mat) = (list 2 1)
(define (search mat)
  (cond
    ((empty? mat) 
     (error 'gauss "the system of equations has no proper triangular form"))
    (else (cond
	    ((= (first (first mat)) 0) (search (rest mat)))
	    (else (first mat))))))