;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 29.3.7) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define (norm V)
  (local ((define len (vector-length V))
          (define (norm-aux i)
            (cond
              [(= i len) 0]
              [else (+ (sqr (vector-ref V i))
                       (norm-aux (add1 i)))])))
    (sqrt (norm-aux 0))))