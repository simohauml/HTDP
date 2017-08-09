;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 17.1.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
#| 17.1.1
replace-eol-with adapted from text by allowing 
any type of list instead of only a list-of-numbers
------------------------------------------------------------
Data Definition:
A list is 
  1. empty or
  2. (cons i loi) 
     where i is a item and loi is a list-of-items

A list-of-items to be used in examples below
|#
(define L (list 3 6 8 4 9))

#|
list template:
(define (replace-eol-with alon1 alon2)
  (cond
    ((empty? alon1) ...)
    (else ... (first alon1) ... 
          ... (replace-eol-with (rest alon1) alon2) ... )))
|#

;;replace-eol-with : list list  ->  list
;;to construct a new list by replacing 
;;empty in alon1 with alon2
(define (replace-eol-with alon1 alon2)
  (cond
    [(empty? alon1) alon2]
    [else 
     (cons (first alon1) 
           (replace-eol-with (rest alon1) alon2))]))

(define (cross l1 l2)
  (cond
    [(empty? l1) empty]
    [else
     (append (cross-help (first l1) l2)
             (cross (rest l1) l2))]))

(define (cross-help s l)
  (cond
    [(empty? l) empty]
    [else
     (append (list (list s (first l)))
             (cross-help s (rest l)))]))

(define L1 '(a b c))
(define L2 '(1 2 3))