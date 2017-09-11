;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 23.3.4) (read-case-sensitive #t) (teachpacks ((lib "gui.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "gui.rkt" "teachpack" "htdp")) #f)))
#| ---------------------------------------------------------------------------
   geometric-series : number number (N -> number)
   to produce a function that computes the n-the term in the geometric series
    
   Example:
    (geometric-series 3 5) is equivalent to g-fives (or g-fives-closed)
|#

(define (geometric-series start factor)
  (local ((define (geo-closed n)
	    (* start (expt factor n))))
    geo-closed))