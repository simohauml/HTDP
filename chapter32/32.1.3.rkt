;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 32.1.3) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
; <exp>	=	<var> |
;               (lambda (<var>) <exp>) |
;               (<exp> <exp>)
; The subset contains only three kinds of expressions:
;variables, functions of one argument, and function applications.

; Variables as symbols

; Struct Lam as lambda expression
(define-struct Lam (var body))

; Use List for function application

;===================================================================================

;1. (lambda (x) y)
(define exp1 (make-Lam 'x 'y))

;2. ((lambda (x) x) 
;      (lambda (x) x))
(define exp2 (list (make-Lam 'x 'x)
                   (make-Lam 'x 'x)))
;
;;3. (((lambda (y)
;;	 (lambda (x)
;;	   y))
;;       (lambda (z) z))
;;      (lambda (w) w))
(define exp3
  (list (list (make-Lam 'y
                        (make-Lam 'x 'y))
              (make-Lam 'z 'z))
        (make-Lam 'w 'w)))

; If a variable occurs in an expression but has no corresponding binding occurrence,
; the occurrence is said to be free.

; Make up an expression in which x occurs both free and bound.
(define exp4 (list (make-Lam 'y 'x)
                   (make-Lam 'x 'x)))

;; free-or-bound : Lam  ->  Lam 
;; to replace each non-binding occurrence of a variable in a-lam 
;; with 'free or 'bound, depending on whether the 
;; occurrence is bound or not.
(define (free-or-bound a-lam0)
  (local ((define (check a-lam seen)
            (cond
              [(symbol? a-lam)
               (if (member? a-lam seen)
                   'bound
                   'free)]
              [(Lam? a-lam)
               (local ((define body (Lam-body a-lam))
                       (define var (Lam-var a-lam)))
                 (cond
                   [(symbol? body)
                    (cond
                      [(equal? body var) (make-Lam var 'bound)]
                      [(member? body seen) (make-Lam var 'bound)]
                      [else (make-Lam var 'free)])]
                   [else (make-Lam var (check body (cons var seen)))]))]
              [(list? a-lam) (list (check (first a-lam) seen)
                                   (check (second a-lam) seen))]
              [else (error 'free-or-bound "not supported syntax")])))
    (check a-lam0 empty)))

;; unique-binding : Lam  ->  Lam 
;; to replace variables names of binding occurrences and their bound
;; counterparts so that no name is used twice in a binding occurrence
(define (unique-binding a-lam0)
  (local ((define (replace a-lam seen)
            (cond
              [(symbol? a-lam)
               (local ((define name (find a-lam seen)))
                 (cond
                   [(empty? name) a-lam]
                   [else (second name)]))]
              [(Lam? a-lam)
               (local ((define body (Lam-body a-lam))
                       (define var (Lam-var a-lam))
                       (define new-name-var (list var (gensym var))))
                 (cond
                   [(symbol? body)
                    (local ((define name-body (find body seen)))
                      (cond
                        [(equal? body var)
                         (make-Lam (second new-name-var) (second new-name-var))]
                        [(not (empty? name-body)) (make-Lam (second new-name-var) (second name-body))]
                        [else (make-Lam (second new-name-var) body)]))]
                   [else (make-Lam (second new-name-var) (replace body (list new-name-var seen)))]))]
              [(list? a-lam) (list (replace (first a-lam) seen)
                                   (replace (second a-lam) seen))]
              [else (error 'unique-binding "not supported syntax")])))
    (replace a-lam0 empty)))

; Find first encountered match
(define (find name lon)
  (cond
    [(empty? lon) empty]
    [(equal? name (first (first lon))) (first lon)]
    [else (find name (rest lon))]))



