;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 27.1.2) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define CENTER (make-posn 200 200))

(define RADIUS 200)

;; cicrcl-pt : number  ->  posn
;; to compute a position on the circle with CENTER
;; and RADIUS as defined above 
;; cicrcle-pt : number -> posn 
;; to compute a position on the circle with CENTER 
;; and RADIUS as defined above 
(define (circle-pt factor)
  (local ((define factor->radians (* factor (* 2 3.14))))
    (make-posn (+ (posn-x CENTER) (* 200 (cos factor->radians)))
               (+ (posn-y CENTER) (* 200 (sin factor->radians))))))

(define A (circle-pt 120/360))
(define B (circle-pt 240/360))
(define C (circle-pt 360/360))

;; sierpinski : posn posn posn  ->  true
;; to draw a Sierpinski triangle down at a, b, and c,
;; assuming it is large enough
(define (sierpinski a b c)
  (cond
    [(too-small? a b c) true]
    [else 
      (local ((define a-b (mid-point a b))
	      (define b-c (mid-point b c))
	      (define c-a (mid-point a c)))
	(and
	  (draw-triangle a b c)	    
	  (sierpinski a a-b c-a)
	  (sierpinski b a-b b-c)
	  (sierpinski c c-a b-c)))]))

;; mid-point : posn posn  ->  posn
;; to compute the mid-point between a-posn and b-posn
(define (mid-point a-posn b-posn)
  (make-posn
    (mid (posn-x a-posn) (posn-x b-posn))
    (mid (posn-y a-posn) (posn-y b-posn))))

;; mid : number number  ->  number
;; to compute the average of x and y
(define (mid x y)
  (/ (+ x y) 2))

;; draw-triangle  posn posn posn -> true
(define (draw-triangle a b c)
  (and (draw-solid-line a b)
       (draw-solid-line b c)
       (draw-solid-line c a)))

;; too-small? : posn posn posn -> bool
(define (too-small? a b c)
  (local ((define threshold 10))
    (or (> threshold (distance a b))
        (> threshold (distance b c))
        (> threshold (distance c a)))))

;; distance : posn posn -> number
(define (distance a b)
  (sqrt (+ (sqr (- (posn-x a) (posn-x b)))
           (sqr (- (posn-y a) (posn-y b))))))


(start 400 400)
(sierpinski A B C)