;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 36.4.1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(require htdp/draw)

;; dimensions of traffic light
(define WIDTH 50)
(define HEIGHT 160)
(define BULB-RADIUS 20)
(define BULB-DISTANCE 10)
;; the positions of the bulbs
(define X-BULBS (quotient WIDTH 2))
(define Y-RED (+ BULB-DISTANCE BULB-RADIUS))
(define Y-YELLOW (+ Y-RED BULB-DISTANCE (* 2 BULB-RADIUS)))
(define Y-GREEN (+ Y-YELLOW BULB-DISTANCE (* 2 BULB-RADIUS)))
;; draw the light with the red bulb turned on
(start WIDTH HEIGHT)

;; Data Def.: A TL-color is either 'green, 'yellow, or 'red. 

;; State Variable: 
;; current-color : TL-color
;; to keep track of the current color of the traffic light
(define current-color 'red)

;; Contract: next :  ->  void

;; Purpose: the function always produces (void)

;; Effect: to change current-color from 'green to 'yellow, 
;; 'yellow to 'red, and 'red to 'green

;; Header: omitted for this particular example

;; Examples: 
;; if current-color is 'green and we evaluate (next), then current-color is 'yellow
;; if current-color is 'yellow and we evaluate (next), then current-color is 'red
;; if current-color is 'red and we evaluate (next), then current-color is 'green

;; Template: data-directed on state-variable that is to be mutated
;; (define (f)
;;   (cond
;;     [(symbol=? 'green current-color) (set! current-color ...)]
;;     [(symbol=? 'yellow current-color) (set! current-color ...)]
;;     [(symbol=? 'red current-color) (set! current-color ...)]))

; -------------------------------------------------------------------------

;; clear-bulb : symbol -> true
;; to clear one of the traffic bulbs
(define (clear-bulb color)
  (cond
    [(symbol=? color 'red) 
     (and (clear-solid-disk (make-posn X-BULBS Y-RED) BULB-RADIUS)
          (draw-circle (make-posn X-BULBS Y-RED) BULB-RADIUS 'red))]
    [(symbol=? color 'yellow) 
     (and (clear-solid-disk (make-posn X-BULBS Y-YELLOW) BULB-RADIUS)
          (draw-circle (make-posn X-BULBS Y-YELLOW) BULB-RADIUS 'yellow))]
    [(symbol=? color 'green)
     (and (clear-solid-disk (make-posn X-BULBS Y-GREEN) BULB-RADIUS)
          (draw-circle (make-posn X-BULBS Y-GREEN) BULB-RADIUS 'green))]))

;; tests
;(clear-bulb 'red)

; -------------------------------------------------------------------------

;; draw-bulb : symbol -> true
;; to draw a bulb on the traffic light
(define (draw-bulb)
  (cond
    [(symbol=? current-color 'red)
     (and (clear-bulb 'yellow)
          (clear-bulb 'green)
          (draw-solid-disk (make-posn X-BULBS Y-RED) BULB-RADIUS 'red))]
    [(symbol=? current-color 'yellow)
     (and (clear-bulb 'red)
          (clear-bulb 'green)
          (draw-solid-disk (make-posn X-BULBS Y-YELLOW) BULB-RADIUS 'yellow))]
    [(symbol=? current-color 'green)
     (and (clear-bulb 'red)
          (clear-bulb 'yellow)
          (draw-solid-disk (make-posn X-BULBS Y-GREEN) BULB-RADIUS 'green))]))

;; tests
;(draw-bulb)
; -------------------------------------------------------------------------

;; Definition:
(define (next)
  (begin
    (cond
      [(symbol=? 'green current-color) (set! current-color 'yellow)]
      [(symbol=? 'yellow current-color) (set! current-color 'red)]
      [(symbol=? 'red current-color) (set! current-color 'green)])
    (draw-bulb)))


;test
(draw-bulb)
