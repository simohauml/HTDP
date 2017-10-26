;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 31.3.8) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; is-prime? : N[>=1]  ->  boolean
;; to determine whether n is a prime number
;(define (is-prime? n)
;  (cond
;    [(= n 1) ...]
;    [else ... (is-prime? (sub1 n)) ...]))

;(define (is-prime? n)
;  (local ((define (prime?-acc n nn)
;            (cond
;              [(= n 1) true]
;              [(and (not (= n nn))
;                    (= (remainder nn n) 0)) false]
;              [else (prime?-acc (sub1 n) nn)])))
;    (prime?-acc n n)))

;(filter is-prime? (rest (build-list 100 (lambda (x) x))))

; the Sieve of Eratosthenes
(define (prime-filter1 lon)
  (local ((define (pri?-acc lon index)
            (cond
              [(empty? lon) empty]
              [else
               (local ((define root (list-ref lon index)))
                 (cond
                   [(= index (- (length lon) 1)) lon]
                   [else (pri?-acc
                          (filter (lambda (x)
                                    (or (= x root)
                                        (not (= (remainder x root) 0)))) lon)
                          (add1 index))]))])))
    (pri?-acc lon 0)))

(define (prime-filter2 lon)
  (local ((define (pri?-acc lon accu)
            (cond
              [(empty? lon) accu]
              [else (local ((define root (first lon))
                            (define filtered
                              (filter (lambda (x)
                                        (or (= x root)
                                            (not (= (remainder x root) 0))))
                                      lon)))
                      (pri?-acc (rest filtered)
                                (append accu
                                        (list (first filtered)))))])))
    (pri?-acc lon empty)))

(time (prime-filter1 (build-list 1000 (lambda (x) (+ 2 x)))))
(time (prime-filter2 (build-list 1000 (lambda (x) (+ 2 x)))))
              

; Does not work
;(define (is-prime? n)
;   (local (;; accumulator : keeps track of the original input to is-prime?
;           ;; (Note: since it is available it is unnecessary! This is not
;           ;; a necessary use of accumulators, and you can see it because
;           ;; the accumulator remains the same.)
;           [define (check i n)
;             (cond
;               [(= i 1) true]
;               [else (and (not (= (remainder n i) 0)) 
;                          (check (sub1 i) n))])])
;     (check (- n 1) n)))