;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 27.2.2) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; file->list-of-lines : file  ->  (listof (listof symbol))
;; to convert a file into a list of lines 
;(define (file->list-of-lines afile)
;  (cond
;    [(empty? afile) empty]
;    [else
;      (cons (first-line afile)
;	    (file->list-of-lines (remove-first-line afile)))]))

;; first-line : file  ->  (listof symbol)
;; to compute the prefix of afile up to the first occurrence of NEWLINE
;(define (first-line afile)
;  (cond
;    [(empty? afile) empty]
;    [else (cond
;	    [(symbol=? (first afile) NEWLINE) empty]
;	    [else (cons (first afile) (first-line (rest afile)))])]))

;; remove-first-line : file  ->  (listof symbol)
;; to compute the suffix of afile behind the first occurrence of NEWLINE
;(define (remove-first-line afile)
;  (cond
;    [(empty? afile) empty]
;    [else (cond
;	    [(symbol=? (first afile) NEWLINE) (rest afile)]
;	    [else (remove-first-line (rest afile))])]))

;(define NEWLINE 'NL)

;(define (file->list-of-lines afile)
;  (cond
;    [(empty? afile) empty]
;    [else (local ((define (first-line afile)
;                    (cond
;                      [(empty? afile) empty]
;                      [else (cond
;                              [(symbol=? (first afile) NEWLINE) empty]
;                              [else (cons (first afile) (first-line (rest afile)))])]))
;                  (define (remove-first-line afile)
;                    (cond
;                      [(empty? afile) empty]
;                      [else (cond
;                              [(symbol=? (first afile) NEWLINE) (rest afile)]
;                              [else (remove-first-line (rest afile))])])))
;            (cons (first-line afile)
;                  (file->list-of-lines (remove-first-line afile))))]))

;; Language: Intermediate Student with Lambda

;; constant definitions
(define NEWLINE 'NL)

;; data definitions
;; File = (Listof Symbol)
;; Line = (Listof Symbol)

;; file->list-of-lines : File  ->  (Listof Line)
(define (file->list-of-lines afile)
 (local (;; internal : File  ->  (Listof Line)
         ;; to convert a file into a list of lines
         (define (internal afile)
           (cond
             [(empty? afile) empty]
             [else
              (cons (first-line afile) (internal (remove-first-line afile)))]))
#|
         ;; first-line : file  ->  Line
         ;; the prefix of afile up to the first occurrence of NEWLINE
         (define (first-line.OLD afile)
           (cond
             [(empty? afile) empty]
             [else (cond
                     [(symbol=? (first afile) NEWLINE) empty]
                     [else (cons (first afile) (first-line (rest afile)))])]))

         ;; remove-first-line : file  ->  Line
         ;; the suffix of afile behind the first occurrence of NEWLINE
         (define (remove-first-line.OLD afile)
           (cond
             [(empty? afile) empty]
             [else (cond
                     [(symbol=? (first afile) NEWLINE) (rest afile)]
                     [else (remove-first-line (rest afile))])]))
|#
         ;; File (File -> Line)  (Symbol Line -> Line) -> Line
         ;; an abstraction of first-line and remove-first-line
         (define (abs afile bas com)
           (cond
             [(empty? afile) empty]
             [else (cond
                     [(symbol=? (first afile) NEWLINE) (bas afile)]
                     [else (com (first afile) (abs (rest afile) bas com))])]))

         (define (first-line afile) (abs afile (lambda (x) empty) cons))

         (define (remove-first-line afile) (abs afile rest (lambda (a d) d))))
   ;; -- IN --
   (internal afile)))

(check-expect (file->list-of-lines (list 'a 'b NEWLINE 'c)) 
              '((a b) (c)))

;(define file1 (list 'a 'b 'c 'NL 'd 'e 'NL 'f 'g 'h 'NL))
;
;(file->list-of-lines file1)