;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 12.2.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; search : number sorted-list-of-numbers -> boolean
;; sorted-list-of-numbers contains numbers in ascending order
;; search-sorted : number list-of-numbers -> boolean
;; to determine if n is is alon
(define (search-sorted n alon)
  (cond
    [(empty? alon) false]
    [else (cond
            [(= n (first alon)) true]
            [(< n (first alon)) false]
            [(> n (first alon)) (search-sorted n (rest alon))])]))

;; EXAMPLES AS TESTS
(search-sorted 0 empty) "should be" false

(search-sorted 2 (cons 1 (cons 2 (cons 3 (cons 4 empty)))))
"should be" true

(search-sorted 2 (cons 1 (cons 3 (cons 4 empty))))
"should be" false