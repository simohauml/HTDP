;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 32.3.3-book) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
Problem Statement
#| ----------------------------------------------------------------------------
   Peg Solitaire:

   Program to compute solutions to Solitaire. 
   The shape is determined by a list of lists
   of x's, o's, and _one_ O. An 
      x represents wood, an 
      o stands for a peg in a hole, and 
      O stands for a plain hole. 

   Example:
    The following board configuartion permits a solutio

      '((o x x x)
	(o O x x)
	(o o o x)
	(o o o o))

    The next one doesn't:

      '((O x x x)
	(o o x x)
	(o o o x)
	(o o o o))
|#

#| ------------------------------------------------------------------------
   Data Definitions: BOARD, MOVE, INDEX
|#   

(define PEG 'o)
(define (PEG? x) (eq? PEG x))

(define WOOD 'x)
(define (WOOD? x) (eq? WOOD x))

(define HOLE 'O)
(define (HOLE? x) (eq? HOLE x))
;; A board is (listof (listof (union PEG HOLE WOOD))

(define-struct move (from to over))
;; A move is (make-move index index index).

(define-struct index (x y))
;; An index is (make-index N M) where N, M are in [1,...,ROW] and N <= M. 

#| ------------------------------------------------------------------------
   Finding a Solution
|#   

;; solve0 : board -> (union (listof move) #f)
;; Purpose: produce a list of moves, if the peg solitaire problem is
;;  solvable and #f otherwise 
(define (solve0 board)
  (cond
    ((final? board) empty)
    (else (solve/list board (possible-moves board)))))

;; solve/list : board (listof move) -> (union (listof move) #f)
;; Purpose: try each to use each possible moves to solve the current board
;;  problem; for the first one that works, produce a list of solutions;
;;  if none work, produce #f
(define (solve/list board moves)
  (cond
    ((empty? moves) #f)
    (else (local ((define the-move (first moves))
		  (define try1 (solve0 (next-board board the-move))))
	    (cond
	      (try1 (cons the-move try1))
	      (else (solve/list board (rest moves))))))))

#|  ----------------------------------------------------------------------------
    Detecting a final state
|#    
;; final? : board -> boolean
;; Purpose: is there only one peg on the board? 
(define (final? board)
  (= (count-pegs board) 1))

;; count-pegs : board -> num 
;; Purpose: count the number of pegs on the board
(define (count-pegs board)
  (sum 
   (map (lambda (row) (sum (map (lambda (item) (if (PEG? item) 1 0)) row)))
	board)))

;; sum : (listof num) -> num
;; Purpose: compute the sum of numbers on alon
(define (sum alon)
  (foldl + 0 alon))

#| ------------------------------------------------------------------------
   Computing Possible Moves on a Board
|#   

;; possible-moves : board -> (listof move)
;; Purpose: compute the list of all possible moves for some board 
;;  configuration
(define (possible-moves board) 
  (foldl append empty
	 (map (lambda (hole) (enabled-jumps board hole))
	      (all-holes board))))

;; enabled-jumps : board index -> (listof move)
;; Purpose: compute the list of enabled moves if an-index is a hole
;; domain knowledge: 
;;  a hole enables a jump if there are two pegs in any of the
;;  following directions: North, South, East, West, NE, NW, SE, SW
(define (enabled-jumps a-board an-index)
  (local (;; an-index is the hole, so we move a peg into that hole
	  (define to-i (index-x an-index))
	  (define to-j (index-y an-index))
	  ;; A STEP is +2 or -2
	  (define NORTH -2)
	  (define SOUTH +2)
	  (define EAST  +2)
	  (define WEST  -2)
	  (define ZERO   0)
	  ;; test-move : num num -> (union (list move) empty)
	  (define (test-move ew ns)
	    (local ((define from-i (+ ew to-i))
		    (define from-j (+ ns to-j))
		    (define from (make-index from-i from-j))
		    (define over
		      (make-index (+ (* 1/2 ew) to-i) (+ (* 1/2 ns) to-j))))
	      (cond
		[(and (index? from) 
		      (index? over)
		      (PEG? (board-ref a-board from))
		      (PEG? (board-ref a-board over)))
		 (list (make-move from an-index over))]
		[else empty]))))
    (append (test-move NORTH ZERO)
	    (test-move SOUTH ZERO) 
	    (test-move ZERO  EAST)
	    (test-move ZERO  WEST)
	    (test-move NORTH EAST)
	    (test-move NORTH WEST)
	    (test-move SOUTH EAST)   
	    (test-move SOUTH WEST))))

;; all-holes : board -> (listof index)
;; Purpose: compute the list of indicies of all holes on a-board
(define (all-holes a-board)
  (local (;; possible-rows : board num -> (listof index)
	  ;; structural on board, accumulator
	  (define (possible-rows a-board row#)
	    (cond
	      ((empty? a-board) empty)
	      (else (append (possible-cols (first a-board) row# 1) 
			    (possible-rows (rest a-board) (add1 row#))))))
	  ;; possible-cols : board num num -> (listof index)
	  ;; structural on row, two accumulator
	  (define (possible-cols a-row row# col#)
	    (cond
	      ((empty? a-row) empty)
	      (else (local ((define the-rest 
			      (possible-cols (rest a-row) row# (add1 col#))))
		      (cond
			((PEG? (first a-row)) the-rest)
			((WOOD? (first a-row)) the-rest)
			(else 
			 (cons (make-index row# col#) the-rest))))))))
    (possible-rows a-board 1)))

#| ------------------------------------------------------------------------
   Performing a Move
|#

;; next-board : board move-> board
;; Purpose: create a board from a-board and a-move; a move removes the pegs 
;;  in from and over positions and fills the hole in to with a peg
(define (next-board a-board a-move)
  (local ((define to (move-to a-move))
	  (define from (move-from a-move))
	  (define over (move-over a-move)))
    (build-board ROWS 
		 (lambda (an-index)
		   (cond 
		     ((index=? to an-index) PEG)
		     ((index=? from an-index) HOLE)
		     ((index=? over an-index) HOLE)
		     (else (board-ref a-board an-index)))))))

#| ------------------------------------------------------------------------
   Indexing and building the board 
|#

;; index? : index -> bool
;; Purpose: is it an index? see above invariants
(define (index? an-index)
  (<= 1 (index-y an-index) (index-x an-index) ROWS))

(define (index=? an-index another-one)
  (equal? an-index another-one))

;; board-ref : board index -> PEG WOOD HOLE 
;; Purpose: produce the board contents at an-index
(define (board-ref board an-index)
  (list-ref (list-ref board (sub1 (index-x an-index))) 
	    (sub1 (index-y an-index))))

;; build-board : num (index -> { WOOD PEG HOLE } ) -> board
;; Purpose: build a board by iterating over the indices and applying f to them
(define (build-board i f)
  (build-list i (lambda (row#)
		  (build-list i (lambda (col#)
				  (f (make-index (add1 row#) (add1 col#))))))))

(define (make-board0 ROWS THE-HOLE)
  (build-board ROWS (lambda (an-index)
		      (cond
			((not (index? an-index)) WOOD)
			((index=? THE-HOLE an-index) HOLE)
			(else PEG)))))

#|  ----------------------------------------------------------------------------
   Tests 

(define board0
  '((o x x x)
    (o O x x)
    (o o o x)
    (o o o o)))

(define ROWS (length board0))

(define a-final-board 
  '((O x x x)
    (O o x x)
    (O O O x)
    (O O O O)))

(equal? (all-holes board0) (list (make-index 2 2)))
(= (length (all-holes a-final-board)) 9)

(PEG? (board-ref board0 (make-index 1 1)))
(PEG? (board-ref board0 (make-index 4 4)))
(WOOD? (board-ref board0 (make-index 1 3)))

(not (final? board0))
(final? a-final-board)

(equal? 
 (enabled-jumps board0 (make-index 2 2))
 (list (make-move (make-index 4 2) (make-index 2 2) (make-index 3 2))
       (make-move (make-index 4 4) (make-index 2 2) (make-index 3 3))))
(empty? (enabled-jumps a-final-board (first (all-holes a-final-board))))

(equal? (possible-moves board0) 
	(list (make-move (make-index 4 2) (make-index 2 2) (make-index 3 2))
	      (make-move (make-index 4 4) (make-index 2 2) (make-index 3 3))))

(equal? board0 (make-board0 ROWS (make-index 2 2)))
|#
;; ROWS : default value 4
(define ROWS 4)

(define (solve hole:index rows:num)
  (set! ROWS rows:num)
  (solve0 (make-board0 rows:num hole:index)))
