;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 27.4.1) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define TOLERANCE 0.00001)

;; newton : (number -> number) number -> number 
;; to find a number r such that (< (abs (f r)) TOLERANCE) 
(define (newton f r0) 
  (cond 
    [(<= (abs (f r0)) TOLERANCE) r0] 
    [else (newton f (find-root-tangent f r0))]))

;; find-root-tangent : (number -> number) number -> number 
;; to find the root of the tagent of f at r0 
(define (find-root-tangent f r0) 
  (local ((define fprime (d/dx f))) 
    (- r0 
       (/ (f r0) 
     (fprime r0)))))

;; d/dx : (num -> num) -> (num -> num) 
;; to compute the derivative function of f numerically 
(define (d/dx f) 
  (local ((define (fprime x) 
            (/ (- (f (+ x  epsilon)) (f (- x  epsilon))) 
               (* 2  epsilon))) 
          (define epsilon .1)) 
    fprime))

;; find-root : (number -> number) number number -> number 
;; to determine a number R such that f has a 
;; root between R and (+ R TOLERANCE) 
;; 
;; ASSUMPTION: f is continuous and monotonic 
(define (find-root f left right)
  (cond 
      [(<= (- right left) TOLERANCE) left] 
      [else 
       (local ((define mid (/ (+ left right) 2)))
         (cond
           [(or (<= (f left) 0 (f mid)) (<= (f mid) 0 (f left)))
            (find-root f left mid)]
           [else
            (find-root f mid right)]))]))
     
;; f : number -> number 
(define (f x) 
  (- (* x x) x 1.8))

;; TESTS
(define pos-root-f (/ (+ 1 (sqrt (- 1 (* 4 -1.8)))) 2))

(<= (abs (- (find-root f 0 10) pos-root-f)) TOLERANCE)
(<= (abs (- (newton f 1) pos-root-f)) TOLERANCE)
(<= (abs (- (newton f 2) pos-root-f)) TOLERANCE)
(<= (abs (- (newton f 3) pos-root-f)) TOLERANCE)