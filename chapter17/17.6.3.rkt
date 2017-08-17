;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 17.6.3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;;17.6.2 | Problem Statement | Table of Contents | 17.6.4
;; Language: Beginning Student with List Abbreviations

#| 17.6.3 hours->wages2
------------------------------------------------------------
;Data Definition:
employee-record is a structure
     (make-employee-record n i pr)
where n is a symbol and i and pr are numbers
|#
(define-struct employee-record (name id payRate))

#|
a list-of-employee-records is either
  1. empty or
  2. (cons er loer)
  where er is an employee-record and 
  loer is a list-of-employee-records

punch-card is a structure
     (make-punch-card i h)
where i and h are numbers
|#
(define-struct punch-card (id hours))

#|
a list-of-punch-cards is either
  1. empty or
  2. (cons pc lopc)
  where pc is a punch-card and lopc is a list-of-punch-cards

a weekly-wage is a structure:
     (make-weekly-wage n w)
where n is a symbol and w is a number
|#
(define-struct weekly-wage (name pay))

#|
a list-of-weekly-wages is either
  1. empty or
  2. (cons ww loww)
  where ww is a weekly-wage and 
  loww is a list-of-weekly-wages

;Template:
This function is used to call the sorting functions
and the hours to wages function that works with sorted 
lists and does not follow a template based on the data.
|#

;;hours->wages2:
;;  list-of-employee-records list-of-punch-cards 
;;    -> list-of-weekly-wages
;;The function consumes a list-of-employee-records and a 
;;list-of-punch-cards. It computes the weekly wage for
;;each employee by matching the employee record with a 
;;punch-card based on employee numbers and returns a 
;;list-of-weekly-wages. If a pair is missing or if a
;;pair's employee numbers are mismatched, the function 
;;stops with an appropriate error message. 
;;ASSUMPTION: there is at most one card per 
;;employee and employee number.
(define (hours->wages2 aloer alopc)
  (hours->wages-sorted
   (sort-employee-record aloer)
   (sort-punch-cards alopc)))

;Examples as Tests:
(check-expect 
 (hours->wages2 empty empty)
 empty)

