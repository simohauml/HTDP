;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 17.8.5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;;17.8.4 | Problem Statement | Table of Contents | 17.8.6
;; Language: Beginning Student with List Abbreviations

#| 17.8.5 list-equal?
------------------------------------------------------------
;Data Definition:
An atom is either
   1. a number
   2. a boolean
   3. a symbol

a list-of-atoms is either
  1. empty or
  2. (cons a loa)
  where a is an atom and loa is a list-of-atoms

;Template:
(define (list-equal? a-list another-list)
  (cond
    [(empty? a-list) ...]
    [(cons? a-list)
     ...(first a-list)...(first another-list)...
     ...(list-equal? (rest a-list) (rest another-list))...]))
|#
;; list-equal? : list-of-atoms list-of-atoms  ->  boolean
;; to determine whether a-list and another-list 
;; contain the same atoms in the same order
(define (list-equal? a-list another-list)
  (cond
    [(empty? a-list) (empty? another-list)]
    [else
     (and (cons? another-list)
          (atom=? (first a-list) (first another-list))
          (list-equal? (rest a-list) 
                       (rest another-list)))]))

;Examples and Tests:
(check-expect
 (list-equal? empty empty) 
 true)

(check-expect
 (list-equal? empty (list 1 false 'a)) 
 false)

(check-expect
 (list-equal? (list 1 false 'a) empty)
 false)

(check-expect
 (list-equal? (list 1 false 'a) 
              (list 1 false 'a)) 
 true)

(check-expect
 (list-equal? (list 1 false 'a) 
              (list 'a 1 false)) 
 false)

(check-expect
 (list-equal? (list 1 false 'a) 
              (list 3 false 'a)) 
 false)

#| We need a helper function that reports 
whether two atoms are the same
------------------------------------------------------------
;template:
(define (atom=? a-atom another-atom)
  (cond
    [(number? a-atom)...]
    [(boolean? a-atom)...]
    [(symbol? a-atom)...]))
|#
;;atom=?: atom atom -> boolean
;;consumes two atoms and returns true if
;;they are equal, false otherwise
(define (atom=? a-atom another-atom)
  (cond
    [(number? a-atom)
     (and (number? another-atom)
          (= a-atom another-atom))]
    [(boolean? a-atom)
     (and (boolean? another-atom)
          (boolean=? a-atom another-atom))]
    [(symbol? a-atom)
     (and (symbol? another-atom)
          (symbol=? a-atom another-atom))]))

;Examples as Tests:
(check-expect
 (atom=? 5 5)
 true)

(check-expect
 (atom=? 5 7)
 false)

(check-expect
 (atom=? 5 true)
 false)

(check-expect
 (atom=? 5 'a)
 false)

(check-expect
 (atom=? true true)
 true)

(check-expect
 (atom=? true false)
 false)

(check-expect
 (atom=? true 5)
 false)

(check-expect
 (atom=? true 'a)
 false)

(check-expect
 (atom=? 'w 'w)
 true)

(check-expect
 (atom=? 'w 's)
 false)

(check-expect
 (atom=? 'w 5)
 false)

(check-expect
 (atom=? 'w false)
 false)

