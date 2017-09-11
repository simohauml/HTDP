;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 23.3.1) (read-case-sensitive #t) (teachpacks ((lib "gui.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "gui.rkt" "teachpack" "htdp")) #f)))
#| ---------------------------------------------------------------------------
   g-fives : N -> number
   to compute the n-the term in the geometric series
     3, 15, 75, 375, ...
   recursive computation

   Examples:
    (g-fives 0) = 3
    (g-fives 2) = 75
|#

(define (g-fives n)
  (cond
    ((zero? n) 3)
    (else (* 5 (g-fives (sub1 n))))))