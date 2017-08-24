;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 18.1.12) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; maxi : non-empty-lon  ->  number
;; to determine the largest number on alon
(define (maxi alon)
  (cond
    [(empty? (rest alon)) (first alon)]
    [else (cond
            [(> (first alon) (maxi (rest alon))) (first alon)]
            [else (maxi (rest alon))])]))

(define (maxii alon)
  (cond
    [(empty? (rest alon)) (first alon)]
    [else (local
            [(define maxrest (maxii (rest alon)))]
            (cond
              [(> (first alon) maxrest) (first alon)]
              [else maxrest]))]))

(define lon (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20))

;Using local is way faster here because it only evaluates (maxi (rest alon)) once per recursion,
;whereas with the second version it evaluates (maxi (rest alon)) twice whenever it gets to the last case.

;Local saves the result so you don't do the same work twice.
;https://stackoverflow.com/questions/4560926/use-of-local-in-racket-scheme