;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 39.1.1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; View:
;; draw-light : TL-color number  ->  true
;; to (re)draw the traffic light on the canvas 
;(define (draw-light current-color x-posn) ...))

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
	      ;(draw-light current-color x-posn)
              ))
	  
          ;; next :  ->  true
          ;; effect: to change current-color from 'green to 'yellow, 
          ;; 'yellow to 'red, and 'red to 'green
          (define (next)
            (begin
              (set! current-color (next-color current-color))
              ;(draw-light current-color x-posn)
              ))
	  
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
        (make-traffic-light 'sunrise@cmu 150)))

(define light (make-traffic-light 'sunrise@me 350))


;> ((second lights)) 
;true

;The first interaction extracts the second item from lights and applies it.
;This sets the light at 'sunrise@cmu to green.


;> (andmap (lambda (a-light) (a-light)) lights)
;true

;The second one switches the state of all items on lights.