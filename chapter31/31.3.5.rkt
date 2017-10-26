;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 31.3.5) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; add-to-pi : nat -> number
;; adds `n' to pi
(define (add-to-pi n)
  (local [;; add-to-pi/acc : nat number -> number
          ;; accumulator: `m' bigger than the initial value of the accumulator
          ;; where m is the number of nats we've seen so far
          (define (add-to-pi/acc n acc)
            (cond
              [(zero? n) acc]
              [else (add-to-pi/acc (sub1 n) (add1 acc))]))]
    (add-to-pi/acc n pi)))

;; examples as tests
(= (add-to-pi 0) pi)
(= (add-to-pi 10) (+ 10 pi))

;; plus : nat nat -> nat
(define (plus n1 n2)
  (local [;; add-to-pi/acc : nat number -> number
          ;; accumulator: `m' bigger than the initial value of the accumulator
          ;; where m is the number of nats we've seen so far
          (define (plus/acc n acc)
            (cond
              [(zero? n) acc]
              [else (plus/acc (sub1 n) (add1 acc))]))]
    (plus/acc n1 n2)))

;; examples as tests
(= (plus 0 0) 0)
(= (plus 0 3) 3)
(= (plus 3 4) 7)