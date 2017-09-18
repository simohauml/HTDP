;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 23.4.1) (read-case-sensitive #t) (teachpacks ((lib "gui.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "gui.rkt" "teachpack" "htdp")) #f)))
#| ---------------------------------------------------------------------------
   integrate-kepler : (number -> number) number[a] number[>a] -> number

   to compute the area under f between a and b using Kepler's method

   Examples:
    (integrate-kepler one 0 1) =~ 1
    (integrate-kepler square 0 1) =~ 1/3 

|# 
(define (integrate-kepler f a b)
  (*
   (+ (f a)
      (* 4 (f (/ (+ a b) 2)))
      (f b))
   (/ (- b a) 6)))

#| Tests: 
(define (square x)
  (* x x))

(define (one x)
  1)

(= (integrate-kepler one 0 1) 1)

(= (integrate-kepler square 0 1) 1/3)
|#


;; integrate : (number -> number) number number -> number 
;; to compute the area under the graph of f between a and b 
(define (integrate f a b)
  (local ((define midpoint (/ (+ a b) 2))
          (define area-trap-1 (* (/ (- b a) 2)
                                 (/ (+ (f a)
                                       (f midpoint))
                                    2)))
          (define area-trap-2 (* (/ (- b a) 2)
                                 (/ (+ (f midpoint)
                                       (f b))
                                    2))))
    (exact->inexact (+ area-trap-1 area-trap-2))))

(define (f x)
  (sqr x))

(integrate f 1 5)
(exact->inexact 124/3)

(integrate f 1 2)
(exact->inexact 7/3)