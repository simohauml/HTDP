;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 21.2.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; 1
;; Language: Intermediate Student with Lambda

;; convert-euro : (listof number) -> (listof number)
(define (convert-euro alon)
  (map (λ (x) (* x 1.22)) alon))

(check-expect
 (convert-euro (list 1 50/61))
 (list 1.22 1))

;; convertFC : (listof number) -> (listof number)
(define (convertFC alon)
  (map (λ (x) (* (- x 32) 5/9)) alon))

(check-expect
 (convertFC (list 32 212 -40))
 (list 0 100 -40))

;; move-all : (listof posn) -> (listof posn)
(define (move-all alop)
  (map (λ (p)
         (make-posn (posn-x p)
                    (+ (posn-y p) 3)))
       alop))

(check-expect
 (move-all (list (make-posn 2 3) (make-posn 0 0)))
 (list (make-posn 2 6) (make-posn 0 3)))



