;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 43.1.6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; Language: Advanced Student

;; [Vector Number] -> [Vector Number]
;; 3-averages for v

(check-expect (ave3 (vector 1 2 3 2 1)) (vector 2 7/3 2))

(define (ave3 v)
 (build-vector (- (vector-length v) 2)
               (lambda (i)
                 (/ (+ (vector-ref v i) (vector-ref v (+ i 1)) (vector-ref v (+ i 2)))
                    3))))

;; [Vector Number] -> Void
;; effect: write the 3-averags of v back into v,
;; for David: sets the leftmost and rightmost position to '-

(define v (vector 1 2 3 2 1))

(check-expect (begin (ave3! v) v) (vector '- 2 7/3 2 '-))

(define (ave3! v)
 (local ((define n (- (vector-length v) 1))

         ;; [0,n) Number -> Void
         ;; effect: set v at i to the average of its immediate neighbors
         ;; accu: pred is v at (vector-ref v (+ i 1))
         (define (aux i pred)
           (cond
             [(= i 0) (vector-set! v i '-)]
             [else (local ((define v@i (vector-ref v i)))
                     (begin (vector-set! v i (/ (+ (vector-ref v (- i 1)) v@i pred) 3))
                            (aux (- i 1) v@i)))]))
         ;; Number
         (define v@n (vector-ref v n)))
   (begin
     (vector-set! v n '-)
     (aux (- n 1) v@n))))