;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 31.3.6) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define (make-palindrome-r loc)
  (local ((define (invert loc)
            (cond
              [(empty? loc) empty]
              [else (append (invert (rest loc)) (list (first loc)))])))
    (append loc
            (rest (invert loc)))))

(define (make-palindrome loc)
  (local ((define (palindrome loc accu)
            (cond
              [(empty? loc) accu]
              [else (palindrome (rest loc) (cons (first loc) accu))])))
    (append loc
            (rest (palindrome loc empty)))))

;; make-palindrome : (NEListof Symbol) -> (Listof Symbol)
;; create the mirror image of the given "word" around its last letter

(define (make-palindrome.v0 word)
   (local (;; accumulator: keep track of all the letters seen so far
           [define (rev word reverse-seen)
             (cond
               [(empty? (rest word)) (cons (first word) reverse-seen)]
               [else (cons (first word) (rev (rest word) (cons (first word) reverse-seen)))])])
     (rev word empty)))

(define (make-palindrome.v1 word)
   (local (;; accumulator: keep track of all the letters seen so far
           [define (rev word reverse-seen)
             (cond
               [(empty? (rest word)) reverse-seen]
               [else (rev (rest word) (cons (first word) reverse-seen))])])
     (append word (rev word empty))))

;; Tests:
(equal? (make-palindrome.v0 '(r a c e)) '(r a c e c a r))
(equal? (make-palindrome.v1 '(r a c e)) '(r a c e c a r))
