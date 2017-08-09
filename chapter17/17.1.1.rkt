;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 17.1.1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; Language: Beginning Student with List Abbreviations

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

;Examples as Tests:
;(check-expect 
; (replace-eol-with empty L)
; L)
;
;(check-expect 
; (replace-eol-with (cons 1 empty) L) 
; (cons 1 L))
;
;(check-expect 
; (replace-eol-with (cons 2 (cons 1 empty)) L) 
; (cons 2 (cons 1 L)))
;
;(check-expect 
; (replace-eol-with (cons 2 (cons 11 (cons 1 empty))) L) 
; (cons 2 (cons 11 (cons 1 L))))

#| Use replace-eol-with to define our-append
------------------------------------------------------------
|#
;our-append: list list -> list
;consumes three lists and juxtaposes their items.
;Uses replace-eol-with to replicate what append does.
(define (our-append list1 list2 list3)
  (replace-eol-with list1 (replace-eol-with list2 list3)))

;Tests:
;(check-expect (our-append 
;               empty
;               empty
;               empty)
;              empty)
;(check-expect (our-append 
;               empty
;               (list 'a 'b 'c)
;               empty)
;              (list 'a 'b 'c))
;(check-expect (our-append 
;               (list 1 2 3)
;               (list 'a 'b 'c)
;               empty)
;              (list 1 2 3 'a 'b 'c))
;(check-expect (our-append 
;               (list 1 2 3)
;               (list 'a 'b 'c)
;               (list 5 'w  'r))
;              (list 1 2 3 'a 'b 'c 5 'w  'r))
