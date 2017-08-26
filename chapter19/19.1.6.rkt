;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 19.1.6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))

;; sort1 : list-of-numbers  ->  list-of-numbers
;; to construct a list with all items from alon in descending order
(define (sort1 cmp alon)
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

(check-expect (sort1 < empty) empty)
(check-expect (sort1 < (list 1)) (list 1))
(check-expect (sort1 < (list 2 1)) (list 1 2))
(check-expect (sort1 > empty) empty)
(check-expect (sort1 > (list 1)) (list 1))
(check-expect (sort1 > (list 1 2)) (list 2 1))

(check-expect (sort1 < (list 2 3 1 5 4)) (list 1 2 3 4 5))
(check-expect (sort1 > (list 2 3 1 5 4)) (list 5 4 3 2 1))