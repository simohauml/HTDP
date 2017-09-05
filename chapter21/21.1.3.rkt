;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 21.1.3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; copy : N X  ->  (listof X)
;; to create a list that contains
;; obj n times
;(define (copy n obj)
;  (cond
;    [(zero? n) empty]
;    [else (cons obj 
;                (copy (sub1 n) obj))]))
(define (copy n obj)
  (natural-f cons empty n obj))


;; n-adder : N number  ->  number
;; to add n to x using
;; (+ 1 ...) only
;(define (n-adder n x)
;  (cond
;    [(zero? n) x]
;    [else (+ 1
;             (n-adder (sub1 n) x))]))
;(define (n-adder n x)
;  (natural-f + 0 n x))

(define (n-adder n x)
  (local
    [(define (adder x1 rst)
       (+ 1 rst))]
    (natural-f adder x n x)))

(define (natural-f func init n x)
  (cond
    [(zero? n) init]
    [else (func x
                (natural-f func init (sub1 n) x))]))

;; Language: Intermediate Student

;; Exercise 21.1.3. Define natural-f, which is the abstraction of the
;; following two functions:
;; 
;; ;; copy : N X  ->  (listof X)
;; ;; to create a list that contains
;; ;; obj n times
(define (copy n obj)
  (cond
    [(zero? n) empty]
    [else (cons obj 
                (copy (sub1 n) obj))]))
;;  	
;; n-adder : N number  ->  number
;; to add n to x using
;; (+ 1 ...) only
(define (n-adder n x)
  (cond
    [(zero? n) x]
    [else (+ 1
             (n-adder (sub1 n) x))]))
;; 
;; Don't forget to test natural-f. Also use natural-f to define
;; n-multiplier, which consumes n and x and produces n times x with
;; additions only. Use the examples to formulate a contract.
;; 
;; Hint: The two function differ more than, say, the functions sum and
;; product in exercise 21.1.2. In particular, the base case in one
;; instance is a argument of the function, where in the other it is just
;; a constant value.
;; 
;; (*) Solution
;; 
;; After following the design recipe for abstraction, we get natural-f as
;; shown below. To write the contract, let's first only consider copy,
;; then we consider only n-adder and then we consider both.
;; 
;; ;; natural-f-copy: Nat X (X (listof X) -> (listof X)) (listof X) -> (listof X)
;; ;; natural-f-adder: Nat number (number number -> number) number -> number
;; 
;; The contract for natural-f-adder is more specific than
;; natural-f-copy. The difference between these is that in the first, two
;; different types are involved --- X and (listof X). Therefore, (listof
;; X) works as another variable, so let's call it Y in the final version.
 
;; natural-f: Nat X (X Y -> Y) Y -> Y
(define (natural-f n x f init)
  (cond
    [(zero? n) init]
    [else (f x
              (natural-f (sub1 n) x f init))]))

;; (*) Tests

;; Let's use two different types in copy, say symbol and then number.

(check-expect (copy 3 'a) '(a a a))
(check-expect (natural-f 3 'a cons empty) (copy 3 'a))

(check-expect (copy 0 'a) empty)
(check-expect (natural-f 0 'a cons empty) (copy 0 'a))

(check-expect (copy 3 1) (list 1 1 1))
(check-expect (natural-f 3 1 cons empty) (copy 3 1))

;; For n-adder, let's make sure to test different init-values.

(check-expect (n-adder 3 3.14) 6.14)
(check-expect (natural-f 3 1 + 3.14) (n-adder 3 3.14))

(check-expect (n-adder 3 1) 4)
(check-expect (natural-f 3 1 + 1) (n-adder 3 1))

(check-expect (n-adder 3 2) 5)
(check-expect (natural-f 3 1 + 2) (n-adder 3 2))

(define (n-multiplier n x)
  (natural-f n x + 0))

(check-expect (n-multiplier 0 0) 0)
(check-expect (n-multiplier 0 10) 0)
(check-expect (n-multiplier 10 0) 0)
(check-expect (n-multiplier 3 4) 12)
(check-expect (n-multiplier 4 3) 12)