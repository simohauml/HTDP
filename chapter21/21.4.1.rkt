;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 21.4.1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(require htdp/draw)

;; a shape is either:
;;   - (make-circle C P N)
;;   - (make-rectangle C P N N)
;; where C is a color,
;;       P is a posn, and
;;       N is a number.

(define-struct circle (center radius color))
(define-struct rectangle (color nw-corner width height))

;; draw-a-disk : circle -> true
;; draws the disk on the screen
;(define (draw-a-circle c)
;  (draw-circle (circle-center c)
;               (circle-radius c)
;               (circle-color c)))
(define (draw-a-circle a-circle)
  (process-circle
   (λ (c) (draw-circle (circle-center c)
                       (circle-radius c)
                       (circle-color c)))
   a-circle))

;; clear-circle : circle -> true
;; to clear a-circle
;(define (clear-a-circle a-circle)
;  (clear-circle
;   (circle-center a-circle)
;   (circle-radius a-circle)))
(define (clear-a-ckrcle a-circle)
  (process-circle
   (λ (c) (clear-circle (circle-center c)
                        (circle-radius c)))
   a-circle))

  
(define (process-circle act c)
  (act c))



(start 300 300)
(define c1 (make-circle (make-posn 50 50) 50 'red))
(draw-a-circle c1)