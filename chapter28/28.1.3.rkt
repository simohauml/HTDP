;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 28.1.3) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
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