;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 22.3.1) (read-case-sensitive #t) (teachpacks ((lib "gui.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "gui.rkt" "teachpack" "htdp")) #f)))
;; Model:
;; the number of digits created for guessing
(define NUMBER-OF-DIGITS 5)
;; a randomly generated answer
(define rand-answer (random (expt 10 NUMBER-OF-DIGITS)))
;; build-number : (listof digit) -> number
;; to translate a list of digits into a number
;; example: (build-number (list 1 2 3)) = 123
(define (build-number x)
  (cond
    [(empty? x) 0]
    [else (+ (* (first x)
                (expt 10 (sub1 (length x))))
             (build-number (rest x)))]))
;; check-guess : list-of-digits number -> symbol
;; consumes a guess and a number to be guessed and tells how they relate
(define (check-guess guess target)
  (cond
    [(< guess target) "Too Small"]
    [(> guess target) "Too Large"]
    [(= guess target) "Perfect"]))
;;
;; View:
;; the ten digits as strings
(define DIGITS
  (build-list 10 number->string))
;; a list of digit choice menus
(define digit-choosers
  (local ((define (builder i) (make-choice DIGITS)))
    (build-list NUMBER-OF-DIGITS builder)))
;; a message field for saying hello and displaying the correctness
(define a-msg
  (make-message "Welcome"))
;;
;; Controller:
;; check-call-back : X -> true
;; to get the current choices of digits, convert them to a number,
;; and to draw this number as a string into the message field
(define (check-call-back b)
  (draw-message a-msg
                (check-guess (build-number (map choice-index digit-choosers))
                             rand-answer)))
(create-window
 (list
  (append digit-choosers (list a-msg))
  (list (make-button "Check Guess" check-call-back))))