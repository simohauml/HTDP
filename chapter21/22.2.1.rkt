;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 22.2.1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; convertCF : lon  ->  lon
;(define (convertCF alon)
;  (cond
;    [(empty? alon) empty]
;    [else
;      (cons (C->F (first alon))
;	(convertCF (rest alon)))]))

;; names : loIR  ->  los
;(define (names aloIR)
;  (cond
;    [(empty? aloIR) empty]
;    [else
;      (cons (IR-name (first aloIR))
;	(names (rest aloIR)))]))

(define (convert fun)
  (local
    [(define (concrete alon)
       (cond
         [(empty? alon) empty]
         [else
          (cons (fun (first alon))
                (concrete (rest alon)))]))]
    concrete))