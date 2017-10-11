;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 28.1.1) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define-struct graph (node loendpoint graph))

;; Here is a translation of the definition of Graph: 
(define Graph 
  (list (list 'A (list 'B 'E))
        (list 'B (list 'E 'F))
	(list 'C (list 'D))
	(list 'D empty)
	(list 'E (list 'C 'F))
	(list 'F (list 'D 'G))
	(list 'G empty)))

;; A graph is a (listof (list node (listof nodes))).