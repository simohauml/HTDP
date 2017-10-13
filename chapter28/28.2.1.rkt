;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 28.2.1) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define-struct tile (x y s))

(define chessbord (list
                   (make-tile 0 0 #t)
                   (make-tile 0 1 #t)
                   (make-tile 0 2 #t)
                   (make-tile 1 0 #t)
                   (make-tile 1 1 #t)
                   (make-tile 1 2 #t)
                   (make-tile 2 0 #t)
                   (make-tile 2 1 #t)
                   (make-tile 2 2 #t)))

;; a tile is either true or false

;; a row is a (listof tile)

;; a board is a (listof row) where the number of tiles in each
;; row is equal to the number of rows in the board
(define chess-board
  (list (list true true true true true true true true)
        (list true true true true true true true true)
        (list true true true true true true true true)
        (list true true true true true true true true)
        (list true true true true true true true true)
        (list true true true true true true true true)
        (list true true true true true true true true)
        (list true true true true true true true true)))

