;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 25.2.4) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t quasiquote mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; quick-sort : (listof number)  ->  (listof number)
;; to create a list of numbers with the same numbers as
;; alon sorted in ascending order
;; assume that the numbers are all distinct 
;(define (quick-sort alon)
;  (cond
;    [(empty? alon) empty]
;    [(empty? (rest alon)) alon]
;    [else (append (quick-sort (smaller-items alon (first alon)))
;	    	  (equal-items alon (first alon))
;		  (quick-sort (larger-items alon (first alon))))]))
(define (quick-sort alon)
  (cond
    [(empty? alon) empty]
    [(empty? (rest alon)) alon]
    [else (append (quick-sort (smaller-items (rest alon) (first alon)))
	    	  (list (first alon))
		  (quick-sort (larger-items (rest alon) (first alon))))]))

;; larger-items : (listof number) number  ->  (listof number)
;; to create a list with all those numbers on alon  
;; that are larger than threshold
(define (larger-items alon threshold)
  (cond
    [(empty? alon) empty]
    [else (if (> (first alon) threshold) 
	      (cons (first alon) (larger-items (rest alon) threshold))
	      (larger-items (rest alon) threshold))]))

;; smaller-items : (listof number) number  ->  (listof number)
;; to create a list with all those numbers on alon  
;; that are smaller than threshold
(define (smaller-items alon threshold)
  (cond
    [(empty? alon) empty]
    [else (if (<= (first alon) threshold) 
	      (cons (first alon) (smaller-items (rest alon) threshold))
	      (smaller-items (rest alon) threshold))]))

;(define (equal-items alon threshold)
;  (cond
;    [(empty? alon) empty]
;    [else (if (= (first alon) threshold)
;              (cons (first alon) (equal-items (rest alon) threshold))
;              (equal-items (rest alon) threshold))]))


(define l1 (list 11 11 9 2 18 9 12 14 4 1 18))
(define l2 (list 11 11 3))
(quick-sort l1)