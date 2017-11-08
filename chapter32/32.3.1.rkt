;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 32.3.1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define DIM 4)

; Use vector to represent board
; example
;(vector (vector 1 0 0 0)
;        (vector 1 1 0 0)
;        (vector 1 1 1 0)
;        (vector 1 1 1 1))
; function of creating board
(define (build-board dim)
  (list->vector
   (map (lambda (i)
          (list->vector
           (build-list dim (lambda (j)
                             (cond
                               [(<= j i) 1]
                               [else 0])))))
        (build-list dim (lambda (x) x)))))

(define b (build-board DIM))
(define b0 (vector-ref b 0))

(define (position i j board)
  (cond
    [(> (+ i 1) DIM) (error 'position "row index beyond boundary")]
    [(> (+ j 1) DIM) (error 'position "column index beyond boundary")]
    [(> j i) (error 'position "column index cannot larger then row")]
    [else (vector-ref (vector-ref board i) j)]))

(define (replace i j n board)
  (cond
    [(empty? board) empty]
    [(> (+ i 1) DIM) (error 'replace "row index beyond boundary")]
    [(> (+ j 1) DIM) (error 'replace "column index beyond boundary")]
    [(> j i) (error 'replace "column index cannot larger then row")]
    [else (vector-set! (vector-ref board i) j n)]))

; Use list of list to represent moves
; example:
;(list (list 0 0 1 0)
;      (list 1 1 1 0))
; for each sub-list, first two number indicate original peg
; last two is destination position


