;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 25.2.3) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t quasiquote mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; Language: Intermediate Student with Lambda
;; [List-of Number] -> [List-of Number]
;; sort the given list of numbers in ascending order

(check-expect (power-sort '(3 2 4 1 6)) '(1 2 3 4 6))
(check-expect
 (sorted? (power-sort (build-list 10000 (lambda (_) (random 100000))))) true)

(define (power-sort l)
  (local ((define THRESHOLD 100)

          ;; [List-of Number] -> [List-of Number]
          ;; quick sort until lists are shorter than THRESHOLD,
          ;; then switch to insertion sort
          ;; TERMINATION: the list is shorter for every recursive call
          (define (limited-qs l)
            (cond
              [(<= (length l) THRESHOLD) (insertion-sort l)]
              [else
               (local ((define pivot (first l))
                       (define small
                         (limited-qs (filter (lambda (n) (< n pivot)) l)))
                       (define equals
                         (filter (lambda (n) (= n pivot)) l))
                       (define large
                         (limited-qs (filter (lambda (n) (> n pivot)) l))))
                 (append small equals large))]))

          ;; [List-of Number] -> [List-of Number]
          ;; created a sorted version of one-lon
          (define (insertion-sort one-lon)
            (cond
              [(empty? one-lon) '()]
              [(cons? one-lon)
               (insert (first one-lon) (insertion-sort (rest one-lon)))]))

          ;; Number[List-of Number] -> [List-of Number]
          ;; puts n into one-lon, whic is sorted in ascending order
          (define (insert n one-lon)
            (cond
              [(empty? one-lon) (list n)]
              [(cons? one-lon)
               (if (<= (first one-lon) n)
                   (cons (first one-lon) (insert n (rest one-lon)))
                   (cons n one-lon))])))
    ;; -- start here --
    (limited-qs l)))

;; [List-of Number] -> [List-of Number]
;; is this list sorted in ascending order?
(check-expect (sorted? '()) true)
(check-expect (sorted? '(1 2 3)) true)
(check-expect (sorted? '(1 3 2)) false)
(define (sorted? l)
  (local (;; (cons Number [List-of Number]) -> Boolean
          ;; is this list of at least one number sorted?
          (define (sorted1? l)
            (cond
              [(empty? (rest l)) true]
              [else (and (<= (first l) (second l)) (sorted1? (rest l)))])))
    (cond
      [(empty? l) true]
      [(cons? l) (sorted1? l)])))
