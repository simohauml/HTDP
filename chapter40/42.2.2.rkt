;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 42.2.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(define (ffm-make-posn x0 y0)
  (local ((define x x0)
	  (define (set-x new-x) (set! x new-x))
	  (define y y0)
	  (define (set-y new-y) (set! y new-y)))
  (lambda (select)
    (select x y set-x set-y))))

(define (ffm-posn-x a-ffm-posn)
  (a-ffm-posn (lambda (x y sx sy) x)))

(define (ffm-posn-y a-ffm-posn)
  (a-ffm-posn (lambda (x y sx sy) y)))

(define (ffm-set-posn-x! a-ffm-posn new-value)
  (a-ffm-posn (lambda (x y sx sy) (sx new-value))))

(define (ffm-set-posn-y! a-ffm-posn new-value)
  (a-ffm-posn (lambda (x y sx sy) (sy new-value))))

;; test
(define p1 (ffm-make-posn 3 4))
(ffm-set-posn-y! p1 5)
(ffm-posn-y p1)