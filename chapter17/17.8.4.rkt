;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 17.8.4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(define (contains? num lon)
  (cond
    [(empty? lon) false]
    [else
     (if (= num (car lon))
         true
         (contains? num (rest lon)))]))

(define (contains-all? lon1 lon2)
  (cond
    [(empty? lon1) true]
    [(empty? lon2) false]
    [else
     (and (contains? (car lon1) lon2)
          (contains-all? (rest lon1)
                         lon2))]))

(define (contains-same-numbers lon1 lon2)
  (cond
    [(and (empty? lon1)
          (empty? lon2))
     true]
    [else
     (and (contains-all? lon1 lon2)
          (contains-all? lon2 lon1))]))