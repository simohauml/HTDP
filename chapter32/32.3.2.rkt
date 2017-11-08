;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 32.3.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define DIM 4)

; Use vector to represent board
; example
;(vector (vector 1 0 0 0)
;        (vector 1 1 0 0)
;        (vector 1 1 1 0)
;        (vector 1 1 1 1))
; function of creating board
;(define (build-board dim)
;  (list->vector
;   (map (lambda (i)
;          (list->vector
;           (build-list dim (lambda (j)
;                             (cond
;                               [(<= j i) 1]
;                               [else 0])))))
;        (build-list dim (lambda (x) x)))))

(define (tolist v)
  (local ((define out (vector->list v))
          (define (tolist-aux lov)
            (cond
              [(empty? lov) empty]
              [else (cons (vector->list (first lov))
                          (tolist-aux (rest lov)))])))
    (tolist-aux out)))

(define (tovector l)
  (list->vector (map (lambda (x) (list->vector x)) l)))

(define (build-board dim)
  (map (lambda (i)
         (build-list dim (lambda (j)
                           (cond
                             [(<= j i) 1]
                             [else 0]))))
       (build-list dim (lambda (x) x))))

; replace the position value with n, n should be 0 or 1
(define (replace pos board n)
  (cond
    [(empty? board) empty]
    [(not (inside? pos)) (error 'position "invalid position")]
    [else (vector-set! (vector-ref board (posn-x pos)) (posn-y pos) n)]))

(define (set-board pos board n)
  (local ((define v (tovector board)))
    (cond
      [(void? (replace pos v n))
       (tolist v)]
      [else false])))

; check if a position is inside a board
(define (inside? pos)
  (cond
    [(and (<= 0 (posn-x pos) (- DIM 1))
          (<= 0 (posn-y pos) (- DIM 1))
          (<= (posn-y pos) (posn-x pos)))
     true]
    [else false]))

; check if a peg is enabled
(define (enabled? pos board)
  (cond
    [(not (inside? pos)) false]
    [(unoccupied? pos board) false]
    [(not (empty? (possible-moves pos board)))
     true]
    [else false]))


;(define (position pos board)
;  (cond
;    [(not (inside? pos)) (error 'position "invalid position")]
;    [else (vector-ref (vector-ref board (posn-x pos)) (posn-y pos))]))
(define (position pos board)
  (cond
    [(not (inside? pos)) (error 'position "invalid position")]
    [else (list-ref (list-ref board (posn-x pos)) (posn-y pos))]))

; Use list of list to represent moves
; example:
;(list (list 0 0 1 0)
;      (list 1 1 1 0))
;(list (list (make-posn 0 0) (make-posn 1 0))
;      (list (make-posn 1 1) (make-posn 1 0)))
; for each sub-list, first two number indicate original peg
; last two is destination position

; left position next to current
(define (row-left-1 pos)
  (make-posn (posn-x pos)
             (- (posn-y pos) 1)))
; two move to left of current
(define (row-left-2 pos)
  (make-posn (posn-x pos)
             (- (posn-y pos) 2)))

; right 1 and 2
(define (row-right-1 pos)
  (make-posn (posn-x pos)
             (+ (posn-y pos) 1)))
(define (row-right-2 pos)
  (make-posn (posn-x pos)
             (+ (posn-y pos) 2)))

; column up 1 and 2
(define (col-up-1 pos)
  (make-posn (- (posn-x pos) 1)
             (posn-y pos)))
(define (col-up-2 pos)
  (make-posn (- (posn-x pos) 2)
             (posn-y pos)))

; column down 1 and 2
(define (col-down-1 pos)
  (make-posn (- (posn-x pos) 1)
             (posn-y pos)))
(define (col-down-2 pos)
  (make-posn (- (posn-x pos) 2)
             (posn-y pos)))

; diagonal up 1 and 2
(define (dia-up-1 pos)
  (make-posn (- (posn-x pos) 1)
             (- (posn-y pos) 1)))
(define (dia-up-2 pos)
  (make-posn (- (posn-x pos) 2)
             (- (posn-y pos) 2)))

; diagonal down 1 and 2
(define (dia-down-1 pos)
  (make-posn (+ (posn-x pos) 1)
             (+ (posn-y pos) 1)))
(define (dia-down-2 pos)
  (make-posn (+ (posn-x pos) 2)
             (+ (posn-y pos) 2)))



; check if a position is occupied
(define (occupied? pos board)
  (cond
    [(= (position pos board) 1) true]
    [else false]))
(define (unoccupied? pos board)
  (not (occupied? pos board)))

; get all possible moves of a peg
(define (possible-moves pos board)
  (local ((define row-left
            (cond
              [(and (inside? (row-left-1 pos))
                    (occupied? (row-left-1 pos) board)
                    (inside? (row-left-2 pos))
                    (unoccupied? (row-left-2 pos) board))
               (list pos (row-left-1 pos) (row-left-2 pos))]
              [else empty]))
          (define row-right
            (cond
              [(and (inside? (row-right-1 pos))
                    (occupied? (row-right-1 pos) board)
                    (inside? (row-right-2 pos))
                    (unoccupied? (row-right-2 pos) board))
               (list pos (row-right-1 pos) (row-right-2 pos))]
              [else empty]))
          (define col-up
            (cond
              [(and (inside? (col-up-1 pos))
                    (occupied? (col-up-1 pos) board)
                    (inside? (col-up-2 pos))
                    (unoccupied? (col-up-2 pos) board))
               (list pos (col-up-1 pos) (col-up-2 pos))]
              [else empty]))
          (define col-down
            (cond
              [(and (inside? (col-down-1 pos))
                    (occupied? (col-down-1 pos) board)
                    (inside? (col-down-2 pos))
                    (unoccupied? (col-down-2 pos) board))
               (list pos (col-down-1 pos) (col-down-2 pos))]
              [else empty]))
          (define dia-up
            (cond
              [(and (inside? (dia-up-1 pos))
                    (occupied? (dia-up-1 pos) board)
                    (inside? (dia-up-2 pos))
                    (unoccupied? (dia-up-2 pos) board))
               (list pos (dia-up-1 pos) (dia-up-2 pos))]
              [else empty]))
          (define dia-down
            (cond
              [(and (inside? (dia-down-1 pos))
                    (occupied? (dia-down-1 pos) board)
                    (inside? (dia-down-2 pos))
                    (unoccupied? (dia-down-2 pos) board))
               (list pos (dia-down-1 pos) (dia-down-2 pos))]
              [else empty])))
    (cond
      [(not (inside? pos)) empty]
      [else (append row-left row-right
                    col-up col-down
                    dia-up dia-down)])))
          
(define INIT (set-board (make-posn 2 2) (build-board DIM) 0))


(define (movepeg lom board)
  (local ((define v (tovector board))
          (define (m1 v)
            (replace (first lom) v 0))
          (define (m2 v)
            (replace (second lom) v 0))
          (define (m3 v)
            (replace (third lom) v 1)))
    (cond
      [(and (void? (m1 v))
            (void? (m2 v))
            (void? (m3 v)))
       (tolist v)]
      [else false])))
