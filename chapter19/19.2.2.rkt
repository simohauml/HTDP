;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 19.2.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(define-struct ir (name price))

;; sort1 : list-of-numbers  ->  list-of-numbers
;; to construct a list with all items from alon in descending order
(define (sort cmp alon)
  (local ((define (sort alon)
            (cond
              [(empty? alon) empty]
              [else (insert (first alon) (sort (rest alon)))]))
          (define (insert an alon)
            (cond
              [(empty? alon) (list an)]
              [else (cond
                      [(cmp an (first alon)) (cons an alon)]
                      [else (cons (first alon) (insert an (rest alon)))])])))
    (sort alon)))

(define (lessthan-ir ir1 ir2)
  (cond
    [(< (ir-price ir1) (ir-price ir2)) true]
    [else false]))

(define (morethan-ir ir1 ir2)
  (cond
    [(> (ir-price ir1) (ir-price ir2)) true]
    [else false]))
