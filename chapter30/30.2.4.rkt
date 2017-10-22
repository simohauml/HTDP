;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 30.2.4) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define Graph 
  '((A (B E))
    (B (E F))
    (C (D))
    (D ())
    (E (C F))
    (F (D G))
    (G ())))

(define Cyclic-Graph 
  '((A (B E))
    (B (E F))
    (C (B D))
    (D ())
    (E (C F))
    (F (D G))
    (G ())))

(define (find-route-out ori dest G)
  (find-route ori dest G empty))

;(define (find-route origination destination G accu-seen)
;  (local ((define (find-route/list lo-Os)
;            (cond
;              [(empty? lo-Os) false]
;              [else (local ((define possible-route
;                              (find-route (first lo-Os)
;                                          destination
;                                          G
;                                          (cons (first lo-Os) accu-seen))))
;                      (cond
;                        [(boolean? possible-route) (find-route/list (rest lo-Os))]
;                        [else possible-route]))])))
;    (cond
;      [(symbol=? origination destination) (list destination)]
;      [(contains? origination accu-seen) false]
;      [else (local ((define possible-route 
;                      (find-route/list (neighbors origination G))))
;              (cond
;                [(boolean? possible-route) false]
;                [else (cons origination possible-route)]))])))

(define (find-route origination destination G accu-seen)
  (local ((define (find-route/list lo-Os accu)
            (cond
              [(empty? lo-Os) false]
              [else (local ((define possible-route
                              (find-route (first lo-Os)
                                          destination
                                          G
                                          accu)))
                      (cond
                        [(boolean? possible-route) (find-route/list (rest lo-Os)
                                                                    (cons (first lo-Os) accu))]
                        [else possible-route]))])))
    (cond
      [(symbol=? origination destination) (list destination)]
      [(contains? origination accu-seen) false]
      [else (local ((define possible-route 
                      (find-route/list (neighbors origination G) (cons origination accu-seen))))
              (cond
                [(boolean? possible-route) false]
                [else (cons origination possible-route)]))])))

#| neighbors: node graph -> (listof node)
   (define (neighbors a-node a-graph) ...)

   Purpose: compute a-node's neighbors in a-graph

   Example:
     in figure~xyz,
       G has no neighbors: empty
       A has the list of neighbors (list 'B 'E)
|#
(define (neighbors a-node a-graph)
  (cond
    ((empty? a-graph) (error 'neighbors "can't happen"))
    (else (cond
            ((eq? (first (first a-graph)) a-node)
             (second (first a-graph)))
            (else (neighbors a-node (rest a-graph)))))))

(define (contains? node accu)
  (cond
    [(empty? accu) false]
    [(and (equal? node (first accu)) (= 1 (length accu))) false]
    [(equal? node (first accu)) true]
    [else (contains? node (rest accu))]))

(define (contain-twice? node accu)
  (cond
    [(empty? accu) false]
    [(> (count node accu) 1) true]
    [else false]))

(define (count node accu)
  (cond
    [(empty? accu) 0]
    [(equal? node (first accu)) (+ 1 (count node (rest accu)))]
    [else (count node (rest accu))]))