(check-error 
 (hours->wages2 
  (list (make-employee-record 'John 495 14.35))
  empty)
 "hours->wages2: employee record and punch card do not match")

(check-error 
 (hours->wages2
  empty
  (list (make-punch-card 495 38)))
 "hours->wages2: employee record and punch card do not match")

(check-expect 
 (hours->wages2
  (list (make-employee-record 'John 495 14.35))
  (list (make-punch-card 495 38)))
 (list (make-weekly-wage 'John 545.3)))

(check-expect 
 (hours->wages2
  (list (make-employee-record 'John 495 14.35)
        (make-employee-record 'Mary 382 12.15)
        (make-employee-record 'Carol 751 15.1))
  (list (make-punch-card 495 38)
        (make-punch-card 751 32)
        (make-punch-card 382 41)))
 (list (make-weekly-wage 'Mary 498.15)
       (make-weekly-wage 'John 545.3)
       (make-weekly-wage 'Carol 483.2)))

(check-error 
 (hours->wages2
  (list (make-employee-record 'John 495 14.35)
        (make-employee-record 'Carol 751 15.1))
  (list (make-punch-card 751 32)
        (make-punch-card 495 38)
        (make-punch-card 382 41)))
 "hours->wages2: employee record and punch card do not match")

(check-error 
 (hours->wages2
  (list (make-employee-record 'John 495 14.35)
        (make-employee-record 'Mary 382 12.15)
        (make-employee-record 'Carol 751 15.1))
  (list (make-punch-card 382 41)
        (make-punch-card 751 32)))
 "hours->wages2: employee record and punch card do not match")

#|We need a helper function that uses sorted employee-records
and sorted punch-cards and produces a list-of-weekly-wages
------------------------------------------------------------
;Template:
(define (hours->wages-sorted aloer alopc) 
  (cond
    [(and (empty? aloer) (empty? alopc)) ...]
    [(and (empty? aloer) (cons? alopc)) 
     ... (first alopc) ...
     ... (rest alopc) ...]
    [(and (cons? aloer) (empty? alopc)) 
     ... (first aloer) ... 
     ... (rest aloer) ...]
    [(and (cons? aloer) (cons? alopc)) 
     ... (calc-weekly-wage (first aloer) (first alopc)) ...
     ... (hours->wages-sorted (rest aloer) (rest alopc)) ...]))
|#
;;hours->wages-sorted:
;;  sorted list-of-employee-records
;;  sorted list-of-punch-cards 
;;    -> list-of-weekly-wages
;;consumes a sorted list-of-employee-records and a sorted
;;list-of-punch-cards. It computes the weekly wage for
;;each employee by matching the employee record with a 
;;punch-card based on employee numbers and returns a 
;;list-of-weekly-wages. If a pair is missing or if a
;;pair's employee numbers are mismatched, the function 
;;stops with an appropriate error message. 
;;ASSUMPTION: there is at most one card per employee
;;and employee number.
(define (hours->wages-sorted aloer alopc) 
  (cond
    [(and (empty? aloer) (empty? alopc)) empty] 
    [(or (empty? aloer) (empty? alopc))
     (error 'hours->wages2
            "employee record and punch card do not match")]
    [else      
     (cons (calc-weekly-wage (first aloer) (first alopc))
           (hours->wages-sorted (rest aloer) (rest alopc)))]))

;Examples as Tests:
(check-expect 
 (hours->wages-sorted empty empty)
 empty)

(check-error 
 (hours->wages-sorted 
  (list (make-employee-record 'John 495 14.35))
  empty)
 "hours->wages2: employee record and punch card do not match")

(check-error 
 (hours->wages-sorted
  empty
  (list (make-punch-card 495 38)))
 "hours->wages2: employee record and punch card do not match")

(check-expect 
 (hours->wages-sorted
  (list (make-employee-record 'John 495 14.35))
  (list (make-punch-card 495 38)))
 (list (make-weekly-wage 'John 545.3)))

(check-expect 
 (hours->wages-sorted
  (list (make-employee-record 'Mary 382 12.15)
        (make-employee-record 'John 495 14.35)
        (make-employee-record 'Carol 751 15.1))
  (list (make-punch-card 382 41)
        (make-punch-card 495 38)
        (make-punch-card 751 32)))
 (list (make-weekly-wage 'Mary 498.15)
       (make-weekly-wage 'John 545.3)
       (make-weekly-wage 'Carol 483.2)))

(check-error 
 (hours->wages-sorted
  (list (make-employee-record 'John 495 14.35)
        (make-employee-record 'Carol 751 15.1))
  (list (make-punch-card 382 41)
        (make-punch-card 495 38)
        (make-punch-card 751 32)))
 "hours->wages2: employee record and punch card do not match")

(check-error 
 (hours->wages-sorted
  (list (make-employee-record 'Mary 382 12.15)
        (make-employee-record 'John 495 14.35)
        (make-employee-record 'Carol 751 15.1))
  (list (make-punch-card 382 41)
        (make-punch-card 751 32)))
 "hours->wages2: employee record and punch card do not match")

#| We need a helper function that consumes an 
employee-record and a punch-card and calculates 
the weekly-wage for that employee
------------------------------------------------------------
;template:
(define (calc-weekly-wage a-er a-pc)
  ... (employee-record-name a-er) ... 
  ... (employee-record-id a-er) ...
  ... (employee-record-payRate a-er) ...
  ... (punch-card-id a-pc) ...
  ... (punch-card-hours a-pc) ...)
|#

;;Contract, Purpose, Header, Definition:
;;calc-weekly-wage: employee-record punch-card -> weekly-wage
;;consumes an employee-record and a punch-card and
;;produces the weekly-wage for that employee. Produces 
;;an error if the employee ids do not match.
(define (calc-weekly-wage a-er a-pc)
  (cond
    [(equal? (employee-record-id a-er)
             (punch-card-id a-pc))
     (make-weekly-wage 
      (employee-record-name a-er)
      (* (employee-record-payRate a-er) 
         (punch-card-hours a-pc)))]
    [else
     (error 'hours->wages2
            "employee record and punch card do not match")]))

;Examples as Tests:
(check-expect
 (calc-weekly-wage
  (make-employee-record 'John 495 14.35)
  (make-punch-card 495 38))
 (make-weekly-wage 'John 545.3))

(check-expect
 (calc-weekly-wage
  (make-employee-record 'Mary 382 12.15)
  (make-punch-card 382 41))
 (make-weekly-wage 'Mary 498.15))

(check-error 
 (calc-weekly-wage
  (make-employee-record 'Mary 382 12.15)
  (make-punch-card 495 38))
 "hours->wages2: employee record and punch card do not match")


#|We need a helper function that can 
sort a list-of-employee-records
------------------------------------------------------------
;Template:
(define (sort-employee-record aloer) 
  (cond
    [(empty? aloer) ...]
    [else ... (first aloer) ...
          ... (sort-employee-record (rest aloer)) ...]))
|#
;;sort-employee-record: 
;;list-of-employee-records -> list-of-employee-records (sorted)
;;to create a sorted list-of-employee-records from all the 
;;employee-records in aloer
(define (sort-employee-record aloer) 
  (cond
    [(empty? aloer) empty]
    [else (insert-employee-record 
           (first aloer) 
           (sort-employee-record (rest aloer)))]))

;Examples and Tests:
(check-expect (sort-employee-record empty)
              empty)

(check-expect 
 (sort-employee-record 
  (list (make-employee-record 'Mary 382 12.15)))
 (list (make-employee-record 'Mary 382 12.15)))

(check-expect 
 (sort-employee-record 
  (list (make-employee-record 'John 495 14.35)
        (make-employee-record 'Mary 382 12.15)
        (make-employee-record 'Carol 751 15.1)))
 (list (make-employee-record 'Mary 382 12.15)
       (make-employee-record 'John 495 14.35)
       (make-employee-record 'Carol 751 15.1)))

#|We need a helper function that inserts an 
employee-record in order by employee-record-id
------------------------------------------------------------
;Template:
(define (insert-employee-record  er aloer) 
  (cond
    [(empty? aloer) ...]
    [else 
     ... (first aloer) ...
     ... (insert-employee-record  er (rest aloer)) ...]))
|#
;;insert-employee-record: 
;;  employee-record list-of-employee-records (sorted) 
;;    -> list-of-employee-records (sorted)
;;inserts the employee-record in order into a sorted 
;;list-of-employee-records
(define (insert-employee-record er aloer) 
  (cond
    [(empty? aloer) (list er)]
    [else 
     (cond
       [(is-before-er er (first aloer))
        (cons er aloer)]
       [else 
        (cons (first aloer) 
              (insert-employee-record er (rest aloer)))])]))

;Examples as Tests:
(check-expect 
 (insert-employee-record  
  (make-employee-record 'John 495 14.35) 
  empty)
 (list (make-employee-record 'John 495 14.35)))

(check-expect 
 (insert-employee-record  
  (make-employee-record 'John 495 14.35) 
  (list (make-employee-record 'Mary 382 12.15)))
 (list (make-employee-record 'Mary 382 12.15) 
       (make-employee-record 'John 495 14.35)))

(check-expect 
 (insert-employee-record  
  (make-employee-record 'John 495 14.35) 
  (list (make-employee-record 'Carol 751 15.1)))
 (list (make-employee-record 'John 495 14.35) 
       (make-employee-record 'Carol 751 15.1)))

(check-expect 
 (insert-employee-record  
  (make-employee-record 'John 495 14.35) 
  (list (make-employee-record 'Mary 382 12.15) 
        (make-employee-record 'Carol 751 15.1)))
 (list (make-employee-record 'Mary 382 12.15) 
       (make-employee-record 'John 495 14.35) 
       (make-employee-record 'Carol 751 15.1)))

#| We need a helper function that consumes two 
employee-records and reports if the first 
employee-record should come before the second
------------------------------------------------------------
;template:
(define (is-before-er a-er another-er)
  ... (employee-record-name a-er) ... 
  ... (employee-record-id a-er) ...
  ... (employee-record-payRate a-er) ...  
  ... (employee-record-name another-er) ... 
  ... (employee-record-id another-er) ...
  ... (employee-record-payRate another-er) ...)
|#

;;Contract, Purpose, Header, Definition:
;;is-before-er: employee-record employee-record -> boolean
;;consumes two employee-records and returns ture if the 
;;first employee-record should come before the second
;;in an ordered list of employee-records
(define (is-before-er a-er another-er)
  (< (employee-record-id a-er)
     (employee-record-id another-er)))  

;Examples as Tests:
(check-expect
 (is-before-er 
  (make-employee-record 'John 495 14.35) 
  (make-employee-record 'Carol 751 15.1))
 true)

(check-expect
 (is-before-er     
  (make-employee-record 'Carol 751 15.1)
  (make-employee-record 'John 495 14.35))
 false)



#|We need a helper function that can 
sort a list-of-punch-cards
------------------------------------------------------------
;Template:
(define (sort-punch-cards alopc) 
  (cond
    [(empty? alopc) ...]
    [else ... (first alopc) ...
          ... (sort-punch-cards (rest alopc)) ...]))
|#
;;sort-punch-cards: 
;;  list-of-punch-cards -> list-of-punch-cards (sorted)
;;to create a sorted list-of-punch-cards from all the 
;;punch-cards in alopc
(define (sort-punch-cards alopc) 
  (cond
    [(empty? alopc) empty]
    [else (insert-punch-cards
           (first alopc) 
           (sort-punch-cards (rest alopc)))]))

;Examples as Tests:
(check-expect (sort-punch-cards empty)
              empty)

(check-expect 
 (sort-punch-cards 
  (list (make-punch-card 382 41)))
 (list (make-punch-card 382 41)))

(check-expect 
 (sort-punch-cards 
  (list (make-punch-card 495 38)
        (make-punch-card 382 41)
        (make-punch-card 751 32)))
 (list (make-punch-card 382 41)
       (make-punch-card 495 38)
       (make-punch-card 751 32)))

#|We need a helper function that inserts a 
punch-card in order by punch-card-id
------------------------------------------------------------
;Template:
(define (insert-punch-cards  pc alopc) 
  (cond
    [(empty? alopc) ...]
    [else ... (first alopc) ...
          ... (insert-punch-cards  pc (rest alopc)) ...]))
|#
;;insert-punch-cards: 
;;  punch-card list-of-punch-cards (sorted) 
;;    -> list-of-punch-cards (sorted)
;;inserts the punch-card in order into a sorted 
;;list-of-punch-cards
(define (insert-punch-cards pc alopc) 
  (cond
    [(empty? alopc) (list pc)]
    [else 
     (cond
       [(is-before-pc pc (first alopc))
        (cons pc alopc)]
       [else 
        (cons (first alopc) 
              (insert-punch-cards pc (rest alopc)))])]))

;;Examples as Tests:
(check-expect 
 (insert-punch-cards 
  (make-punch-card 495 38) 
  empty)
 (list (make-punch-card 495 38)))

(check-expect 
 (insert-punch-cards 
  (make-punch-card 495 38) 
  (list (make-punch-card 382 41)))
 (list (make-punch-card 382 41) 
       (make-punch-card 495 38)))

(check-expect 
 (insert-punch-cards  
  (make-punch-card 495 38) 
  (list (make-punch-card 751 32)))
 (list (make-punch-card 495 38) 
       (make-punch-card 751 32)))

(check-expect 
 (insert-punch-cards  
  (make-punch-card 495 38) 
  (list (make-punch-card 382 41) 
        (make-punch-card 751 32)))
 (list (make-punch-card 382 41) 
       (make-punch-card 495 38) 
       (make-punch-card 751 32)))

#| We need a helper function that consumes 
two punch-cards and reports if the first 
punch-card should come before the second
------------------------------------------------------------
;template:
(define (is-before-pc a-pc another-pc)
  ...(punch-card-id a-pc)...
  ...(punch-card-hours a-pc)...
  ...(punch-card-id another-pc)...
  ...(punch-card-hours another-pc)...)
|#

;;Contract, Purpose, Header, Definition:
;;is-before-pc: punch-card punch-card -> boolean
;;consumes two punch-cards and reports if the first 
;;punch-card should come before the second in a
;;list of sorted punch-cards
(define (is-before-pc a-pc another-pc)
  (< (punch-card-id a-pc)
     (punch-card-id another-pc)))

;Examples as Tests:
(check-expect
 (is-before-pc 
  (make-punch-card 382 41)
  (make-punch-card 495 38))
 true)

(check-expect
 (is-before-pc 
  (make-punch-card 495 38)
  (make-punch-card 382 41))
 false)