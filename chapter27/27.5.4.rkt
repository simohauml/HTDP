;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 27.5.4) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define (subtract u v)
  (local ((define u1 (first u))
          (define v1 (first v))
          (define r (/ v1 u1)))
    (rest (map - v (map (lambda (x) (* x r)) u)))))

(define (triangulate soe)
  (cond
    [(empty? soe) empty]
    [(empty? (rest soe)) (list soe)]
    [(empty? (rest (rest soe))) (cons (first soe)
                                      (list (subtract (first soe) (second soe))))]
    [else (local ((define fst (first soe))
                  (define (subrest rstsoe fst)
                    (cond
                      [(empty? rstsoe) empty]
                      [else (cons (subtract fst (first rstsoe))
                                  (subrest (rest rstsoe) fst))]))
                  (define rst (subrest (rest soe) fst)))
            (cons (first soe) (triangulate rst)))]))


;(triangulate (list (list 2 2  3 10) 
;                   (list 2 5 12 31)  
;                   (list 4 1 -2  1)))
 
(equal? 
 (triangulate (list (list 2 2  3 10) 
                    (list 2 5 12 31)  
                    (list 4 1 -2  1)))
 (list (list 2 2  3   10) 
       (list   3  9   21)  
       (list      1    2)))