;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 30.1.1) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; relative-2-absolute : (listof number)  ->  (listof number)
;; to convert a list of relative distances to a list of absolute distances
;; the first item on the list represents the distance to the origin
(define (relative-2-absolute alon)
  (cond
    [(empty? alon) empty]
    [else (cons (first alon)
                (add-to-each (first alon) (relative-2-absolute (rest alon))))]))

;; add-to-each : number (listof number)  ->  (listof number)
;; to add n to each number on alon
(define (add-to-each n alon)
  (map (lambda (x) (+ x n)) alon))

(define dots (list 50 40 70 30 30))
(define dots10 (build-list 10 (lambda (x) x)))
(define dots20 (build-list 20 (lambda (x) x)))
(define dots30 (build-list 30 (lambda (x) x)))