;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 27.5.2) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define (subtract l1 l2)
  (cond
    [(empty? l1) empty]
    [(not (= (length l1) (length l2))) (error 'subtract "Length of lists are not equal")]
    [else (local ((define f1 (first l1))
                  (define f2 (first l2))
                  (define d (/ f2 f1)))
            (if (= d 1)
                (rest (map - l2 l1))
                (rest (map - l2 (map (lambda (x) (* x d)) l1)))))]))


(check-expect (subtract '(1 1 1) '(3 8 10)) `(,(- 8 3) ,(- 10 3)))
(check-expect (subtract '(1 2 3) '(3 8 10)) `(,(- 8 (* 3 2)) ,(- 10 (* 3 3))))