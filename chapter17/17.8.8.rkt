;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 17.8.8) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; Language: Beginning Student with List Abbreviations

#| 17.8.8 tree=?
------------------------------------------------------------
;Data Definition:
A binary-tree (short: BT) is either
  1. false; or
  2. (make-node n lft rgt)
     where n is a number and lft and rgt are BTs
|#
(define-struct node (n left right))
#|
;template:
(define (tree=? a-bt another-bt)
  (cond
    [(equal? false a-bt)...]
    [else
     ...(node-n a-bt)...(node-n another-bt)...
     ...(tree=? (node-left a-bt)
                (node-left another-bt))...
     ...(tree=? (node-right a-bt)
                (node-right another-bt))...]))
|#
;;tree=?: BT BT -> boolean
;;consumes two BTs and returns true
;;if they are equal, false otherwise
(define (tree=? a-bt another-bt)
  (cond
    [(equal? false a-bt) (equal? false another-bt)]
    [else
     (and (node? another-bt)
          (= (node-n a-bt)
             (node-n another-bt))
          (tree=? (node-left a-bt)
                  (node-left another-bt))
          (tree=? (node-right a-bt)
                  (node-right another-bt)))]))

;Examples as Tests:
(check-expect
 (tree=? false false)
 true)

(check-expect
 (tree=? (make-node 12 
                    false
                    false)
         (make-node 12 
                    false
                    false))
 true)

(check-expect
 (tree=? false false)
 true)

(check-expect
 (tree=? (make-node 12 
                    false
                    false)
         (make-node 18 
                    false
                    false))
 false)

(check-expect
 (tree=?
  (make-node 12 
             (make-node 35
                        false
                        false)
             (make-node 65
                        (make-node 89
                                   false
                                   false)
                        false))
  (make-node 12
             (make-node 35
                        false
                        false)
             (make-node 65
                        (make-node 89
                                   false
                                   false)
                        false))) 
 true)

(check-expect
 (tree=?
  (make-node 12 
             (make-node 35
                        false
                        false)
             (make-node 65
                        (make-node 89
                                   false
                                   false)
                        false))
  (make-node 12
             (make-node 35
                        false
                        false)
             (make-node 65
                        (make-node 89
                                   (make-node 7
                                              false
                                              false)
                                   false)
                        false))) 
 false)