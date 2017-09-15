;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 23.5.1) (read-case-sensitive #t) (teachpacks ((lib "gui.rkt" "teachpack" "htdp") (lib "graphing.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "gui.rkt" "teachpack" "htdp") (lib "graphing.rkt" "teachpack" "htdp")) #f)))
(define (y1 x) (+ x 4))
(define (y2 x) (- 4 x))
(define (y3 x) (+ x 10))
(define (y4 x) (- 10 x))
(define (y5 x) 12)

(graph-line y1 'red)
(graph-line y2 'blue)
(graph-line y3 'green)
(graph-line y4 'black)
(graph-line y5 'yellow)