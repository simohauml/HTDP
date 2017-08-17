;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 17.6.4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;;17.6.3 | Problem Statement | Table of Contents | 17.6.5
;; Language: Beginning Student with List Abbreviations

#| 17.6.4 value
------------------------------------------------------------
;Data Definition:
a list-of-numbers is either
  1. empty or
  2. (cons n lon)
  where n is a number and lon is a list-of-numbers

;Template:
(define (value coefficients variables)
  (cond
    [(empty? coefficients)...]
    [else 
     ...(first coefficients)...(first variables)...
     ...(value (rest coefficients) (rest variables))...]))
|#

;;value: list-of-numbers list-of-numbers -> number
;;consumes the representation of a linear combination 
;;and a list-of-numbers.  It produces the value of  
;;the combination for these values
;;ASSUMPTION: The lists are of equal length.
(define (value coefficients variables)
  (cond
    [(empty? coefficients) 0]
    [else 
     (+ (* (first coefficients) (first variables))
        (value (rest coefficients) (rest variables)))]))

;Examples as Tests:
(check-expect 
 (value (list 7) 
        (list 8)) 
 56)

(check-expect 
 (value (list 7 12) 
        (list 8 3)) 
 92)

(check-expect 
 (value (list 7 12  8) 
        (list 8 3 9)) 
 164)
