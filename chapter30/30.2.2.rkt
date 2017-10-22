;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 30.2.2) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; route-exists2? : node node simple-graph  ->  boolean
;; to determine whether there is a route from orig to dest in sg
(define (route-exists2? orig dest sg)
  (local ((define (re-accu? orig accu-seen)
            (cond
              [(symbol=? orig dest) true]
              [(contains? orig accu-seen) false]
              [else (re-accu? (neighbor orig sg) (cons orig accu-seen))]))) 
    (re-accu? orig empty)))

(define (contains? node accu)
  (cond
    [(empty? accu) false]
    [(equal? node (first accu)) true]
    [else (contains? node (rest accu))]))

;; neighbor : node simple-graph  ->  node
;; to determine the node that is connected to a-node in sg
(define (neighbor a-node sg)
  (cond
    [(empty? sg) (error "neighbor: impossible")]
    [else (cond
	    [(symbol=? (first (first sg)) a-node)
	     (second (first sg))]
	    [else (neighbor a-node (rest sg))])]))

(define SimpleG 
  '((A B)
    (B C)
    (C E)
    (D E)
    (E B)
    (F F)))