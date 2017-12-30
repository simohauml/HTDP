;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 43.1.4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; qsort : (vectorof number)  ->  (vectorof number)
;; effect: to modify V such that it contains the same items as before,
;; in ascending order  
(define (qsort V)
  (qsort-aux V 0 (sub1 (vector-length V))))

;; qsort-aux : (vectorof number) N N  ->  (vectorof number)
;; effect: sort the interval [left,right] of vector V
;; generative recursion
(define (qsort-aux V left right)
  (cond
    [(>= left right) V]
    [else (local ((define new-pivot-position (partition V left right)))
            (begin (qsort-aux V left (sub1 new-pivot-position))
                   (qsort-aux V (add1 new-pivot-position) right)))]))

;; partition : (vectorof number) N N  ->  N
;; to determine the proper position p of the pivot-item 
;; effect: rearrange the vector V so that 
;; -- all items in V in [left,p) are smaller than the pivot item
;; -- all items of V in (p,right] are larger than the pivot item
;; generative recursion
(define (partition V left right)
  (local ((define pivot-position left)
          (define the-pivot (vector-ref V left))
          (define (partition-aux left right)
            (local ((define new-right (find-new-right V the-pivot left right))
                    (define new-left (find-new-left V the-pivot left right)))
              (cond
                [(>= new-left new-right)
                 (begin
                   (swap V pivot-position new-right)
                   new-right)]
                [else ; (< new-left new-right)
                 (begin
                   (swap V new-left new-right)
                   (partition-aux new-left new-right))]))))
    (partition-aux left right)))

;; find-new-right : (vectorof number) number N N [>= left]  ->  N
;; to determine an index i between left and right (inclusive)
;; such that (< (vector-ref V i) the-pivot) holds
;; structural recursion: see text
(define (find-new-right V the-pivot left right)
  (cond
    [(= right left) right]
    [else (cond
            [(< (vector-ref V right) the-pivot) right]
            [else (find-new-right V the-pivot left (sub1 right))])]))

;; find-new-left : (vectorof number) number N N [<= right]  ->  N
;; to determine an index i between left and right (inclusive)
;; such that (> (vector-ref V i) the-pivot) holds
;; structural recursion: see text
(define (find-new-left V the-pivot left right)
  (cond
    [(= right left) left]
    [else (cond
            [(> (vector-ref V left) the-pivot) left]
            [else (find-new-left V the-pivot (add1 left) right)])]))

;; swap : (vectorof X) N N void 
(define (swap V i j)
  (local ((define temp (vector-ref V i)))
    (begin
      (vector-set! V i (vector-ref V j))
      (vector-set! V j temp))))

(define v1 (vector 1.1 0.75 1.9 0.35 0.58 2.2))

;;(qsort v1)