;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 14.2.5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(define-struct node (ssn name left right))

(define (create-bst bst number name)
  (cond
    [(false? bst) (make-node (number name false false))]
    [(= number (node-ssn bst)) bst]
    [(< number (node-ssn bst)) (make-node
                                (node-ssn bst)
                                (node-name bst)
                                (create-bst (node-left bst) number name)
                                (node-right bst))]
    [else (make-node
           (node-ssn bst)
           (node-name bst)
           (node-left bst)
           (create-bst (node-right bst) number name))]))
    