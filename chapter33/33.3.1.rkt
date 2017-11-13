;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname Untitled) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (find n)
  (cond
    [(and (= (expt #i10. n) #i0.0)
          (not (= (expt #i10. (+ n 1)) #i0.0)))
     n]
    [else (find (- n 1))]))

(find 0)