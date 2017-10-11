;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 28.1.4) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; Here is a translation of the definition of Graph: 
(define Graph 
  (list (list 'A (list 'B 'E))
        (list 'B (list 'E 'F))
        (list 'C (list 'D))
        (list 'D empty)
        (list 'E (list 'C 'F))
        (list 'F (list 'D 'G))
        (list 'G empty)))

;; find-route : node node graph  ->  (listof node) or false
;; to create a path from origination to destination in G
;; if there is no path, the function produces false
(define (find-route origination destination G)
  (cond
    [(symbol=? origination destination) (list destination)]
    [else (local ((define possible-route 
                    (find-route/list (neighbors origination G) destination G)))
            (cond
              [(boolean? possible-route) false]
              [else (cons origination possible-route)]))]))

;; find-route/list : (listof node) node graph  ->  (listof node) or false
;; to create a path from some node on lo-Os to D
;; if there is no path, the function produces false
(define (find-route/list lo-Os D G)
  (cond
    [(empty? lo-Os) false]
    [else (local ((define possible-route (find-route (first lo-Os) D G)))
            (cond
              [(boolean? possible-route) (find-route/list (rest lo-Os) D G)]
              [else possible-route]))]))

;;; equivalently, with Scheme's built-in lookup function:
(define (neighbors a-node a-graph)
  (second (assq a-node a-graph)))

(define (test-on-all-nodes a-graph)
  (local ((define all-nodes (map first a-graph)))
    (map (lambda (a-node)
	   (map (lambda (another-node)
		  (list a-node another-node
		        (find-route a-node another-node a-graph)))
	        all-nodes))
          all-nodes)))

;(define (test-on-all-nodes g)
;  (local ((define allpairs (get-all-pairs (get-all-start-nodes g)))
;          (define (test-on-all-nodes-aux g pairs)
;            (cond
;              [(empty? pairs) empty]
;              [else (append (list (find-route (first (first pairs))
;                                              (second (first pairs))
;                                              g)
;                                  (find-route (second (first pairs))
;                                              (first (first pairs))
;                                              g))
;                            (test-on-all-nodes-aux g (rest pairs)))])))
;    (test-on-all-nodes-aux g allpairs)))
;
;(define (get-all-start-nodes g)
;  (cond
;    [(empty? g) empty]
;    [else (cons (first (first g)) (get-all-start-nodes (rest g)))]))
;
(define (get-all-pairs nodes)
  (map (lambda (a-node)
         (map (lambda (b-node)
                (list a-node b-node))
              nodes))
       nodes))
;(define (get-all-pairs nodes)
;  (cond
;    [(empty? nodes) empty]
;    [(empty? (rest nodes)) empty]
;    [else (local ((define node1 (first nodes))
;                  (define pair1 (list (list node1 (second nodes))))
;                  (define pairst (get-all-pairs-aux (remove-second nodes))))
;            (append pair1
;                    pairst
;                    (get-all-pairs (rest nodes))))]))
;
;(define (get-all-pairs-aux nodes)
;  (cond
;    [(empty? nodes) empty]
;    [(empty? (rest nodes)) empty]
;    [else (local ((define node1 (first nodes))
;                  (define pair1 (list (list node1 (second nodes))))
;                  (define pairst (get-all-pairs-aux (remove-second nodes))))
;            (append pair1
;                    pairst))]))
;
;(define (remove-second nodes)
;  (cond
;    [(empty? nodes) empty]
;    [(empty? (rest nodes)) empty]
;    [else (cons (first nodes) (rest (rest nodes)))]))

;(test-on-all-nodes Graph)
(define nodes (map first Graph))
;(get-all-pairs n)