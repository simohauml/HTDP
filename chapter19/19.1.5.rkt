;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 19.1.5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; mini : nelon  ->  number
;; to determine the smallest number
;; on alon
(define (mini alon)
  (cond
    [(empty? (rest alon)) (first alon)]
    [else (cond
	    [(< (first alon) 
		(mini (rest alon)))
	     (first alon)]
	    [else
	     (mini (rest alon))])]))

;; maxi : nelon  ->  number
;; to determine the largest number
;; on alon
(define (maxi alon)
  (cond
    [(empty? (rest alon)) (first alon)]
    [else (cond
	    [(> (first alon)
		(maxi (rest alon)))
	     (first alon)]
	    [else
	     (maxi (rest alon))])]))

(define (extract rel-op alon)
  (cond
    [(empty? (rest alon)) (first alon)]
    [else (cond
            [(rel-op (first alon)
                     (extract rel-op (rest alon)))
             (first alon)]
            [else (extract rel-op (rest alon))])]))

(define (extract1 rel-op alon)
  (cond
    [(empty? (rest alon)) (first alon)]
    [else (local
            [(define fst (first alon))
             (define rst (rest alon))
             (define other (extract1 rel-op rst))]
            (cond
              [(rel-op fst other) fst]
              [else other]))]))

(define l1(list 3 7 6 2 9 8))

(define l2 (list 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1))

(define l3 (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20))