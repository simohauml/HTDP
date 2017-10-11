#lang racket
#| ---------------------------------------------------------------------------------

   Find Route in Graph: Tests

   find-route : node node graph -> (listof node) or #f
   Purpose: produce a list of nodes, starting with origination 
    and ending destination. The list represent a path from 
    the origination node to the destination node in a-graph.
    If there is no path, the function produces #f. 
|#

(define (find-route origination destination graph)
  (printf "(find-route ~s ~s cyclic-graph)~n" origination destination)
  (cond
    ((eq? origination destination) (list destination))
    (else (local ((define possible-route 
		    (find-route/list (neighbors origination graph) destination graph)))
	    (cond
	      ((boolean? possible-route) #f)
	      (else (cons origination possible-route)))))))

#| find-route/list : (listof node) node graph -> (listof node) or #f
   Purpose: produce a list of nodes, starting with one node on lo-originations 
    and ending destination. The list represent a path from 
    the node on lo-originations to destination in a-graph.
    If there is no path, the function produces #f.     |#
(define (find-route/list lo-Os D graph)
  (printf "(find-route ~s ~s cyclic-graph)~n" lo-Os D)
  (cond
    ((empty? lo-Os) #f)
    (else (local ((define possible-route (find-route (first lo-Os) D graph)))
	    (cond
	      ((boolean? possible-route) (find-route/list (rest lo-Os) D graph))
	      (else possible-route))))))

#| neighbors: node graph -> (listof node)
   (define (neighbors a-node a-graph) ...)
   Purpose: compute a-node's neighbors in a-graph
|#
;(define (neighbors a-node a-graph)
;  (cond
;    ((empty? a-graph) (error 'neighbors "can't happen"))
;    (else (cond
;	    ((eq? (first (first a-graph)) a-node)
;	     (second (first a-graph)))
;	    (else (neighbors a-node (rest a-graph)))))))

;; equivalently, with Scheme's built-in lookup function:
(define (neighbors a-node a-graph)
  (second (assq a-node a-graph)))

#| ---------------------------------------------------------------------------------
   Tests: data followed by expessions |#

(define Cyclic-Graph 
  '((A (B E))
    (B (E F))
    (C (B D))
    (D ())
    (E (C F))
    (F (D G))
    (G ())))

  (find-route 'A 'G Cyclic-Graph )
;= (list 'A 'B 'E 'F 'G)
;
;  (find-route 'C 'G Cyclic-Graph )
;= #f
