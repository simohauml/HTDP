;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 28.2.4) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
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
(check-expect (build-board 2 (lambda (x y) (odd? (+ x y))))
              (list (list false true)
                    (list true false)))

(check-expect (board-ref (build-board 2 (lambda (x y) (odd? x))) 0 1) false)

(check-expect (board-ref (build-board 2 (lambda (x y) (odd? x))) 1 0) true)

(check-expect (board-dim (build-board 3 (lambda (x y) false))) 3)

; -------------------------------------------------------------------------

;; threatened? : Posn Posn -> Boolean
;; to determine if, in a-board, a queen on qp and threaten p
(define (threatened? qp p)
  (or (= (posn-x qp) (posn-x p))
      (= (posn-y qp) (posn-y p))
      (= (- (posn-x qp) (posn-y qp))
         (- (posn-x p) (posn-y p)))
      (= (+ (posn-x qp) (posn-y qp))
         (+ (posn-x p) (posn-y p)))))

;; same position
(check-expect (threatened? (make-posn 0 0) (make-posn 0 0)) true)

;; same vertical
(check-expect (threatened? (make-posn 0 0) (make-posn 0 1)) true)

;; same horizontal
(check-expect (threatened? (make-posn 0 0) (make-posn 1 0)) true)

;; same diagonal (up and left)
(check-expect (threatened? (make-posn 1 1) (make-posn 2 2)) true)
(check-expect (threatened? (make-posn 2 1) (make-posn 3 2)) true)
(check-expect (threatened? (make-posn 5 8) (make-posn 9 12)) true)

;; same diagonal (down and right)
(check-expect (threatened? (make-posn 3 3) (make-posn 4 2)) true)
(check-expect (threatened? (make-posn 5 8) (make-posn 1 12)) true)

;; failure
(check-expect (threatened? (make-posn 0 0) (make-posn 2 3)) false)

; -------------------------------------------------------------------------

;; placement : Board Nat -> board or false
;; places n queens on a-board. if possible, returns
;; the board. otherwise, returns false
(define (placement a-board n)
  (cond
    [(zero? n) a-board]
    [else
     (local ((define possible-places (find-open-spots a-board)))
       (placement/list possible-places a-board (sub1 n)))]))

;; placement/list : (Listof Posn) Board Nat -> board or false
;; tries to place n queens in all of the boards. As soon as
;; one of them works out, it returns that one. If none
;; work out, returns false.
(define (placement/list possible a-board n)
  (cond
    [(empty? possible) false]
    [else (local ((define c (placement (add-queen a-board (first possible)) n)))
            (cond
              [(boolean? c) (placement/list (rest possible) a-board n)]
              [else c]))]))

;; add-queen : Board Posn -> Board
;; add a queen to the board at p and also flip all threatened positions to true
(define (add-queen board p)
  (build-board (board-dim board)
               (lambda (x y)
                 (or (threatened? (make-posn x y) p) (board-ref board x y)))))

;; find-open-spots : Board -> (Listof Posn)
;; to find the unoccupied positions in the board
(define (find-open-spots board)
  (local [(define (traverse-board n)
            (local [(define (traverse-row j)
                      (cond
                        [(zero? j) empty]
                        [else (cond
                                [(not (board-ref board (sub1 n) (sub1 j)))
                                 (cons (make-posn (sub1 n) (sub1 j))
                                       (traverse-row (sub1 j)))]
                                [else (traverse-row (sub1 j))])]))]
              (cond
                [(zero? n) empty]
                [else (append (traverse-row (board-dim board))
                              (traverse-board (sub1 n)))])))]
    (traverse-board (board-dim board))))

;; -----------------------------------------------------------------------------
;; testing and running 

;; Nat -> Board 
;; create a board that contains one queen at (0,0)
(define (n_x_n-board-0-0 n)
  (local ((define first-queen (make-posn 0 0)))
    (build-board n (lambda (i j) (threatened? (make-posn i j) first-queen)))))

(define 3x3board (n_x_n-board-0-0 3))

(check-expect (find-open-spots 3x3board) (list (make-posn 2 1) (make-posn 1 2)))

(check-expect (add-queen 3x3board (make-posn 1 2))
              (list (list true true true)
                    (list true true true)
                    (list true true true)))

(check-expect (add-queen 3x3board (make-posn 2 1))
              (list (list true true true)
                    (list true true true)
                    (list true true true)))

(check-expect (placement (build-board 3 (lambda (i j) false)) 2)
              (add-queen
               (add-queen
                (build-board 3 (lambda (i j) false))
                (make-posn 1 0))
               (make-posn 2 2)))

(check-expect (placement 3x3board 3) false)

;; run the original problem 

(time (placement (n_x_n-board-0-0 8) 7))
