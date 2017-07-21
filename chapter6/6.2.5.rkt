;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 6.2.5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
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


; -------------------------------------------------------------------------

;; clear-bulb : symbol -> true
;; to clear one of the traffic bulbs
(define (clear-bulb color)
  (cond
    [(symbol=? color 'red) 
     (and (clear-solid-disk (make-posn 25 30) 20)
          (draw-circle (make-posn 25 30) 20 'red))]
    [(symbol=? color 'yellow) 
     (and (clear-solid-disk (make-posn 25 80) 20)
          (draw-circle (make-posn 25 80) 20 'yellow))]
    [(symbol=? color 'green)
     (and (clear-solid-disk (make-posn 25 130) 20)
          (draw-circle (make-posn 25 130) 20 'green))]))

;; tests
;(clear-bulb 'red)

; -------------------------------------------------------------------------

;; draw-bulb : symbol -> true
;; to draw a bulb on the traffic light
(define (draw-bulb color)
  (cond
    [(symbol=? color 'red) 
     (draw-solid-disk (make-posn 25 30) 20 'red)]
    [(symbol=? color 'yellow) 
     (draw-solid-disk (make-posn 25 80) 20 'yellow)]
    [(symbol=? color 'green)
     (draw-solid-disk (make-posn 25 130) 20 'green)]))

;; tests
;(draw-bulb 'green)

; -------------------------------------------------------------------------

;; switch : symbol symbol -> true
;; to switch the traffic light from one color to the next
(define (switch from to)
  (and (clear-bulb from)
       (draw-bulb to)))

;; tests
;(switch 'green 'yellow)
;(switch 'yellow 'red)

; -------------------------------------------------------------------------

;; next : symbol -> symbol
;; to switch a traffic light's current color and to return the next one  
(define (next current-color) 
  (cond 
    [(and (symbol=? current-color 'red) (switch 'red 'green)) 
     'green] 
    [(and (symbol=? current-color 'yellow) (switch 'yellow 'red)) 
     'red] 
    [(and (symbol=? current-color 'green) (switch 'green 'yellow)) 
     'yellow]))


(draw-bulb 'red)
(draw-bulb 'red)
(draw-bulb 'red)
;(next 'red)
;(next 'green)
;(next 'yellow)
;(next 'red)