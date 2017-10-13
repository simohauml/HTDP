;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 28.2.3) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; Language: Intermediate Student

#| 
  A (Chess)Board is [Listof Row]. 
  A Row is [Listof Boolean].
|#

; -------------------------------------------------------------------------

;; build-board : Nat (Nat Nat -> Boolean) -> Board
;; to create a board of size n x n, 
;; fill each position with indices i and j with (f i j)
(define (build-board n f)
  (build-list n (lambda (i) (build-list n (lambda (j) (f i j))))))
   
;; board-ref : Board Nat Nat  ->  Boolean
;; to access a position with indices i, j on a-board
(define (board-ref a-board i j)
  (local [;; extract-from : N [Listof X] -> X
          ;; extracts the nth element from l. l must have at least n elements.
          (define (extract-from n l)
            (cond
              [(zero? n) (first l)]
              [else (extract-from (- n 1) (rest l))]))]
    (extract-from j (extract-from i a-board))))

;; board-dim : Board -> Nat
;; to determine the size of the board
(define (board-dim a-board) (length a-board))

;; examples as tests
(define board-a (build-board 5 (lambda (i j) (make-posn i j))))
;(check-expect (build-board 2 (lambda (x y) (odd? (+ x y))))
;              (list (list false true)
;                    (list true false)))
;
;(check-expect (board-ref (build-board 2 (lambda (x y) (odd? x))) 0 1) false)
;
;(check-expect (board-ref (build-board 2 (lambda (x y) (odd? x))) 1 0) true)
;
;(check-expect (board-dim (build-board 3 (lambda (x y) false))) 3)

;; threatened? : Posn Posn -> Boolean
;; to determine if, in a-board, a queen on qp and threaten p
;(define (threatened? qp p)
;  (or (= (posn-x qp) (posn-x p))
;      (= (posn-y qp) (posn-y p))
;      (= (- (posn-x qp) (posn-y qp))
;         (- (posn-x p) (posn-y p)))
;      (= (+ (posn-x qp) (posn-y qp))
;         (+ (posn-x p) (posn-y p)))))

(define (threatened? queen pos)
  (local ((define (y1 x) (+ x (- (posn-y queen) (posn-x queen))))
          (define (y2 x) (+ (- x) (abs (- (posn-y queen) (posn-x queen))))))
    (cond
      [(= (posn-x queen) (posn-x pos)) #t]
      [(= (posn-y queen) (posn-y pos)) #t]
      [(= (y1 (posn-x pos)) (posn-y pos)) #t]
      [(= (y2 (posn-x pos)) (posn-y pos)) #t]
      [else #f])))

(define q1 (make-posn 1 0))
(define p1 (make-posn 2 1))
(define p2 (make-posn 0 1))