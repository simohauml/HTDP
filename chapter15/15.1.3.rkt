;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 15.1.3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; A parent is a structure: (make-parent loc n d e) 
;; where loc is a list of children, 
;; n and e are symbols, and d is a number. 
(define-struct parent (children name date eyes))

;; EXAMPLES OF DATA
(define robby (make-parent empty "Robby" 1972 'blue))
(define ted (make-parent empty "Ted" 1975 'brown))
(define pat (make-parent empty "Pat" 1978 'brown))
(define pete (make-parent empty "Pete" 1982 'brown))
(define alice (make-parent (list robby ted pat pete) "Alice" 1949 'blue))
(define bill (make-parent (list robby ted pat pete) "Bill" 1949 'brown))
(define lolly (make-parent empty "Lolly" 1951 'blue))
(define tutu (make-parent (list alice lolly) "Tutu" 1911 'brown))

(define Jango (make-parent empty 'Jango 2010 'blue))
 
(define Jennifer-Gustav (list Jango))
(define Jennifer (make-parent Jennifer-Gustav 'Jennifer 1988 'purple))
(define Gustav (make-parent Jennifer-Gustav 'Gustav 1988 'brown))
 
(define Fred-Eva (list Gustav))
(define Fred (make-parent Fred-Eva 'Fred 1965 'pink))
 
(define Eva (make-parent Fred-Eva 'Eva 1965 'blue))
(define Dave (make-parent empty 'Dave 1955 'black))
(define Adam (make-parent empty 'Adam 1950 'yellow))
 
(define Carl-Bettina (list Adam Dave Eva))
(define Carl (make-parent Carl-Bettina 'Carl 1926 'green))
(define Bettina (make-parent Carl-Bettina 'Bettina 1926 'green))

(define (count-descendants a-parent)
  (cond
    [(empty? (parent-children a-parent)) 1]
    [else
     (+ 1 (count-descendants-children (parent-children a-parent)))]))

(define (count-descendants-children lop)
  (cond
    [(empty? lop) 0]
    [else
     (+ (count-descendants (first lop))
        (count-descendants-children (rest lop)))]))

(define (count-proper-descendants a-parent)
  (- (count-descendants a-parent) 1))

