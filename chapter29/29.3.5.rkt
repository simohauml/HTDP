;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 29.3.5) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; lr-vector-sum : (vectorof number)  ->  number
;; to sum up the numbers in v
;(define (lr-vector-sum v)
;  (vector-sum-aux v 0))

;; vector-sum : (vectorof number)  ->  number
;; to sum up the numbers in v with index in [i, (vector-length v))
;(define (vector-sum-aux v i)
;  (cond
;    [(= i (vector-length v)) 0]
;    [else (+ (vector-ref v i) (vector-sum-aux v (add1 i)))]))

(define (lr-vector-sum v)
  (local ((define len (vector-length v))
          (define (vector-sum-aux i)
            (cond
              [(= i len) 0]
              [else (+ (vector-ref v i) (vector-sum-aux (add1 i)))])))
    (vector-sum-aux 0)))

;(lr-vector-sum (vector -1 3/4 1/4))
(lr-vector-sum (vector -1 3/4 1/4))