;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 26.1.2) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t quasiquote mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;(define (make-singles lon)
;  (cond
;    [(empty? lon) empty]
;    [else (cons (list (first lon))
;                (make-singles (rest lon)))]))
(define (make-singles lon)
  (map list lon))

(define (merge-all-neighbors slon)
  (cond
    [(empty? slon) empty]
    [(empty? (rest slon)) slon]
    [else (cons (merge-two-list (first slon) (second slon))
                (merge-all-neighbors (rest (rest slon))))]))

(define (merge-two-list lon1 lon2)
  (cond
    [(empty? lon1) lon2]
    [(empty? lon2) lon1]
    [else (if (<= (first lon1) (first lon2))
              (cons (first lon1) (merge-two-list (rest lon1) lon2))
              (cons (first lon2) (merge-two-list lon1 (rest lon2))))]))

(define (merge-all llon)
  (cond
    [(empty? llon) empty]
    [(empty? (rest llon)) llon]
    [else (merge-all (merge-all-neighbors llon))]))

(define (merge-sort lon)
  (merge-all (make-singles lon)))