;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 18.1.7) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(require htdp/draw)
;; a shape is either:
;;   - (make-circle C P N)
;;   - (make-rectangle C P N N)
;; where C is a color,
;;       P is a posn, and
;;       N is a number.

(define-struct circle (color center radius))
(define-struct rectangle (color nw-corner width height))

#|
;; TEMPLATE
(define (prog-for-shape a-shape)
  (cond
    [(circle? a-shape) 
     (circle-color a-shape) ...
     (circle-center a-shape) ...
     (circle-radius a-shape) ...]
    [(rectangle? a-shape)
     (rectangle-color a-shape) ...
     (rectangle-nw-corner a-shape) ...
     (rectangle-width a-shape) ...
     (rectangle-height a-shape) ...]))
|#

; -------------------------------------------------------------------------

;; draw-shape : shape -> true
;; draws a-shape
(define (draw-shape a-shape)
  (cond
    [(circle? a-shape) 
     (draw-circle
      (circle-center a-shape)
      (circle-radius a-shape)
      (circle-color a-shape))]
    [(rectangle? a-shape)
     (draw-solid-rect 
      (rectangle-nw-corner a-shape)
      (rectangle-width a-shape)
      (rectangle-height a-shape)
      (rectangle-color a-shape))]))

;; EXAMPLES AS TESTS
(start 200 200)
(draw-shape (make-circle 'red (make-posn 30 30) 20)) "should be" true
(draw-shape (make-rectangle 'blue (make-posn 30 60) 20 50)) "should be" true

; -------------------------------------------------------------------------

;; translate-shape : shape number -> true
;; translates a-shape by delta pixels in the X directions
(define (translate-shape a-shape delta)
  (cond
    [(circle? a-shape) 
     (make-circle      
      (circle-color a-shape)
      (make-posn (+ delta (posn-x (circle-center a-shape)))
                 (posn-y (circle-center a-shape)))
      (circle-radius a-shape))]
    [(rectangle? a-shape)
     (make-rectangle
      (rectangle-color a-shape)
      (make-posn (+ delta (posn-x (rectangle-nw-corner a-shape)))
                 (posn-y (rectangle-nw-corner a-shape)))
      (rectangle-width a-shape)
      (rectangle-height a-shape))]))

;; EXAMPLES AS TESTS
(translate-shape (make-circle 'red (make-posn 30 30) 20) 10) "should be" 
(make-circle 'red (make-posn 40 30) 20)
(translate-shape (make-rectangle 'blue (make-posn 30 60) 20 50) 20) "should be" 
(make-rectangle 'blue (make-posn 50 60) 20 50)

; -------------------------------------------------------------------------

;; clear-shape : shape -> true
;; erases a-shape
(define (clear-shape a-shape)
  (cond
    [(circle? a-shape) 
     (draw-circle
      (circle-center a-shape)
      (circle-radius a-shape)
      'white)]
    [(rectangle? a-shape)
     (draw-solid-rect 
      (rectangle-nw-corner a-shape)
      (rectangle-width a-shape)
      (rectangle-height a-shape)
      'white)]))

;; EXAMPLES AS TESTS
(start 200 200)
(draw-shape (make-circle 'red (make-posn 30 30) 20)) "should be" true
(draw-shape (make-rectangle 'blue (make-posn 30 60) 20 50)) "should be" true
(clear-shape (make-circle 'red (make-posn 30 30) 20)) "should be" true
(clear-shape (make-rectangle 'blue (make-posn 30 60) 20 50)) "should be" true

; -------------------------------------------------------------------------


;; A list-of-shapes is either:
;;  - empty, or
;;  - (cons shape list-of-shapes)

#|
;; TEMPLATE
(define (prog-for-losh a-los)
  (cond
    [(empty? a-los) ...]
    [else (first a-los) ...
          (prog-for-losh (rest a-los))..]))
|#

(define FACE
  (cons (make-circle 'red (make-posn 50 50) 50)
        (cons (make-rectangle 'blue (make-posn 30 20) 10 10)
              (cons (make-rectangle 'blue (make-posn 65 20) 10 10)
                    (cons (make-rectangle 'blue (make-posn 40 75) 10 10)
                          (cons (make-rectangle 'blue (make-posn 40 75) 25 10)
                                (cons (make-rectangle 'blue (make-posn 45 35) 15 30)
                                      empty)))))))

; -------------------------------------------------------------------------

;; draw-losh : list-of-shapes -> true
;; draws each shape on a-los
(define (draw-losh a-los)
  (cond
    [(empty? a-los) true]
    [else (and (draw-shape (first a-los))
               (draw-losh (rest a-los)))]))

;; EXAMPLES AS TESTS
(start 100 100)
(draw-losh empty) "should be" true
(draw-losh (cons (make-circle 'red (make-posn 50 50) 40) empty)) "should be" true

; -------------------------------------------------------------------------


;; translate-losh : list-of-shapes number -> list-of-shapes
;; moves each shape on the list of shapes by delta
;(define (translate-losh a-los delta)
;  (cond
;    [(empty? a-los) empty]
;    [else (cons (translate-shape (first a-los) delta)
;                (translate-losh (rest a-los) delta))]))
;
;;; EXAMPLES AS TESTS
;(translate-losh empty 20) "should be" empty
;(translate-losh (cons (make-circle 'red (make-posn 50 50) 40) empty) 20)
;"should be"
;(cons (make-circle 'red (make-posn 70 50) 40) empty)

; -------------------------------------------------------------------------


;; clear-losh : list-of-shapes -> true
;; clear each shape on a-los
;(define (clear-losh a-los)
;  (cond
;    [(empty? a-los) true]
;    [else (and (clear-shape (first a-los))
;               (clear-losh (rest a-los)))]))
;
;;; EXAMPLES AS TESTS
;(start 100 100)
;(draw-shape (make-circle 'red (make-posn 50 50) 40)) "should be" true
;(clear-losh empty) "should be" true
;(clear-losh (cons (make-circle 'red (make-posn 50 50) 40) empty)) "should be" true

; -------------------------------------------------------------------------

;; move : number list-of-shapes -> list-of-shapes
;; moves each shape on the screen, delta pixels
(define (move-picture delta 1-los)
  (local 
    ((define (move-picture delta a-los)
       (cond
         [(and 
           (draw-losh (translate-losh a-los delta))
           (sleep-for-a-while 1)
           (clear-losh (translate-losh a-los delta)))
          (translate-losh a-los delta)]
         [else a-los]))
     
     (define (translate-losh a-los delta)
       (cond
         [(empty? a-los) empty]
         [else (cons (translate-shape (first a-los) delta)
                     (translate-losh (rest a-los) delta))]))
     (define (translate-shape a-shape delta)
       (cond
         [(circle? a-shape) 
          (make-circle      
           (circle-color a-shape)
           (make-posn 
            (+ delta (posn-x (circle-center a-shape)))
            (posn-y (circle-center a-shape)))
           (circle-radius a-shape))]
         [(rectangle? a-shape)
          (make-rectangle
           (rectangle-color a-shape)
           (make-posn 
            (+ delta (posn-x (rectangle-nw-corner a-shape)))
            (posn-y (rectangle-nw-corner a-shape)))
           (rectangle-width a-shape)
           (rectangle-height a-shape))]))
     (define (clear-losh a-los)
       (cond
         [(empty? a-los) true]
         [else (and (clear-shape (first a-los))
                    (clear-losh (rest a-los)))]))
     (define (clear-shape a-shape)
       (cond
         [(circle? a-shape) 
          (draw-circle
           (circle-center a-shape)
           (circle-radius a-shape)
           'white)]
         [(rectangle? a-shape)
          (draw-solid-rect 
           (rectangle-nw-corner a-shape)
           (rectangle-width a-shape)
           (rectangle-height a-shape)
           'white)])))
    (move-picture delta 1-los)))

;; EXAMPLES AS TESTS
(start 500 100)

(draw-losh
 (move-picture 
  -5
  (move-picture
   23
   (move-picture
    10
    FACE))))

(start 500 100)
(draw-losh FACE)
(control-left-right FACE 100 move-picture draw-losh) 