;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 29.3.10) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; vector-count : (vectorof Symbol) Symbol -> N
;; counts the number of times a given symbol occurs in a given vector
(define (vector-count v s)
  (local ((define len
            (vector-length v))
          (define (aux i)
            (cond
              [(= i len) 0]
              [(symbol=? (vector-ref v i) s)
               (add1 (aux (add1 i)))]
              [else (aux (add1 i))])))
    (aux 0)))
;; TESTS
(define test-v
  (vector 'a 'b 'c 'd 'e 'a 'b 'c 'd 'a 'b 'c 'a 'b 'a))
(= (vector-count test-v 'e) 1)
(= (vector-count test-v 'd) 2)
(= (vector-count test-v 'a) 5)
(= (vector-count test-v 'BOOKS) 0)