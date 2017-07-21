;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 6.3.3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(define-struct jetfighter
  (designation acceleration top-speed range))

(define (within-range jetfighter distance)
  (if (< (jetfighter-range jetfighter) distance)
      false
      true))

;test
(define f22 (make-jetfighter 'f22 10 500 10000))
(within-range f22 8000)