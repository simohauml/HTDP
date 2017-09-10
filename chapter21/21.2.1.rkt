;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 21.2.1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; 1
(define (f-int n) n)

;; 2
(define (fraction i) (/ 1 (expt 10 (+ i 1))))

;; 3
(define (evens n)
  (local ((define (even i) (* 2 i)))
    (build-list n even)))

;; 4
(define (tabulate f n)
  (reverse (build-list (+ 1 n) f)))

;(define (tabulate f n)
;  (cond
;    [(= n 0) (list (f 0))]
;    [else (cons (f n)
;                (tabulate f (- n 1)))]))

;; 5
;(define (diagonal n)
;  (local
;    [(define n-const n)
;     (define (diag i)
;       (local
;         [(define (replace i n)
;            (cond
;              [(= n 0) empty]
;              [(and (= i 0) (> n 0)) (cons 1 (replace (- i 1) (- n 1)))]
;              [else (cons 0 (replace (- i 1) (- n 1)))]))]
;         (replace i n-const)))]
;    (build-list n diag)))

(define (diagonal n)
  (local
    [(define (rows i)
       (local
         [(define (element j) (cond [(= i j) 1] [else 0]))]
         (build-list n element)))]
    (build-list n rows)))

