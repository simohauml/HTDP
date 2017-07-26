;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 14.2.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(define-struct node (ssn name left right))

(define bt1 (make-node 11 'Bobby false (make-node 12 'Luke false false)))
(define bt2 (make-node 11 'Bobby (make-node 12 'Luke false false) false))
(define bt3 (make-node 11 'Bobby (make-node 12 'Luke false false) (make-node 5 'Paul false false))) 

(define (contains-bt? n bt)
  (cond
    [(empty? bt) false]
    [(= n (node-ssn bt)) true]
    [else
     (or (contains-bt? n (node-left bt))
         (contains-bt? n (node-right bt)))]))

(define (search-bt n bt)
  (cond
    [(empty? bt) false]
    [(= n (node-ssn bt)) (node-name bt)]
    [(contains-bt? n (node-left bt)) (search-bt n (node-left bt))]
    [else (search-bt n (node-right bt))]))