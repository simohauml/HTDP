;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 14.2.3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; DATA DEFINITIONS

(define-struct node (ssn name left right))
;; A binary tree is either
;;   1. false or 
;;   2. (make-node soc pn lft rgt) 
;;         where soc is a number, pn is a symbol,
;;         and lft and rgt are bts. 

;; CONTRACT/HEADER/PURPOSE: 
;; inorder : bt -> list-of-symbols
;; to create a list of all names in abt:
;; left to right in the picture
;;(define (inorder abt) ...)

;; EXAMPLES
;; When given: 
;;   (make-node 66 'a (make-node 53 'b false false) false) 
;; inorder produces (cons 'b (cons 'a empty))

;; When given: 
;;   (make-node 53 'b (make-node 66 'a false false) false) 
;; inorder produces (cons 'a (cons 'b empty))

;; TEMPLATE: 
;(define (inorder abt)
;  (cond
;    ((boolean? abt) ...)
;    ((node? abt)
;     ... (node-ssn abt) ... (node-name abt) ... 
;     ... (inorder (node-left abt)) ... (inorder (node-right abt)) ... )))

;; DEFINITION:
(define (inorder abt)
  (cond
    ((boolean? abt) empty)
    ((node? abt)
     (append (inorder (node-left abt))
             (cons (node-ssn abt)
               (inorder (node-right abt)))))))

;; TESTS:

;(inorder (make-node 66 'a (make-node 53 'b false false) false))
;"should be" (cons 'b (cons 'a empty))
;
;(inorder (make-node 53 'b (make-node 66 'a false false) false))
;"should be" (cons 'a (cons 'b empty))