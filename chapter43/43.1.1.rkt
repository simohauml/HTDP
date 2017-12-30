;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 43.1.1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; in-place-sort : (vectorof number)  ->  void
;; effect: to modify V such that it contains the same items 
;; as before but in ascending order 
(define (in-place-sort V)
  (local (;; sort-aux : (vectorof number) N  ->  void
          ;; effect: to sort the interval [0,i) of V in place 
          (define (sort-aux V i)
            (cond
              [(zero? i) (void)]
              [else (begin
                      ;; sort the segment [0,(sub1 i)):
                      (sort-aux V (sub1 i))
                      ;; insert (vector-ref V (sub1 i)) into the segment 
                      ;; [0,i) so that it becomes sorted''
                      (insert (sub1 i) V))]))
	  
          ;; insert : N (vectorof number)  ->  void
          ;; to place the value in the i-th into its proper place 
          ;; in the [0,i] segement of V
          (define (insert i V) 
            (cond
              [(zero? i) (void)]
              [else (cond
                      [(> (vector-ref V (sub1 i)) (vector-ref V i)) 
                       (begin
                         (swap V (- i 1) i)
                         (insert (sub1 i) V))]
                      [else (void)])]))
	  
          ;; swap : (vectorof X) N N void 
          (define (swap V i j)
            (local ((define temp (vector-ref V i)))
              (begin
                (vector-set! V i (vector-ref V j))
                (vector-set! V j temp)))))
    (sort-aux V (vector-length V))))

;; test
(define v1 (vector 7 4 2 5 3 6 1 0))
(begin
  (in-place-sort v1)
  (equal? v1
          (vector 0 1 2 3 4 5 6 7)))