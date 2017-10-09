;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 27.5.7) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; Language: Intermediate Student with Lambda

;; Author: Mike Situ
;; Date: 4/24/2013
;; Purpose: solves linear systems of equations by triangulating the
;; system, and then substituting the solved values into the other
;; equations until all equations are solved. The result will look
;; something like this: '((1 0 0 X) (1 0 Y) (1 Z)).
;; If the system of equations cannot be triangulated, an error is raised.
;; ---------------------------------------------------------

;; triangulate : (listof (listof num)) -> (listof (listof num))
;; consumes a rectangular system of equations and produces  
;; a triangular version according to the Gaussian algorithm.
;; Creates a new (listof (listof num)) where the first (listof num)
;; is the same, but each subsequent list is subtracted by the list above.
(define (triangulate sys-eq)
  (local ((define top-sys (first sys-eq))
          ;; tri-aux : (listof num) (listof (listof num)) -> (listof (listof num))
          ;; "combiner" function for use with foldr. It subtracts top-sys from each
          ;; other equation in the system, and removes leading 0's.
          (define (tri-aux first-item recurs)
            (cons (subtract0 top-sys first-item) recurs)))
    (cond
      ((empty? (rest sys-eq)) 
       (list top-sys))
      ((zero? (first top-sys))  ;; helps avoid divide by zero error
       (triangulate (swap-first-second sys-eq)))
      (else 
       (cons top-sys 
             (triangulate 
              (foldr tri-aux empty (rest sys-eq))))))))

;; swap-first-round : (listof (listof num)) -> (listof (listof num))
;; if (first (second l)) is also zero, the system is unsolveable. 
;; Otherwise, swaps the top and 2nd systems of equations to avoid 
;; a divide zero error in "subtract"
(define (swap-first-second l)
  (if (zero? (first (second l)))
      (error 'triangulate/swap-first-second "non-triangular system of equations!")
      (append (list (second l))
              (list (first l))
              (rest (rest l)))))

;; solve : (listof (listof num)) -> (listof (listof num))
;; solves a system of equations (if it can be triangulated)
(define (solve sys-eq)
  (solve-aux (triangulate sys-eq)))

;; solve-aux : (listof (listof num)) -> (listof (listof num))
;; given a triangular system of equations, solve-aux creates a 
;; triangular list of solutions.
(define (solve-aux t)
  (if (empty? t) 
      empty
      (cons (evaluate (first t) (solve-aux (rest t)))
            (solve-aux (rest t)))))

;; evaluate : (listof num) (listof (listof num)) -> (listof num)
;; evaluates the equation with the values provided by sol-list,
;; resulting in a solved equation.
(define (evaluate eq sol-list)
  (cond
    [(empty? sol-list) (normalize eq)]
    [else (evaluate (subst-val eq (first sol-list))
                    (rest sol-list))]))

;; subst-val : (listof num) (listof num) -> (listof num)
;; substitutes the values of the sol into eq, and subtracts 
;; ("cancels out") the solved variable/value from eq.
;; ASSUMPTION: 1) sol's first item is 1 and denotes a variable, 
;;             and the last item is the value
;;             2) eq is initially longer than sol, the "extra
;;             leading items" will be preserved.
;;             3) sol has no leading zero's
(define (subst-val eq sol)
  (if (= (length eq) (length sol))
      (subtract sol eq)
      (cons (first eq) 
            (subst-val (rest eq) sol))))

;; normalize : (listof num) -> (listof num)
;; eq is already solved for a single variable. this normalizes
;; the value by the coefficient of the variable.
(define (normalize eq)
  (map (lambda (item) (/ item (first eq))) eq))

;; subtract : (listof num) (listof num) -> (listof num)
;; consumes 2 lists of equal length, and returns the result 
;; of "cancelling out" the first item of minu.
;; NOTE: (- minuend subtrahend)
;;       subtract expects non-empty lists!
(define (subtract subt minu)
  (if (zero? (first subt))
      (error 'subtract "the first item in subtrahend cannot be 0!")
      (sub-aux subt minu (/ (first minu) 
                             (first subt)))))

;; sub-aux : (listof num) (listof num) num -> (listof num)
;; constructs a new list by subtracting each item in the minuend
;; by the corresponding item in the subtrahend * factor
;; NOTE: sub-aux expects initially non-empty lists!
(define (sub-aux subt minu factor)
  (cond
    [(empty? subt) empty]
    [else (cons (- (first minu) (* factor (first subt)))
                (sub-aux (rest subt) (rest minu) factor))]))

;; subtract0 : (listof num) (listof num) -> (listof num)
;; subtracts the minuend by the subtrahend, and pops the leading 0
(define (subtract0 subt minu)    
  (remove 0 (subtract subt minu)))


;; ***************TESTS*****************
(check-expect (triangulate '((1 3)))
              '((1 3)))
(check-expect (triangulate '((0 1 5) (4 2 6)))
              '((4 2 6) (1 5)))
(check-expect (triangulate '((2 2 3 10) (2 5 12 31) (4 1 -2 1)))
              '((2 2 3 10) (3 9 21) (1 2)))
;; the below system of equations is not triangular, and is therefore unsolveable.
;;(triangulate '((2 2 2 6) (2 2 4 8) (2 2 1 2)))

(check-expect (swap-first-second '((0 -5 -5) (-8 -4 -12))) 
              '((-8 -4 -12) (0 -5 -5)))
;;(swap-first-second '((0 0 1 2) (0 1 0 1))) ;; throws the error below
;;triangulate/swap-first-second: non-triangular system of equations!

(check-expect (solve '(()))
              (list empty))
(check-expect (solve '((2 2 3 10) (2 5 12 31) (4 1 -2 1)))
              '((1 0 0 1) (1 0 1) (1 2)))
(check-expect (solve '((2 3 3 8) (2 3 -2 3) (4 -2 2 4)))
              '((1 0 0 1) (1 0 1) (1 1)))
(check-expect (solve '((1 1 2 1) (3 -1 1 -1) (-1 3 4 1)))
              '((1 0 0 1.5) (1 0 14/4) (1 -2)))

(check-expect (solve-aux '(()))
              (list empty))
(check-expect (solve-aux '((2 2 3 10) (3 9 21) (1 2)))
              '((1 0 0 1) (1 0 1) (1 2)))

(check-expect (evaluate '(2 0 2) empty)
              '(1 0 1))
(check-expect (evaluate '(2 2 3 10) '((1 0 1) (1 2)))
              '(1 0 0 1))

(check-expect (subst-val '(3 9 21) '(1 2)) 
              '(3 0 3))

(check-expect (normalize '(2 0 0 2))
              '(1 0 0 1))

;;(subtract '(0 3 1) '(1 2 1)) ;; throws error below
;;subtract: the first item in subtrahend cannot be 0!

(check-expect (subtract '(1 2 3) '(2 4 1))
              '(0 0 -5))
(check-expect (sub-aux '(2 2 3 10) '(2 5 12 31) 1)
              '(0 3 9 21))
(check-expect (subtract0 '(2 2 3 10) '(2 5 12 31))
              '(3 9 21))