;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 17.8.7) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; Language: Beginning Student with List Abbreviations

#| 17.8.7 posn=?
------------------------------------------------------------
;Data Definition:
A posn is a structure:
    (make-posn x y)
where x and y are numbers.
(define-struct posn (x y))

;template:
(define (posn=? a-posn another-posn)
  ...(posn-x a-posn)...(posn-x another-posn)...
  ...(posn-y a-posn)...(posn-y another-posn)...)
|#
;;posn=?: posn posn -> boolean
;;consumes two posns and returns true if they
;;are equal, false otherwise
(define (posn=? a-posn another-posn)
  (and (= (posn-x a-posn)
          (posn-x another-posn))
       (= (posn-y a-posn)
          (posn-y another-posn))))

;Examples as Tests:
(check-expect
 (posn=? (make-posn 8 12) (make-posn 8 12))
 true)

(check-expect
 (posn=? (make-posn 7 12) (make-posn 8 12))
 false)

(check-expect
 (posn=? (make-posn 8 3) (make-posn 8 12))
 false)

(check-expect
 (posn=? (make-posn 8 3) (make-posn 3 8))
 false)

(check-expect
 (posn=? (make-posn 3 5) (make-posn 3 5))
 true)