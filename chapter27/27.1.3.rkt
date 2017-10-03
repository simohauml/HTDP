;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 27.1.3) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define CENTER (make-posn 200 200))
(define RADIUS 200)
(define-struct triangle (pA pB pC))

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

(define tri1 (make-triangle A B C))
;; sierpinski : triangle  ->  true
;; to draw a Sierpinski triangle down at triangle (a, b, and c),
;; assuming it is large enough
(define (sierpinski a-triangle)
  (cond
    [(too-small? a-triangle) true]
    [else 
      (local ((define a-b (mid-point (triangle-pA a-triangle) (triangle-pB a-triangle)))
	      (define b-c (mid-point (triangle-pB a-triangle) (triangle-pC a-triangle)))
	      (define c-a (mid-point (triangle-pC a-triangle) (triangle-pA a-triangle)))
              (define inner-triA (make-triangle (triangle-pA a-triangle) a-b c-a))
              (define inner-triB (make-triangle (triangle-pB a-triangle) a-b b-c))
              (define inner-triC (make-triangle (triangle-pC a-triangle) c-a b-c)))
	(and
	  (draw-triangle a-triangle)
	  (sierpinski inner-triA)
	  (sierpinski inner-triB)
	  (sierpinski inner-triC)))]))

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
(define (draw-triangle a-triangle)
  (and (draw-solid-line (triangle-pA a-triangle) (triangle-pB a-triangle))
       (draw-solid-line (triangle-pB a-triangle) (triangle-pC a-triangle))
       (draw-solid-line (triangle-pC a-triangle) (triangle-pA a-triangle))))

;; too-small? : posn posn posn -> bool
(define (too-small? a-triangle)
  (local ((define threshold 10))
    (or (> threshold (distance (triangle-pA a-triangle) (triangle-pB a-triangle)))
        (> threshold (distance (triangle-pB a-triangle) (triangle-pC a-triangle)))
        (> threshold (distance (triangle-pC a-triangle) (triangle-pA a-triangle))))))

;; distance : posn posn -> number
(define (distance a b)
  (sqrt (+ (sqr (- (posn-x a) (posn-x b)))
           (sqr (- (posn-y a) (posn-y b))))))


(start 400 400)
(sierpinski tri1)