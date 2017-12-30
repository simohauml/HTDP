;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 40.3.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(define (swap-posn p)
  (local ((define tmp (posn-x p)))
    (begin
      (set-posn-x! p (posn-y p))
      (set-posn-y! p tmp))))

(define a (make-posn 1 2))
