;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 14.1.3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; A family-tree-node (short: ftn) is either
;;
;;   1. empty; or
;;   2. (make-child f m na da ec)
;;      where f and m are ftns, na
;;      and ec are symbols, and da is a number.
(define-struct child (father mother name date eyes))

;; Oldest Generation:
(define Carl (make-child empty empty 'Carl 1926 'green))
(define Bettina (make-child empty empty 'Bettina 1926 'green))

;; Middle Generation: 
(define Adam (make-child Carl Bettina 'Adam 1950 'yellow))
(define Dave (make-child Carl Bettina 'Dave 1955 'black))
(define Eva (make-child Carl Bettina 'Eva 1965 'blue))
(define Fred (make-child empty empty 'Fred 1966 'pink))

;; Youngest Generation: 
(define Gustav (make-child Fred Eva 'Gustav 1988 'brown))

;; count-persons : ftn -> integer
;; to determine how many people in a-ftree
(define (count-persons a-ftree)
  (cond
    [(empty? a-ftree) 0]
    [else
     (+ 1
        (count-persons (child-father a-ftree))
        (count-persons (child-mother a-ftree)))]))