;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 28.2.2) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define (build-array n f)
  (cond
    [(= n 0) (list (f 0))]
    [else (cons (f n)
                (build-array (- n 1) f))]))

;; build-board : Nat (Nat Nat -> Boolean) -> Board
;; to create a board of size n x n, 
;; fill each position with indices i and j with (f i j)
(define (build-board n f)
  (build-list n (lambda (i) (build-list n (lambda (j) (f i j))))))

(define (build-board-b n f)
  (build-array n (lambda (i) (build-array n (lambda (j) (f i j))))))

;; board-ref : board N N  ->  boolean
;; to access a position with indices i, j on a-board
(define (board-ref a-board i j)
  (local ((define (board-ref-aux b-board j)
            (cond
              [(>= j (length b-board)) (error 'board-ref "index beyond length")]
              [(= j 0) (first b-board)]
              [else (board-ref-aux (rest b-board) (- j 1))])))
    (cond
      [(>= i (length a-board)) (error 'board-ref "index beyond length")]
      [(= i 0) (board-ref-aux (first a-board) j)]
      [else (board-ref (rest a-board) (- i 1) j)])))


(define board-a (build-board 5 (lambda (i j) (+ (* 10 i) j))))
;(build-board-b 5 (lambda (i j) #t))


