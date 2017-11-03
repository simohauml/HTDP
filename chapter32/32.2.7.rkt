;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 32.2.7) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define MC 3)
(define BOAT-CAPACITY 2)

; define new struct cause error with tracing on under Advanced Student language.
; perhaps a bug of racket?
; use vector to represent basic state
; example:
; (vector 3 3 0 0 0)
; from left to right
; 3 missionaries and cannibals on left
; 0 missionaries and cannibals on right
; last position for boat laoction, 0 for left, 1 for right
(define (newstate lm lc rm rc b)
  (vector lm lc rm rc b))

; Initial state
(define INIT (newstate MC MC 0 0 0))
(define INIT-S (list INIT empty))

; Finale state
(define FINT (newstate 0 0 MC MC 1))

; function of building/extracting Missionary and Cannibal numbers state
; full state represented with list, including group of crosses to current state
; =====================================================================
; function for extracting each part of state
(define (leftm state) (vector-ref state 0))
(define (leftc state) (vector-ref state 1))
(define (rightm state) (vector-ref state 2))
(define (rightc state) (vector-ref state 3))
(define (boat state) (vector-ref state 4))

; =====================================================================

; Datatype boatload represents instinct boad load status
; First number represents number of missionary, second is cannibal
(define (make-BOAT-LOADS bc)
  (local ((define l (+ bc 1)))
    (append (build-list l (lambda (x) (vector x (- bc x))))
            (build-list (- bc 1) (lambda (x) (vector (+ x 1) 0)))
            (build-list (- bc 1) (lambda (x) (vector 0 (+ x 1)))))))

(define BOAT-LOADS (make-BOAT-LOADS BOAT-CAPACITY))

(define (addorsub state load)
  (cond
    [(= (boat state) 0)
     (newstate (- (leftm state) (vector-ref load 0))
               (- (leftc state) (vector-ref load 1))
               (+ (rightm state) (vector-ref load 0))
               (+ (rightc state) (vector-ref load 1))
               1)]
    [else
     (newstate (+ (leftm state) (vector-ref load 0))
               (+ (leftc state) (vector-ref load 1))
               (- (rightm state) (vector-ref load 0))
               (- (rightc state) (vector-ref load 1))
               0)]))

(define (next-states state)
  (local ((define prestates (second state))
          (define curstate (first state))
          (define (next state)
            (local ((define nos (length BOAT-LOADS)))
              (build-list nos
                          (lambda (x)
                            (addorsub state (list-ref BOAT-LOADS x))))))
          (define (appendstate los)
            (map (lambda (x) (list x (append prestates (list curstate)))) los)))
    (appendstate (next curstate))))

;(define s1 (next-states INIT-S))

; function for determining if two states are equal, which means exactly same
(define (same? state1 state2)
  (cond
    [(and (= (leftm state1) (leftm state2))
          (= (leftc state1) (leftc state2))
          (= (rightm state1) (rightm state2))
          (= (rightc state1) (rightc state2))
          (= (boat state1) (boat state2)))
     true]
    [else false]))

; function, check if a state exists in a list of states
(define (exist? state los)
  (cond
    [(empty? los) false]
    [else (or (same? state (first los))
              (exist? state (rest los)))]))

; function for filter out ilegal states
; only legal states remains
(define (legal? state)
  (local ((define prestates (second state))
          (define curstate (first state))
          (define left-m (leftm curstate))
          (define left-c (leftc curstate))
          (define right-m (rightm curstate))
          (define right-c (rightc curstate)))
    (cond
      [(or (< left-m 0) (> left-m MC)) false]
      [(or (< left-c 0) (> left-c MC)) false]
      [(or (< right-m 0) (> right-m MC)) false]
      [(or (< right-c 0) (> right-c MC)) false]
      [(and (not (= left-m 0)) (< left-m left-c)) false]
      [(and (not (= right-m 0)) (< right-m right-c)) false]
      [(exist? curstate prestates) false] ;state happens twice are cycle and ilegal.
      [else true])))

; generate only legal states of current states
(define (next-legal-states state)
  (filter legal? (next-states state)))

(define (final? state)
  (cond
    [(same? (first state) FINT) true]
    [else false]))

(define (finals los)
  (filter final? los))

(define (mc-solvable? los)
  (local ((define filtered (filter legal? los))
          (define finalstmp (finals los)))
    (cond
      [(empty? los) false]
      [(empty? filtered) false]
      [(not (empty? finalstmp)) true]
      [else (or (mc-solvable? (next-legal-states (first los)))
                (mc-solvable? (rest los)))])))

(define (mc-solution los)
  (local ((define filtered (filter legal? los))
          (define finalstmp (finals los)))
    (cond
      [(empty? los) false]
      [(empty? filtered) false]
      [(not (empty? finalstmp)) finalstmp]
      [else (local ((define nextresult
                      (mc-solution (next-legal-states (first los)))))
              (cond
                [(boolean? nextresult) (mc-solution (rest los))]
                [else nextresult]))])))

;test
(mc-solution (list INIT-S))