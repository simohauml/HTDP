;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 31.3.3) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; product : (listof numbers) -> number
;; to compute the product of the numbers
(define (product lon)
  (local [;; product/acc : (listof numbers) number -> number
          ;; accumulator invariant: acc is the product of the numbers seen so far
          (define (product/acc lon acc)
            (cond
              [(empty? lon) acc]
              [else 
               (product/acc (rest lon)
                            (* (first lon) acc))]))]
  (product/acc lon 1)))


;; examples as tests
(= (product empty) 1)
(= (product (list 1 2 3 4)) 24)