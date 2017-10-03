;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 27.1.5) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))

(define (midpoint p1 p2)
  (make-posn (/ (+ (posn-x p1) (posn-x p2)) 2)
             (/ (+ (posn-y p1) (posn-y p2)) 2)))

;; distance : posn posn -> number
(define (distance a b)
  (sqrt (+ (sqr (- (posn-x a) (posn-x b)))
           (sqr (- (posn-y a) (posn-y b))))))

(define (draw-curve p1 p2 p3)
  (and (draw-solid-line p1 p2 'red)
       (draw-solid-line p2 p3 'red)))

(define (too-small? p1 p2 p3)
  (local ((define threshold 20))
    (if (or (< (distance p1 p2) threshold)
            (< (distance p2 p3) threshold))
        true
        false)))

(define (draw-triangle p1 p2 p3)
  (and (draw-solid-line p1 p2)
       (draw-solid-line p2 p3)
       (draw-solid-line p3 p1)))

(define (bezier p1 p2 p3)
  (cond
    [(too-small? p1 p2 p3) (draw-curve p1 p2 p3)]
    [else (local ((define r2 (midpoint p1 p2))
                  (define q2 (midpoint p2 p3))
                  (define m (midpoint r2 q2)))
            (and (bezier p1 r2 m)
                 (bezier m q2 p3)))]))


(define p1 (make-posn 50 50))
(define p2 (make-posn 150 150))
(define p3 (make-posn 250 100))

(start 300 200)
(draw-triangle p1 p2 p3)
(bezier p1 p2 p3)