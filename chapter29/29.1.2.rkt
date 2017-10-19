;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 29.1.2) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; maxi : ne-list-of-numbers  ->  number
;; to determine the maximum of a non-empty list of numbers 
(define (maxi alon)
  (cond
    [(empty? (rest alon)) (first alon)]
    [else (cond
	    [(> (maxi (rest alon)) (first alon)) (maxi (rest alon))]
	    [else (first alon)])]))

;; maxi2 : ne-list-of-numbers  ->  number
;; to determine the maximum of a list of numbers 
(define (maxi2 alon)
  (cond
    [(empty? (rest alon)) (first alon)]
    [else (local ((define max-of-rest (maxi2 (rest alon))))
	    (cond
	      [(> max-of-rest (first alon)) max-of-rest]
	      [else (first alon)]))]))

(define l1 (list 0 1 2 3))