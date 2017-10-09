;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 27.3.6) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;(define TOLERANCE 0.01)
;
;(define (integrate-dc f left right)
;  (local ((define mid (/ (+ right left) 2)))
;    (cond
;      [(< (- right left) TOLERANCE) (* (- right left) (f mid))]
;      [else (+ (integrate-dc f left mid)
;               (integrate-dc f mid right))])))
;
;(define (f x) (* x x))

;; integrate-dc : f left right
;; integrates given function between left and right
(define (integrate-dc f left right)
  (local ((define TOLERANCE 0.001)
          (define (mp x y)
            (/ (+ x y) 2))
          (define (trapezoid-area a b)
            (* (- b a)
               (/ (+ (f b) (f a))
                  2)))
          (define (aux left mid right)
            (if (<= (- right left) TOLERANCE)
                (trapezoid-area left right)
                (+ (aux left (mp left mid) mid)
                   (aux mid (mp mid right) right)))))
    (aux left (mp left right) right)))

;; integrate-adaptive : f left right
;; integrates given function between left and right
(define (integrate-adaptive f left right)
  (local ((define TOLERANCE 0.001)
          (define (mp x y)
            (/ (+ x y) 2))
          (define (trap-area a b)
            (* (- b a)
               (/ (+ (f b) (f a))
                  2)))
          (define (aux left mid right)
            (if (<= (abs (- (trap-area left mid) (trap-area mid right)))
                    (* TOLERANCE (- right left)))
                (trap-area left right)
                (+ (aux left (mp left mid) mid)
                   (aux mid (mp mid right) right)))))
    (aux left (mp left right) right)))


;; TESTS
(define (f x)
  (* 2 x))

(define (g x)
  (sqr x))

(integrate-dc f 0 4) ;; should be about 16
(integrate-dc g 1 5) ;; should be about 41.3

(integrate-adaptive f 0 4) ;; should be about 16
(integrate-adaptive g 1 5) ;; should be about 41.3