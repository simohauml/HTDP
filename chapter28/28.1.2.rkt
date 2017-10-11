;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 28.1.2) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
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

(define (neighbors ori G)
  (cond
    [(empty? G) (error 'neighbors "Cannot find")]
    [else (local ((define fstG (first G))
                  (define rstG (rest G)))
            (cond
              [(equal? ori (first fstG)) (second fstG)]
              [else (neighbors ori rstG)]))]))

;#| neighbors: node graph -> (listof node)
;   (define (neighbors a-node a-graph) ...)
;
;   Purpose: compute a-node's neighbors in a-graph
;
;   Example:
;     in figure~xyz,
;       G has no neighbors: empty
;       A has the list of neighbors (list 'B 'E)
;|#
;(define (neighbors a-node a-graph)
;  (cond
;    ((empty? a-graph) (error 'neighbors "can't happen"))
;    (else (cond
;	    ((eq? (first (first a-graph)) a-node)
;	     (second (first a-graph)))
;	    (else (neighbors a-node (rest a-graph)))))))
;
;;; equivalently, with Scheme's built-in lookup function:
;(define (neighbors a-node a-graph)
;  (second (assq a-node a-graph)))