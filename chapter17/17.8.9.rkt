;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 17.8.9) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(define (atom? a)
  (cond
    [(number? a) true]
    [(boolean? a) true]
    [(symbol? a) true]
    [else false]))

;;atom=?: atom atom -> boolean
;;consumes two atoms and returns true if
;;they are equal, false otherwise
(define (atom=? a-atom another-atom)
  (cond
    [(number? a-atom)
     (and (number? another-atom)
          (= a-atom another-atom))]
    [(boolean? a-atom)
     (and (boolean? another-atom)
          (boolean=? a-atom another-atom))]
    [(symbol? a-atom)
     (and (symbol? another-atom)
          (symbol=? a-atom another-atom))]))

;(define (Slist=? sl1 sl2)
;  (cond
;    [(and (empty? sl1)
;          (empty? sl2))
;     true]
;    [(empty? sl1) false]
;    [(empty? sl1) false]
;    [(and (atom? (car sl1))
;          (atom? (car sl2)))
;     (and (atom=? (car sl1) (car sl2))
;          (Slist=? (rest sl1) (rest sl2)))]
;    [(and (cons? (car sl1))
;          (cons? (car sl2)))
;     (and (Slist=? (car sl1) (car sl2))
;          (Slist=? (rest sl1) (rest sl2)))]
;    [else false]))

;;Slist=?: Slist Slist -> boolean
;;consumes two Slists and returns true if
;;they are equal, false otherwise
(define (Slist=? a-slist another-slist)
  (cond
    [(empty? a-slist) (empty? another-slist)]
    [else
     (and (cons? another-slist)
          (Sexpr=? (first a-slist) (first another-slist))
          (Slist=? (rest a-slist) (rest another-slist)))]))


;;Sexpr=?: Sexpr Sexpr -> boolean
;;consumes two Sexprs and returns true
;;if they are equal, false otherwise
(define (Sexpr=? a-sexpr another-sexpr)
  (cond
    [(atom? a-sexpr) (atom=? a-sexpr another-sexpr)]
    [else
     (and (or (empty? another-sexpr) (cons? another-sexpr))
          (Slist=? a-sexpr another-sexpr))]))