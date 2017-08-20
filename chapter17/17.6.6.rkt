;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 17.6.6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;(define (DNAprefix pattern search)
;  (cond
;    [(empty? pattern) true]
;    [(empty? search) false]
;    [else
;     (and (symbol=? (first pattern) (first search))
;          (DNAprefix (rest pattern) (rest search)))]))

(define (DNAprefix pattern search)
  (cond
    [(and (empty? pattern) (empty? search)) true]
    [(empty? pattern) (first search)]
    [(empty? search) false]
    [else
     (if (symbol=? (first pattern) (first search))
         (DNAprefix (rest pattern) (rest search))
         false)]))