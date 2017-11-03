;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 32.2.2) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #t)))
(define MC 3)
(define BOAT-CAPACITY 2)

; s - state
; l - left side of the river
; r - right side of the river
; b - boat location, could be l or r
;(define s (l r b))

; Init state
; left side: MC
; right side: 0
;(make-s (list MC MC)
;        (list 0 0)
;        'left)

; Final state
;(make-s (list 0 0)
;        (list MC mC)
;        'right)

; struct leads error with tracing on under Advanced Student language.
; Use vector instead to represent state

; build Missionary and Cannibal numbers state
(define (build-mc m c) (vector m c))
; test
;(build-mc 2 3)

; build state of river crossing
(define (state lside rside boatlocation)
  (vector lside rside boatlocation))
; test
;(state (build-mc 3 3) (build-mc 0 0) 'left)

; Initial state
; 3 missionaries and cannibals on left side of the river, and a boat.
; nothing on the other side, right side
(define INIT (state (build-mc MC MC) (build-mc 0 0) 'left))

; Finale state
(define FINT (state (build-mc 0 0) (build-mc MC MC) 'right))

; function for extracting each part of state
(define (left state) (vector-ref state 0))
(define (right state) (vector-ref state 1))
(define (boat-loca state) (vector-ref state 2))

; Datatype boatload represents instinct boad load status
; First number represents number of missionary, second is cannibal
(define (make-BOAT-LOADS bc)
  (local ((define l (+ bc 1)))
    (append (build-list l (lambda (x) (build-mc x (- bc x))))
            (build-list (- bc 1) (lambda (x) (build-mc (+ x 1) 0)))
            (build-list (- bc 1) (lambda (x) (build-mc 0 (+ x 1)))))))

(define BOAT-LOADS (make-BOAT-LOADS BOAT-CAPACITY))