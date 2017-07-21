;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 12.2.1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(define-struct mail (from date message))

(define (sort-mail alom)
  (cond
    [(empty? alom) empty]
    [else (insert-mail (first alom) (sort-mail (rest alom)))]))

(define (insert-mail m alom)
  (cond
    [(empty? alom) (cons m empty)]
    [(>= (mail-date m) (mail-date (first alom)))
     (cons m alom)]
    [else (cons (first alom) (insert-mail m (rest alom)))]))