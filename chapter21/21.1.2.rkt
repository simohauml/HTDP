;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 21.1.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; sum : (listof number)  ->  number
;; to compute the sum of 
;; the numbers on alon
;(define (sum alon)
;  (cond
;    [(empty? alon) 0]
;    [else (+ (first alon)
;	     (sum (rest alon)))]))
(define (sum alon)
  (fold + 0 alon))

;; product : (listof number)  ->  number
;; to compute the product of 
;; the numbers on alon
;(define (product alon)
;  (cond
;    [(empty? alon) 1]
;    [else (* (first alon)
;	     (product (rest alon)))]))
(define (product alon)
  (fold * 1 alon))

(define (fold func anchor alon)
  (cond
    [(empty? alon) anchor]
    [else (func (first alon)
                (fold func anchor (rest alon)))]))

(define (append1 alon1 alon2)
  (fold cons alon2 alon1))

(define (map2 f l)
  (local
    ([define (cmb fst rst) (cons (f fst) rst)])
    (fold cmb empty l)))
