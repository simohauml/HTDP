;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 29.3.15) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; a board is a
;; (vectorof (vectorof boolean))
;; where the length of all vectors are the same

;; a matrix is a
;; (vectorof (vectorof number))

;; transpose : matrix -> matrix
;; produces a new matrix where the item at (i,j)
;; is moved to (j,i)
(define (transpose m) ...)
  
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
(define test-matrix
  (vector (vector 1 0 -1)
          (vector 2 0  9)
          (vector 1 1  1)))
(board-ref test-matrix 1 2)