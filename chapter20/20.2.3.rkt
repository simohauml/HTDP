;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 20.2.3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; Language: Intermediate Student

;; Exercise 20.2.3. Use filter1 to develop a function that
;; consumes a list of symbols and extracts all those that
;; are not equal to 'car. Give filter1's corresponding contract.

;; Solution.

(define (filter1 rel-op alon t)
  (cond
    [(empty? alon) empty]
    [else (cond
            [(rel-op (first alon) t)
             (cons (first alon)
                   (filter1 rel-op (rest alon) t))]
            [else
             (filter1 rel-op (rest alon) t)])]))

;; f: (listof symbol) -> (listof symbol)
;; consumes a (listof symbol), producing a (listof symbol) without
;; any occurrence of 'car
(define (f ls-of-sym)
  (local ((define (cmp sym1 sym2)
            (not (symbol=? sym1 sym2))))
    (filter1 cmp ls-of-sym 'car)))

(check-expect (f (list 'a 'b 'car 'x)) (list 'a 'b 'x))
(check-expect (f (list 'car 'car 'x 'car)) (list 'x))

;; The contract of filter1
;; filter1: (symbol symbol -> boolean) (listof symbol) symbol -> (listof symbol)