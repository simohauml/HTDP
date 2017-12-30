;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 41.2.15) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; call-status : (vectorof boolean)
;; to keep track of the floors from which calls have been issued 
(define call-status (vector true true true false true true true false))

;; reset :  ->  void
;; effect: to set all fields in call-status to false
(define (reset)
  (reset-interval
   call-status
   0 (sub1 (vector-length call-status))))

;; reset-interval : N N  ->  void
;; effect: to set all fields in [from, to] to false
;; assume: (<= from to) holds 
(define (reset-interval v from to)
  (cond
    [(= from to) (vector-set! v from false)]
    [else (begin
            (vector-set! v to false)
            (reset-interval v from (sub1 to)))]))