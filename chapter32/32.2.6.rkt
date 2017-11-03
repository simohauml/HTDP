;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 32.2.6) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t write mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #t)))
(define MC 3)
(define BOAT-CAPACITY 2)

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
(define (M lor) (vector-ref lor 0))
(define (C lor) (vector-ref lor 1))

; Datatype boatload represents instinct boad load status
; First number represents number of missionary, second is cannibal
(define (make-BOAT-LOADS bc)
  (local ((define l (+ bc 1)))
    (append (build-list l (lambda (x) (build-mc x (- bc x))))
            (build-list (- bc 1) (lambda (x) (build-mc (+ x 1) 0)))
            (build-list (- bc 1) (lambda (x) (build-mc 0 (+ x 1)))))))

(define BOAT-LOADS (make-BOAT-LOADS BOAT-CAPACITY))

; switch boat location to the other side
(define (new-boat-location l)
  (cond
    [(equal? l 'left) 'right]
    [else 'left]))

; add or sub missionary and cannibal pair
(define (add mc1 mc2)
  (build-mc (+ (M mc1) (M mc2))
            (+ (C mc1) (C mc2))))

(define (sub mc1 mc2)
  (build-mc (- (M mc1) (M mc2))
            (- (C mc1) (C mc2))))

; function for generating all possible successor states of a state
(define (newstates s)
  (local ((define nos (length BOAT-LOADS)))
    (build-list nos
                (lambda (x)
                  (cond
                    [(equal? (boat-loca s) 'left)
                     (state (sub (left s) (list-ref BOAT-LOADS x))
                            (add (right s) (list-ref BOAT-LOADS x))
                            (new-boat-location (boat-loca s)))]
                    [else
                     (state (sub (left s) (list-ref BOAT-LOADS x))
                            (add (right s) (list-ref BOAT-LOADS x))
                            (new-boat-location (boat-loca s)))])))))

(define (gene-states los)
  (cond
    [(empty? los) empty]
    [else (append (newstates (first los))
                  (gene-states (rest los)))]))

; function for filter out ilegal states
; only legal states remains
(define (legal? s)
  (local ((define m-left (M (left s)))
          (define c-left (C (left s)))
          (define m-right (M (right s)))
          (define c-right (C (right s))))
    (cond
      [(and (<= 0 m-left MC)
            (<= 0 c-left MC)
            (<= 0 m-right MC)
            (<= 0 c-right MC))
       (cond
         [(and (or (= m-left 0)
                   (<= c-left m-left))
               (or (= m-right 0)
                   (<= c-right m-right))) true]
         [else false])]
      [else false])))

(define (legals? los) (filter legal? los))

; function for determining if two states are equal, which means exactly same
(define (same? s1 s2)
  (cond
    [(and (= (M (left s1)) (M (left s2)))
          (= (C (left s1)) (C (left s2)))
          (= (M (right s1)) (M (right s2)))
          (= (C (right s1)) (C (right s2)))
          (equal? (boat-loca s1) (boat-loca s2))) true]
    [else false]))

; Check if state is equal to FINT
(define (final? state)
  (cond
    [(same? state FINT) true]
    [else false]))

(define (finals? los) (filter final? los))

; try to find a final state for a given state/states, recursively.
(define (mc-solvable? los)
  (cond
    [(empty? los) false]
    [else (or (not (empty? (finals? los)))
              (mc-solvable? (legals? (gene-states los))))]))