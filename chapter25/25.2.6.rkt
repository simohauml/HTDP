;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 25.2.6) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t quasiquote mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
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


;; larger-items : (listof number) number -> (listof number) 
;; to create a list with all those numbers on alon  
;; that are larger than threshold 
(define (larger-items alon threshold) 
  (filter (lambda (x) (>= x threshold)) alon))

;; smaller-items : (listof number) number -> (listof number) 
;; to create a list with all those numbers on alon  
;; that are smaller than threshold 
(define (smaller-items alon threshold) 
  (filter (lambda (x) (< x threshold)) alon))

;(define (equal-items alon threshold)
;  (cond
;    [(empty? alon) empty]
;    [else (if (= (first alon) threshold)
;              (cons (first alon) (equal-items (rest alon) threshold))
;              (equal-items (rest alon) threshold))]))


;; general-quick-sort : (X X  ->  bool) (list X)  ->  (list X)
(define (general-quick-sort a-predicate a-list)
  (cond
    [(empty? a-list) empty]
    [(empty? (rest a-list)) a-list]
    [else (local ((define positive (general-quick-sort a-predicate
                                                       (filter (lambda (x) (a-predicate x (first a-list)))
                                                               (rest a-list))))
                  (define negative (general-quick-sort a-predicate
                                                       (filter (lambda (x) (not (a-predicate x (first a-list))))
                                                               (rest a-list)))))
            (append positive
                    (list (first a-list))
                    negative))]))

(define l1 (list 11 11 9 2 18 9 12 14 4 1 18))
(define l2 (list 11 11 3))
(general-quick-sort >= l1)
(general-quick-sort <= l1)