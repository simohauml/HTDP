;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 27.2.3) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define-struct rr (table costs))

;; constant definitions
(define NEWLINE 'NL)

(define (file->list-of-checks afile)
 (local ((define (internal afile)
           (cond
             [(empty? afile) empty]
             [else
              (cons (makerr (first-line afile)) (internal (remove-first-line afile)))]))
         (define (abs afile bas com)
           (cond
             [(empty? afile) empty]
             [else (cond
                     [(equal? (first afile) NEWLINE) (bas afile)]
                     [else (com (first afile) (abs (rest afile) bas com))])]))
         (define (first-line afile) (abs afile
                                         (lambda (x) empty)
                                         cons))
         (define (remove-first-line afile) (abs afile
                                                rest
                                                (lambda (a d) d)))
         (define (makerr line) (make-rr (first line) (rest line))))
   ;; -- IN --
   (internal afile)))

(define l1 (list 1 2.30 4.00 12.50 13.50 'NL
       	        2 4.00 18.00 'NL
                4 2.30 12.50))

(file->list-of-checks l1)