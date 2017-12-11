;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 39.1.3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(require htdp/draw)

;; dimensions of traffic light
(define WIDTH 300)
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

;; Auxiliary functions for View
;; clear-bulb : symbol -> true
;; to clear one of the traffic bulbs
(define (clear-bulb color x-posn)
  (cond
    [(symbol=? color 'red) 
     (and (clear-solid-disk (make-posn x-posn Y-RED) BULB-RADIUS)
          (draw-circle (make-posn x-posn Y-RED) BULB-RADIUS 'red))]
    [(symbol=? color 'yellow) 
     (and (clear-solid-disk (make-posn x-posn Y-YELLOW) BULB-RADIUS)
          (draw-circle (make-posn x-posn Y-YELLOW) BULB-RADIUS 'yellow))]
    [(symbol=? color 'green)
     (and (clear-solid-disk (make-posn x-posn Y-GREEN) BULB-RADIUS)
          (draw-circle (make-posn x-posn Y-GREEN) BULB-RADIUS 'green))]))

;; tests
;(clear-bulb 'red)

; -------------------------------------------------------------------------

;; View:
;; draw-light : TL-color number  ->  true
;; to (re)draw the traffic light on the canvas 
(define (draw-light current-color x-posn)
  (cond
    [(symbol=? current-color 'red)
     (and (clear-bulb 'yellow x-posn)
          (clear-bulb 'green x-posn)
          (draw-solid-disk (make-posn x-posn Y-RED) BULB-RADIUS 'red))]
    [(symbol=? current-color 'yellow)
     (and (clear-bulb 'red x-posn)
          (clear-bulb 'green x-posn)
          (draw-solid-disk (make-posn x-posn Y-YELLOW) BULB-RADIUS 'yellow))]
    [(symbol=? current-color 'green)
     (and (clear-bulb 'red x-posn)
          (clear-bulb 'yellow x-posn)
          (draw-solid-disk (make-posn x-posn Y-GREEN) BULB-RADIUS 'green))]))

;; Model:
;; make-traffic-light : symbol number  ->  ( ->  true)
;; to create a red light with (make-posn x-posn 0) as the upper-left corner
;; effect: draw the traffic light on the canvas
(define (make-traffic-light street x-posn)
  (local (;; current-color : TL-color
          ;; to keep track of the current color of the traffic light
          (define current-color 'red)
	  
	  ;; init-traffic-light :  ->  true
	  ;; to (re)set current-color to red and to (re)create the view 
	  (define (init-traffic-light)
	    (begin
	      (set! current-color 'red)
	      (draw-light current-color x-posn)))
	  
          ;; next :  ->  true
          ;; effect: to change current-color from 'green to 'yellow, 
          ;; 'yellow to 'red, and 'red to 'green
          (define (next)
            (begin
              (set! current-color (next-color current-color))
              (draw-light current-color x-posn)))
	  
          ;; next-color : TL-color  ->  TL-color
          ;; to compute the successor of current-color based on the traffic laws
          (define (next-color current-color)
            (cond
              [(symbol=? 'green current-color) 'yellow]
              [(symbol=? 'yellow current-color) 'red]
              [(symbol=? 'red current-color) 'green])))
    (begin
      ;; Initialize and produce next
      (init-traffic-light)
      next)))

;; lights : (listof traffic-light)
;; to manage the lights along Sunrise 
(define lights
  (list (make-traffic-light 'sunrise@rice 50)
        (make-traffic-light 'sunrise@cmu 150)
        (make-traffic-light 'sunrise@meu 250)))

