;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 18.1.15) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; extract1 : inventory  ->  inventory
;; to create an inventory from an-inv for all
;; those items that cost less than $1
;(define (extract1 an-inv)
;  (cond
;    [(empty? an-inv) empty]
;    [else (cond
;	    [(<= (ir-price (first an-inv)) 1.00)
;	     (cons (first an-inv) (extract1 (rest an-inv)))]
;	    [else (extract1 (rest an-inv))])]))

;; STRUCTURE DEFINITION
(define-struct ir (des price))

;; DATA DEFINITION
;;
;; > inventory-record (short: ir)
;;   an ir is a structure (make-ir symbol number)

(define (extract1 an-inv)
  (cond
    [(empty? an-inv) empty]
    [else (local
            [(define f (first an-inv))
             (define r (extract1 (rest an-inv)))]
            (cond
              [(<= (ir-price f) 1.00) (cons f r)]
              [else r]))]))

(check-expect (extract1 empty)
              empty)
(check-expect (extract1 (list (make-ir 'balloon .99)))
              (list (make-ir 'balloon .99)))
(check-expect (extract1 (list (make-ir 'toy-car 2.99))) 
              empty)