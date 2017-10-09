;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 27.5.5) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
#| ------------------------------------------------------------------------
   Data Definitions:

   A matrix is a list of list of numbers:
      (listof (listof num))
   such that all lists have the same length: 
   and each list contains at least two items. 

   A tri-matrix is a list of list of numbers:
      (listof (listof num))
   such that the 2nd is one shorter than the 1st, etc.
   Each list contains at least two items. 

   gauss : matrix -> tri-matrix
   (define (gauss mat) ...)

   Purpose: Gaussian elimination for n x m matrix

   ASSUMPTION: a pivot may be 0!

   Example: 
   (gauss (list (list 2 2  3 10) 
		(list 2 5 12 31)  
		(list 4 1 -2  1)))
   = 
   (list (list 2 2  3   10) 
	 (list   3  9   21)  
	 (list      1    2))   
   
   NEW EXAMPLE: 
   (gauss 
    2 x + 3 y + 3 z =   8
    2 x + 3 y - 2 z =   3
    4 x - 2 y + 2 z =   4)
   = 
   
    2 x + 3 y + 3 z =   8
        - 8 y - 4 z = -12
              - 5 z =  -5  
|#

;; second version
(define (gauss mat)
  (cond
    ((empty? mat) empty)
    (else (local (;; NEW CODE: 
		  (define new-mat (cond
				    [(= (first (first mat)) 0) (switch-row mat)]
				    [else mat]))
		  (define row1 (first new-mat)))
	    (cons row1 (gauss (subtract-row1-from-all-rows row1 (rest new-mat))))))))

#| ------------------------------------------------------------------------
   NEW PROGRAM: 
   
   switch-row : matrix -> (union matrix #f)
   (define (switch-row mat) ...)
   
   Purpose: search for a row in mat whose first coefficient is not 0, 
     remove and place first
     
   Example: 
   (switch-row a--sw-mat)
   = 
   (list (list 2 1)
	 (list 0 1))
    
   Hint: (remove (list 0 1) (list (list 2 1) (list 0 1))) = (list (list 2 1))
   In general, remove produces a list like the second one but with item removed. 
|#

(define (switch-row mat)
  (local ((define row-without-0 (search mat)))
    (cond
      ((boolean? row-without-0) #f)
      (else (cons row-without-0 (remove row-without-0 mat))))))

;; search : matrix -> (union (listof num) #f)
;; Purpose : produce first row in mat whose cofficient is not 0, #f otherwise
;; Example: (search a-sw-mat) = (list 2 1)
(define (search mat)
  (cond
    ((empty? mat) #f)
    (else (cond
	    ((= (first (first mat)) 0) (search (rest mat)))
	    (else (first mat))))))

#| Test: 
(define a-sw-mat 
  (list (list 0 1)
	(list 2 1)))

(equal? (search a-sw-mat) (list 2 1))

(equal? (switch-row a-sw-mat)
	(list (list 2 1)
	      (list 0 1)))
|#


#| ------------------------------------------------------------------------
   subtract-row1-from-all-rows :  (listof num) matrix -> matrix
   (define (subtract-row1-from-all-rows row1 other-rows) ...)   

   Purpose: subtract enough multiples of row1 from all rows in other-rows
     so that first number of each new one is 0. Eliminate the 0, i.e., 
     all rows in result are one shorter than row1

   Example: 
    (subtract-row1-from-all-rows (list 2 3 4)
				 (list (list 2 3 4)
				       (list 4 4 4)))
    = 
    (list 
     (list  0  0)
     (list -2 -4))
|#

(define (subtract-row1-from-all-rows row1 mat)
  (map (subtract row1) mat))

#| ------------------------------------------------------------------------
   subtract : (list number) -> ((list number) -> (list number))
   (define (subtract row1) ...)
   
   Purpose: subtract enough multiples of row1 from row2 so that first 
     number is 0 chop off the 0; the result is one shorter than the two inputs

   Examples: 
     ((subtract (list 2 3 4)) (list 2 3 4))
     = 
     (list 0 0)
     
     ((subtract (list 2 3 4)) (list 4 4 4))
     =
     (list -2 -4)
|#

(define (subtract row1)
  (lambda (row2)
    (local ((define factor (/ (first row2) (first row1))))
      (rest (map - row2 (map (curry* factor) row1))))))

;; curry* : num -> (num -> num)
;; Purpose: a curried version of * 
(define (curry* n) (lambda (m) (* n m)))

#| Tests: 

;; for subtract: 
(equal? 
 ((subtract (list 2 3 4)) (list 2 3 4))
 (list 0 0))

(equal? 
 ((subtract (list 2 3 4)) (list 4 4 4))
 (list -2 -4))

;; for subtract-row1-from-all-rows: 
(equal? 
 (subtract-row1-from-all-rows (list 2 3 4)
			      (list (list 2 3 4)
				    (list 4 4 4)))
 (list 
  (list  0  0)
  (list -2 -4)))

;; for gauss: 
(equal? 
 (gauss (list (list 2 2  3 10) 
	      (list 2 5 12 31)  
	      (list 4 1 -2  1)))
 (list (list 2 2  3   10) 
       (list   3  9   21)  
       (list      1    2)))
 (equal? 
   (gauss 
    (list (list 2 3 3 8)
	  (list 2 3 -2 3)
	  (list 4 -2 2 4)))
   (list (list 2 3  3   8)
	 (list  -8 -4 -12)
	 (list     -5  -5)))
|#
