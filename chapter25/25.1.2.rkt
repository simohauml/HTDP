;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 25.1.2) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; TeachPack: draw.ss 

(define-struct ball (x y delta-x delta-y))
;; A ball is a structure: 
;;   (make-ball number number number number)

;; draw-and-clear : a-ball  ->  true
;; draw, sleep, clear a disk from the canvas 
;; structural design, Scheme knowledge
(define (draw-and-clear a-ball)
  (and
   (draw-solid-disk (make-posn (ball-x a-ball) (ball-y a-ball)) 5 'red)
   (sleep-for-a-while DELAY)
   (clear-solid-disk (make-posn (ball-x a-ball) (ball-y a-ball)) 5 'red)))

;; move-ball : ball  ->  ball
;; to create a new ball, modeling a move by a-ball
;; structural design, physics knowledge
(define (move-ball a-ball) 
  (make-ball (+ (ball-x a-ball) (ball-delta-x a-ball))
             (+ (ball-y a-ball) (ball-delta-y a-ball))
             (ball-delta-x a-ball)
             (ball-delta-y a-ball)))

;; in-bounds? : Ball  ->  boolean
;; to determine whether a-ball is outside of the bounds
;; domain knowledge, geometry
(define (in-bounds? a-ball)
  (and (<= 0 (ball-x a-ball) WIDTH)
       (<= 0 (ball-y a-ball) HEIGHT)))

;; out-of-bounds? : a-ball  ->  boolean
;; to determine whether a-ball is outside of the bounds
;; domain knowledge, geometry
(define (out-of-bounds? a-ball)
  (not
   (and
     (<= 0 (ball-x a-ball) WIDTH)
     (<= 0 (ball-y a-ball) HEIGHT))))

;; move-until-out : a-ball  ->  true
;; to model the movement of a ball until it goes out of bounds
(define (move-until-out a-ball)
  (cond
    [(out-of-bounds? a-ball) true]
    [else (and (draw-and-clear a-ball)
               (move-until-out (move-ball a-ball)))]))

;; move-balls : (Listof Ball) -> true
;; move all balls until all of them are out of bounds

;; loop version
(define (move-balls lob)
  (cond
    [(empty? lob) true]
    [else (and (andmap draw-and-clear lob) ;; **full credit without this line**
               (move-balls (map move-ball (filter in-bounds? lob))))]))

;; Dimension of canvas 
(define WIDTH 500)
(define HEIGHT 500)
(define DELAY .1)

(start WIDTH HEIGHT)
(move-balls (list (make-ball 10 20 0 5) (make-ball 100 20 0 5)))
(stop)