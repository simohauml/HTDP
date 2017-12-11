;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 37.1.3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; Constants:

;; the legitimate colors 
(define COLORS
  (list 'black 'white 'red 'blue 'green 'gold 'pink 'orange 'purple 'navy))

;; the number of colors
(define COL# (length COLORS))

(define guess 0)

;; Data Definition:
;; A color is a symbol on COLORS.

;; target1, target2 : color 
;; the two variables represent the two colors that the first player chose
(define target1 (first COLORS))
(define target2 (first COLORS))

(define (random-pick l)
  (list-ref l (random (length l))))

;; master :  ->  void
;; effect: set target1 and target2 to two randomly chosen items from COLORS
(define (master)
  (begin
    (set! target1 (random-pick COLORS))
    (set! target2 (random-pick COLORS))))

;; check-color : symbol symbol symbol symbol -> symbol 
;; to determine how well  the target-colors match with the guess-colors
(define (check-color guess-1 guess-2 target-1 target-2)
  (cond
    [(and (symbol=? guess-1 target-1) (symbol=? guess-2 target-2))
     'Perfect]
    [(or  (symbol=? guess-1 target-1) (symbol=? guess-2 target-2)) 
     'OneColorAtCorrectPosition]
    [(or  (symbol=? guess-1 target-2) (symbol=? guess-2 target-1))
     'OneColorOccurs]
    [else
     'NothingCorrect]))

;; master-check : color color  ->  symbol
;; to determine how many colors at how many positions are guessed correctly
;; The function defers to check-color, the solution of exercise 5.1.5.
(define (master-check guess1 guess2)
  (begin
    (set! guess (+ guess 1))
    (list (check-color guess1 guess2 target1 target2)
          guess)))