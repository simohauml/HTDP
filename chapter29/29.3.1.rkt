;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 29.3.1) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define Graph-as-vector
  (vector (list 1 4)
          (list 4 5)
          (list 3)
          empty
          (list 2 5)
          (list 3 6)
          empty))

;; neighbors : node graph  ->  (listof node)
;; to lookup the node in graph
(define (neighbors node graph)
  (vector-ref graph node))