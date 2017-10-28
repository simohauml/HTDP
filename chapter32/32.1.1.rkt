;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 32.1.1) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
; <exp>	=	<var> |
;               (lambda (<var>) <exp>) |
;               (<exp> <exp>)
; The subset contains only three kinds of expressions:
;variables, functions of one argument, and function applications.

; Variables as symbols

; Struct Lam as lambda expression
(define-struct Lam (var body))

; Use List for function application

;====================================================================

;1. (lambda (x) y)
(make-Lam 'x 'y)

;2. ((lambda (x) x) 
;      (lambda (x) x))
(list (make-Lam 'x 'x)
      (make-Lam 'x 'x))
;
;;3. (((lambda (y)
;;	 (lambda (x)
;;	   y))
;;       (lambda (z) z))
;;      (lambda (w) w))
(list (list (make-Lam 'y
                      (make-Lam 'x 'y))
            (make-Lam 'z 'z))
      (make-Lam 'w 'w))

; If a variable occurs in an expression but has no corresponding binding occurrence,
; the occurrence is said to be free.

; Make up an expression in which x occurs both free and bound.
(list (make-Lam 'y 'x)
      (make-Lam 'x 'x))