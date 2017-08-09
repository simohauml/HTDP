;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 17.2.1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; Language: Beginning Student with List Abbreviations

#| 17.2.1 hours->wages
------------------------------------------------------------
;Data Definition:
an employee is a structure:
     (make-employee n s p)
where n and s are symbols and p is a number
|#
(define-struct employee (name ssn payRate))

#|
a list-of-employees is either
  1. empty or
  2. (cons e loe)
  where e is an employee and loe is a list-of-employees

a work-record is a structure:
     (make-work-record n h)
where n is a symbol and h is a number
|#
(define-struct work-record (name hours))

#|
a list-of-work-records is either
  1. empty or
  2. (cons w low)
  where w is a work-record and low is a list-of-work-records
  
a weekly-pay is a structure:
     (make-weekly-pay n w)
where n is a symbol and w is a number
|#
(define-struct weekly-pay (name pay))

#|
a list-of-weekly-pay is either
  1. empty or
  2. (cons wp lowp)
  where wp is a weekly-pay and lowp is a list-of-weekly-pay
|#
;define some list-of-employees to be used in the tests
(define twoEmployees
  (list (make-employee 'john '123-78-6548 12.50)
        (make-employee 'mary '892-46-3891 14.25)))

(define fiveEmployees
  (list (make-employee 'john '123-78-6548 12.50)
        (make-employee 'mary '892-46-3891 14.25)
        (make-employee 'bill '654-78-9665 14.80)
        (make-employee 'walter '564-89-9659 15.95)
        (make-employee 'sally '567-78-9658 16.15)))

;define some list-of-work-records to be used in the tests
(define twoWorkRecords
  (list (make-work-record 'john 36.5)
        (make-work-record 'mary 42)))

(define fiveWorkRecords
  (list (make-work-record 'john 36.5)
        (make-work-record 'mary 42)
        (make-work-record 'bill 32)
        (make-work-record 'walter 38)
        (make-work-record 'sally 37.5)))
#|
;Template:
(define (hours->wages aloe alow)
  (cond
    [(empty? aloe) ...]
    [else
     ...(calc-weekly-pay (first aloe) (first alow))...
     ...(hours->wages (rest aloe) (rest alow))... ]))
|#

;;hours->wages : 
;;  list-of-employees list-of-work-records  
;;    ->  list-of-weekly-pay
;;to construct a new list-of-weekly-pay  by 
;;multiplying employee's pay rate by the 
;;corresponding hours in the list-of-work-records
;;ASSUMPTION: the two lists are of equal length 
;;ASSUMPTION: the two lists are in the same order so 
;;that the nth member of the first list has the same 
;;name as the nth element of the second list.
(define (hours->wages aloe alow)
  (cond
    [(empty? aloe) 
     empty]
    [else
     (cons 
      (calc-weekly-pay (first aloe) (first alow))
      (hours->wages (rest aloe) (rest alow)))]))

;Examples as Tests:
(check-expect 
 (hours->wages empty empty) 
 empty)

(check-expect 
 (hours->wages 
  (list (make-employee 'john '123-78-6548 12.50))
  (list (make-work-record 'john 36.5)))
 (list (make-weekly-pay 'john 456.25))) 

(check-expect 
 (hours->wages twoEmployees twoWorkRecords) 
 (list
  (make-weekly-pay 'john 456.25)
  (make-weekly-pay 'mary 598.5)))

(check-expect 
 (hours->wages fiveEmployees fiveWorkRecords)
 (list
  (make-weekly-pay 'john 456.25)
  (make-weekly-pay 'mary 598.5)
  (make-weekly-pay 'bill 473.6)
  (make-weekly-pay 'walter 606.1)
  (make-weekly-pay 'sally 605.625)))

#| We need a helper function that calculates weekly pay
------------------------------------------------------------
;Template
(define (calc-weekly-pay a-employee a-work-record)
     ... (employee-name a-employee) ... 
     ... (employee-ssn a-employee) ...
     ... (employee-payRate a-employee) ...
     ... (work-record-name a-work-record) ...
     ... (work-record-hours a-work-record) ...)
|#
;; employee->weekly-pay : employee work-record -> weekly-pay
;;consumes an employee and a work-record and produces the 
;;weekly-pay based on that data
(define (calc-weekly-pay a-employee a-work-record)
  (make-weekly-pay 
   (employee-name a-employee) 
   (* (employee-payRate a-employee) 
      (work-record-hours a-work-record))))

;Examples as Tests:
(check-expect 
 (calc-weekly-pay (make-employee 'john '123-78-6548 12.50)
                 (make-work-record 'john 36.5))
 (make-weekly-pay 'john 456.25))

(check-expect 
 (calc-weekly-pay (make-employee 'mary '892-46-3891 14.25)
                 (make-work-record 'mary 42))
 (make-weekly-pay 'mary 598.5))
