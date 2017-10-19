;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 29.3.14) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; a board is a
;; (vectorof (vectorof boolean))
;; where the length of all vectors are the same

;; build-board : N (N N -> boolean) -> board
;; to create a board of size n x n,
;; fill each position with indices i and j with (f i j)
(define (build-board n f)
  (local ((define (build-row i)
            (build-vector n f)))
    (build-vector n build-row)))

;; board-ref : board N N -> boolean
;; to access a position with indices i, j on a-board
(define (board-ref a-board i j)
  (vector-ref (vector-ref a-board i) j))

;; TESTS
(build-board 4 (lambda (i) true))
(define test-board
  (vector
   (vector true true true true)
   (vector true true true true)
   (vector true true true true)
   (vector true true false true)))
(board-ref test-board 1 2)
(not (board-ref test-board 3 2))