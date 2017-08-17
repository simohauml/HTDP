;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 17.6.1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(define (merge lon1 lon2)
  (cond
    [(empty? lon1) lon2]
    [(empty? lon2) lon1]
    [else
     (merge (insert lon1 (car lon2)) (rest lon2))]))

(define (insert lon n)
  (cond
    [(empty? lon) (list n)]
    [(not (number? n)) (error 'insert "Provide a number to insert")]
    [else
     (if (>= (car lon) n)
         (cons n lon)
         (cons (car lon)
               (insert (rest lon) n)))]))
    