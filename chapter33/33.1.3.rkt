;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 33.1.3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (add n)
  (cond
    [(= n 0) 0]
    [else (+ #i1/185 (add (- n 1)))]))

;test
(add 185) ; should be 1, but not because of the accumulation of round-off error

(define (sub i)
  (local ((define (sub-aux i n)
            (cond
              [(= i 0) n]
              [else (sub-aux (- i 1/185) (+ 1 n))])))
    (sub-aux i 0)))

; test
(sub 1)
(sub #i1.)