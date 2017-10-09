;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 27.3.4) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define TOLERANCE 0.005)

;; find-root : (number  ->  number) number number  ->  number
;; to determine a number R such that f has a 
;; root between R and (+ R TOLERANCE) 
;; 
;; ASSUMPTION: f is continuous and monotonic
;(define (find-root f left right)
;  (cond
;    [(<= (- right left) TOLERANCE) left]
;    [else 
;      (local ((define mid (/ (+ left right) 2)))
;	(cond
;	  [(<= (f mid) 0 (f right)) 
;           (find-root f mid right)]
;	  [else 
;           (find-root f left mid)]))]))

(define (find-root f left right)
  (local ((define f-left (f left))
          (define f-right (f right))
          (define (find-root-aux f left right fleft fright)
            (cond
              [(<= (- right left) TOLERANCE) left]
              [else (local ((define mid (/ (+ left right) 2))
                            (define f-mid (f mid)))
                      (cond
                        [(<= f-mid 0 fright)
                         (find-root-aux f mid right f-mid fright)]
                        [else
                         (find-root-aux f left mid fleft f-mid)]))])))
    (find-root-aux f left right f-left f-right)))

;; poly : number  ->  number
(define (poly x)
  (* (- x 2) (- x 4)))

(find-root poly 3 6)