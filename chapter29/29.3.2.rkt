;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 29.3.2) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define (find-route origination destination graph)
  ;(printf "(find-route ~s ~s cyclic-graph)~n" origination destination)
  (cond
    ((eq? origination destination) (list destination))
    (else (local ((define (neighbors a-node a-graph)
                    (vector-ref a-graph a-node))
                  (define (find-route/list lo-Os D graph)
                    ;(printf "(find-route ~s ~s cyclic-graph)~n" lo-Os D)
                    (cond
                      ((empty? lo-Os) #f)
                      (else (local ((define (neighbors a-node a-graph)
                                      (vector-ref a-graph a-node))
                                    (define possible-route (find-route (first lo-Os) D graph)))
                              (cond
                                ((boolean? possible-route) (find-route/list (rest lo-Os) D graph))
                                (else possible-route))))))
                  (define possible-route 
                    (find-route/list (neighbors origination graph) destination graph)))
            (cond
              ((boolean? possible-route) #f)
              (else (cons origination possible-route)))))))

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
;(define (neighbors node graph)
;  (vector-ref graph node))