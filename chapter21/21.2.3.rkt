;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 21.2.3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; Language: Intermediate Student with Lambda

;; a toy is:
;;  (make-toy symbol number)
(define-struct toy (name price))

;; eliminate-exp : number (listof toy) -> (listof toy)
(define (eliminate-exp price alot)
  (filter (λ (a-toy)
            (<= (toy-price a-toy) price))
          alot))

;; recall : symbol (listof toy) -> (listof toy)
(define (recall ty alot)
  (filter (λ (a-toy)
            (not (equal? (toy-name a-toy) ty)))
          alot))

(define some-toys
  (list (make-toy 'woody 8.99)
        (make-toy 'buzz 9.99)
        (make-toy 'pizza-planet 0.99)))

(check-expect 
 (eliminate-exp 1.00 some-toys)
 (list (make-toy 'pizza-planet 0.99)))

(check-expect
 (recall 'buzz some-toys)
 (list (make-toy 'woody 8.99)
       (make-toy 'pizza-planet 0.99)))

;; selection : (listof symbol) (listof symbol) -> (listof symbol)
(define (selection l1 l2)
  (filter (λ (e2)
            (ormap (λ (e1) (equal? e1 e2))
                   l2))
          l1))

(check-expect (selection (list) (list)) (list))
(check-expect (selection (list 1) (list)) (list))
(check-expect (selection (list) (list 1)) (list))
(check-expect (selection (list 1 2) (list 1)) (list 1))
(check-expect (selection (list 1) (list 1 2)) (list 1))
(check-expect (selection (list 1 2 3 4 5 6 7 8 9 10)
                         (list 2 4 6 8 10))
              (list 2 4 6 8 10))
(check-expect (selection (list 2 4 6 8 10)
                         (list 1 2 3 4 5 6 7 8 9 10))
              (list 2 4 6 8 10))