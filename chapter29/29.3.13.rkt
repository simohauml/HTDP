;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 29.3.13) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define (distance V1 V2)
  (local ((define length
            (vector-length V1))
          (define (aux i)
            (cond
              [(= i length) 0]
              [else (+ (sqr (- (vector-ref V2 i)
                               (vector-ref V1 i)))
                       (aux (add1 i)))])))
    (sqrt (aux 0))))

(= (distance (vector 0 4)
             (vector 0 2))
   2)
(= (distance (vector -4 0)
             (vector -2 0))
   2)
(= (distance (vector 1 1)
             (vector 4 5))
   5)
(= (distance (vector 1 2 3 5 6)
             (vector 1 2 3 5 6))
   0)