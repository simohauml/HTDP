#lang racket

(define (sort-quick-sort l)
  (if (< (length l) 207)
      (sort1 l)
      (quick-sort l)))

(define (create-tests n)
  (if (= n 0)
      empty
      (cons (random 100)
            (create-tests (- n 1)))))

(define (quick-sort alon) 
  (cond 
    [(empty? alon) empty] 
    [else (append  
           (quick-sort (smaller-items alon (first alon)))  
           (list (first alon))  
           (quick-sort (larger-items (rest alon) (first alon))))])) 

(define (larger-items alon threshold) 
  (cond 
    [(empty? alon) empty] 
    [else (if (>= (first alon) threshold)  
              (cons (first alon) (larger-items (rest alon) threshold)) 
              (larger-items (rest alon) threshold))])) 

(define (smaller-items alon threshold) 
  (cond 
    [(empty? alon) empty] 
    [else (if (< (first alon) threshold)  
              (cons (first alon) (smaller-items (rest alon) threshold)) 
              (smaller-items (rest alon) threshold))])) 

(define (sort1 alon) 
  (local ((define (sort1 alon) 
            (cond 
              [(empty? alon) empty] 
              [(cons? alon) (insert (first alon) 
                                    (sort1 (rest alon)))])) 
          (define (insert an alon) 
            (cond 
              [(empty? alon) (list an)] 
              [else (cond 
                      [(> an (first alon)) (cons an alon)] 
                      [else (cons (first alon)  
                                  (insert an (rest alon)))])]))) 
    (sort1 alon)))


;; TESTS:
(define test-case (create-tests 206))
(collect-garbage)
(time (sort1 test-case))
(collect-garbage)
(time (quick-sort test-case))