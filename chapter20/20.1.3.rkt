;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 20.1.3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(define (a-function=? func1 func2 v)
  (cond
    [(equal? (func1 v) (func2 v)) true]
    [else false]))

;; Language: Intermediate Student with Lambda
;; Teachpack: draw.rkt

;; a-function=?: (number -> number) (number->number) -> boolean
;; determines if two functions are equal on the inputs 1.2, 3, and -5.7
(define (a-function=? f1 f2)
  (and (= (f1 1.2) (f2 1.2))
       (= (f1 2) (f2 2))
       (= (f1 -5.7) (f2 -5.7))))

(check-expect (a-function=? (Î» (x) x) (Î» (y) y))
              true)
(check-expect (a-function=? (Î» (x) (* x x))
                            (Î» (y) (* y y)))
              true)
(check-expect (a-function=?
               (Î» (x)
                 (cond
                   [(= x 1.2) 3]
                   [else x]))
               (Î» (x) x))
              false)
(check-expect (a-function=?
               (Î» (x)
                 (cond
                   [(= x 2) 3]
                   [else x]))
               (Î» (x) x))
              false)
(check-expect (a-function=?
               (Î» (x)
                 (cond
                   [(= x -5.7) 3]
                   [else x]))
               (Î» (x) x))
              false)
(check-expect
 (a-function=?
  (Î» (x)
    (cond
      [(or (= x 1.2) (= x 2) (= x -5.7)) x]
      [else (- x)]))
  (Î» (x) x))
 true)


#|

Part 2:

No, it is not possible in general. A naive approach
of just trying all inputs isn't possible, as there are
not a finite number of them.

|#