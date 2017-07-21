;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 6.6.1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; teachpack: draw.ss
(require htdp/draw)

;;6.6.1
;; DATA DEFINITION

;; A circle is a structure:
;;   (make-circle P R C)
;; where P is a posn describing the center of the circle,
;;       R is a number describing the radius of the circle,
;;   and C is a color.
(define-struct circle (center radius color))

;; DATA EXAMPLES
(make-circle (make-posn 1 1) 1 'red)
(make-circle (make-posn 10 10) 40 'blue)

#|
;; TEMPLATE

(define (fun-for-circles a-circle)
  ... (circle-center a-circle) ...
  ... (circle-radius a-circle) ...
  ... (circle-color a-circle) ...)
|#

; -------------------------------------------------------------------------
;;6.6.2

;; draw-a-disk : circle -> true
;; draws the disk on the screen

(define (draw-a-circle c)
  (draw-circle (circle-center c)
               (circle-radius c)
               (circle-color c)))

;; EXAMPLES TURNED INTO TESTS

;(start 300 300)
;(draw-a-circle (make-circle (make-posn 50 50) 50 'red))

; -------------------------------------------------------------------------
;;6.6.3

;; in-circle? : circle posn -> boolean
;; determines if p is inside the circle c.

;; EXAMPLES
;; the point (6,5) is inside the circle located at (6,5) with radius 1
;; the point (5.5,5) is inside the circle located at (6,5) with radius 1
;; the point (1,5) is outside the circle located at (6,5) with radius 1

;(define (in-circle? c p)
;  (<= (sqrt (+ (sqr (- (posn-x (circle-center c))
;                       (posn-x p)))
;               (sqr (- (posn-y (circle-center c))
;                       (posn-y p)))))
;      (circle-radius c)))

(define (distance p1 p2)
  (sqrt (+ (sqr (- (posn-x p2) (posn-x p1)))
           (sqr (- (posn-y p2) (posn-y p1))))))

(define (in-circle? c p)
  (<= (distance p (circle-center c))
      (circle-radius c)))

;(in-circle? (make-circle (make-posn 6 5) 1 'blue) (make-posn 6 5)) "should be" true
;(in-circle? (make-circle (make-posn 6 5) 1 'green) (make-posn 5.5 5)) "should be" true
;(in-circle? (make-circle (make-posn 6 5) 1 'yellow) (make-posn 1 5)) "should be" false

; -------------------------------------------------------------------------
;;6.6.4

;; translate-circle : circle number -> circle
;; to translate a-circle delta pixels to the right
;(define (translate-circle a-circle delta)
;  (make-circle (make-posn
;                (+ delta (posn-x (circle-center a-circle)))
;                (posn-y (circle-center a-circle)))
;               (circle-radius a-circle)
;               (circle-color a-circle)))

(define (translate-circle c d)
  (make-circle (make-posn
                (+ (posn-x (circle-center c)) d)
                (posn-y (circle-center c)))
               (circle-radius c)
               (circle-color c)))

;; EXAMPLES
;(translate-circle
; (make-circle (make-posn 0 0) 5 'blue)
; 10)
;"should be"
;(make-circle (make-posn 10 0) 5 'blue)

; -------------------------------------------------------------------------
;;6.6.5

;; clear-circle : circle -> true
;; to clear a-circle
(define (clear-a-circle a-circle)
  (clear-circle
   (circle-center a-circle)
   (circle-radius a-circle)))

;; EXAMPLES
;(start 100 100)
;(draw-a-circle (make-circle (make-posn 50 50) 25 'red))
;(sleep-for-a-while 10)
;(clear-a-circle (make-circle (make-posn 50 50) 25 'red))

; -------------------------------------------------------------------------
;;6.6.6

(define (draw-and-clear-circle c)
  (and (draw-a-circle c)
       (sleep-for-a-while 1)
       (clear-a-circle c)))

;; EXAMPLES
;(start 100 100)
;(draw-and-clear-circle (make-circle (make-posn 50 50) 50 'blue))

;; move-circle : number circle -> circle
;; to draw and clear a circle and then to move it by delta pixels 
(define (move-circle delta a-circle) 
  (cond 
    [(draw-and-clear-circle a-circle) (translate-circle a-circle delta)] 
    [else a-circle])) 

;(start 200 100)
;(draw-a-circle 
; (move-circle 
;  10 
;  (move-circle
;   10 
;   (move-circle
;    10 
;    (move-circle
;     10 
;     (make-circle (make-posn 10 50) 10 'green))))))

; -------------------------------------------------------------------------
;;6.6.7

;; A rectangle is a structure:
;;   (make-rectangle P W H)
;; where P is a posn, W is a number and H is a number.
(define-struct rectangle (nw-corner width height color))

;; DATA EXAMPLES
(define example-rectangle1 (make-rectangle (make-posn 20 20) 260 260 'red))
(define example-rectangle2 (make-rectangle (make-posn 60 60) 180 180 'blue))

#|
;; Template
(define (fun-for-rectangle a-rectangle)
  ... (rectangle-nw-corner a-rectangle) ...
  ... (rectangle-width a-rectangle) ...
  ... (rectangle-height a-rectangle) ...
  ... (rectangle-color a-rectangle) ...)
|#

; -------------------------------------------------------------------------
;;6.6.8

;; draw-a-rectangle : rectangle -> true
;; to draw a-rect
(define (draw-a-rectangle a-rectangle)
  (draw-solid-rect
   (rectangle-nw-corner a-rectangle)
   (rectangle-width a-rectangle)
   (rectangle-height a-rectangle)
   (rectangle-color a-rectangle)))

;; EXAMPLES
;(start 300 300)
;(draw-a-rectangle example-rectangle1)
;(draw-a-rectangle example-rectangle2)

; -------------------------------------------------------------------------
;;6.6.9

;; in-rectangle? : rectangle posn -> boolean
;; to determine if a-posn is in a-rectangle, or not
(define (in-rectangle? a-rectangle a-posn)
  (and (<= (posn-x (rectangle-nw-corner a-rectangle))
           (posn-x a-posn)
           (+ (posn-x (rectangle-nw-corner a-rectangle))
              (rectangle-width a-rectangle)))
       (<= (posn-y (rectangle-nw-corner a-rectangle))
           (posn-y a-posn)
           (+ (posn-y (rectangle-nw-corner a-rectangle))
              (rectangle-height a-rectangle)))))

;; EXAMPLES AS TESTS
;(in-rectangle? example-rectangle1 (make-posn 0 0)) "should be" false
;(in-rectangle? example-rectangle1 (make-posn 25 0)) "should be" false
;(in-rectangle? example-rectangle1 (make-posn 0 25)) "should be" false
;(in-rectangle? example-rectangle1 (make-posn 25 25)) "should be" true

; -------------------------------------------------------------------------
;;6.6.10

;; translate-rectangle : rectangle number -> rectangle
;; to translate a-rectangle horizontally by x pixels 
(define (translate-rectangle a-rectangle x)
  (make-rectangle (make-posn
                   (+ x (posn-x (rectangle-nw-corner a-rectangle)))
                   (posn-y (rectangle-nw-corner a-rectangle)))
                  (rectangle-width a-rectangle)
                  (rectangle-height a-rectangle)
                  (rectangle-color a-rectangle)))

;; EXAMPLES AS TESTS
;(translate-rectangle example-rectangle1 30)
;"should be"
;(make-rectangle (make-posn 50 20) 260 260 'red)

; -------------------------------------------------------------------------
;;6.6.11

;; clear-a-rectangle : rectangle -> true
;; to erase a rectangle
(define (clear-a-rectangle a-rectangle)
  (clear-solid-rect 
   (rectangle-nw-corner a-rectangle)
   (rectangle-width a-rectangle)
   (rectangle-height a-rectangle)))

;; EXAMPLES
;(start 300 300)
;(draw-a-rectangle example-rectangle1)
;(draw-a-rectangle example-rectangle2)
;(clear-a-rectangle example-rectangle1)
;(clear-a-rectangle example-rectangle2)


; -------------------------------------------------------------------------
;;6.6.12

(define (draw-and-clear-rectangle r)
  (and (draw-a-rectangle r)
       (sleep-for-a-while 1)
       (clear-a-rectangle r)))
;; move-rectangle : number rectangle -> rectangle
;; to draw and clear a rectangle, translate it by delta pixels
(define (move-rectangle delta a-rectangle)
  (cond
    [(draw-and-clear-rectangle a-rectangle)
     (translate-rectangle a-rectangle delta)]
    [else a-rectangle]))

(start 500 300)
(draw-a-rectangle 
 (move-rectangle
  10 
  (move-rectangle
   10 
   (move-rectangle
    10 
    (move-rectangle
     10 
     example-rectangle1)))))