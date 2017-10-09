;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 27.3.5) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
; find-root-linear : table num -> num
;; returns the root of a table
(define (find-root-linear table VL)
  (if (= VL 1)
      (table 0)
      (local ((define table-at-VL-1 (table (- VL 1)))
              (define root-of-rest (find-root-linear table (- VL 1))))
        (if (< (abs table-at-VL-1)
               (abs root-of-rest))
            table-at-VL-1
            root-of-rest))))

;; find-root-discrete : table num -> num
;; returns the root of a table assuming table is sorted in ascending order
(define (find-root-discrete table VL)
  (local ((define (mp lower upper)
            (floor (/ (+ upper lower) 2)))
          (define (closest x y)
            (if (< (abs x) (abs y))
                x
                y))
          (define (aux lower mid upper)
            (cond
              ((or (= (- upper lower) 1)
                   (<= (table lower) (table upper) 0)
                   (<= 0 (table lower) (table upper)))
               (closest (table lower) (table upper)))
              ((<= (table lower) 0 (table mid))
               (aux lower (mp lower mid) mid))
              (else
               (aux mid (mp mid upper) upper)))))
    (aux 0 (mp 0 (- VL 1)) (- VL 1))))
              
              
                            
              
              
;; TESTS
(define (g i) 
  (cond 
    [(= i 0) -10] 
    [(= i 1) 43] 
    [(= i 2) 23]
    [(= i 3) -4]
    [(= i 4) -23]
    [else (error 'g "is defined only between 0 and VL (exclusive)")]))

(= (find-root-linear g 5) -4)

(define (f i)
  (cond
    [(= i 0) -60] 
    [(= i 1) -50] 
    [(= i 2) -40]
    [(= i 3) -30]
    [(= i 4) -20]
    [(= i 5) -10]
    [(= i 6) -1]
    [else (error 'h "is defined only between 0 and VL (exclusive)")]))

(define (h i)
  (cond
    [(= i 0) 1] 
    [(= i 1) 10] 
    [(= i 2) 20]
    [(= i 3) 30]
    [(= i 4) 40]
    [(= i 5) 50]
    [(= i 6) 60]
    [else (error 'h "is defined only between 0 and VL (exclusive)")]))

(define (j i)
  (cond
    [(= i 0) -30] 
    [(= i 1) -20] 
    [(= i 2) -10]
    [(= i 3) -4]
    [(= i 4) -3]
    [(= i 5) 1]
    [(= i 6) 30]
    [else (error 'h "is defined only between 0 and VL (exclusive)")]))


(= (find-root-discrete f 7) -1)
(= (find-root-discrete h 7) 1)
(= (find-root-discrete j 7) 1)