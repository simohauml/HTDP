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
