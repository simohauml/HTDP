;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 27.2.4) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define (create-matrix n lon)
  (cond
    [(= n 0) empty]
    [(empty? lon) empty]
    [else (local ((define (firstn n lon)
                    (cond
                      [(= n 0) empty]
                      [(empty? lon) empty]
                      [else (cons (first lon) (firstn (- n 1) (rest lon)))]))
                  (define (restn n lon)
                    (cond
                      [(= n 0) lon]
                      [(empty? lon) empty]
                      [else (restn (- n 1) (rest lon))])))
            (cons (firstn n lon)
                  (create-matrix n (restn n lon))))]))

;(create-matrix 2 (list 1 2 3 4))

;(equal? (create-matrix 2 (list 1 2 3 4))
;        (list (list 1 2)
;              (list 3 4)))