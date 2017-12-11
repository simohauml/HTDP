;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 37.3.3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; Data Analysis and Definitions:

;; A letter is a symbol in: 'a ... 'z plus '_

;; A word is a (listof letter).

;; A body-part is one of the following symbols:
(define PARTS '(head body right-arm left-arm right-leg left-leg))

;; Constants:
;; some guessing words: 
(define WORDS 
  '((h e l l o)
    (w o r l d)
    (i s)
    (a)
    (s t u p i d)
    (p r o g r a m)
    (a n d)
    (s h o u l d)
    (n e v e r)
    (b e)
    (u s e d)
    (o k a y)
    ))

;; the number of words we can choose from 
(define WORDS# (length WORDS))

;; chosen-word : word
;; the word that the player is to guess
(define chosen-word (first WORDS))

;; status-word : word
;; represents which letters the player has and hasn't guessed
(define status-word (first WORDS))

;; body-parts-left : (listof body-part)
;; represents the list of body parts that are still "available"
(define body-parts-left PARTS)

;; guess history
(define history empty)

;; new-knowledge : boolean
;; the variable represents whether the most recent application of
;; reveal-list has provided the player with new knowledge
(define new-knowledge false)

;; hangman :  ->  void
;; effect: initialize chosen-word, status-word, and body-parts-left
(define (hangman)
  (begin
    (set! chosen-word (list-ref WORDS (random (length WORDS))))
    (set! status-word (build-list (length chosen-word) (lambda (x) '_)))
    (set! body-parts-left PARTS)
    (set! history '())))

;; hangman-guess : letter  ->  response
;; to determine whether the player has won, lost, or may continue to play
;; and, if so, which body part was lost, if no progress was made
;; effects: (1) if the guess represents progress, update status-word
;; (2) if not, shorten the body-parts-left by one 
(define (hangman-guess guess)
  (if (member? guess history)
      (list "You have used this guess before." status-word)
      (begin
        (set! history (cons guess history))
        (local ((define new-status (reveal-list chosen-word status-word guess)))
          (cond
            [(not new-knowledge)
             (local ((define next-part (first body-parts-left)))
               (begin 
                 (set! body-parts-left (rest body-parts-left))
                 (cond
                   [(empty? body-parts-left) (list "The End" chosen-word)]
                   [else (list "Sorry" next-part status-word)])))]
            [else
             (cond
               [(equal? new-status chosen-word) "You won"]
               [else 
                (begin 
                  (set! status-word new-status)
                  (list "Good guess!" status-word))])])))))

;; reveal-list : word word letter  ->  word
;; to compute the new status word
;; effect: to set new-knowledge to true if guess reveals new knowledge
(define (reveal-list chosen-word status-word guess)
  (local ((define (reveal-one chosen-letter status-letter)
	    (cond
	      [(and (symbol=? chosen-letter guess)
		    (symbol=? status-letter '_))
	       (begin
		 (set! new-knowledge true)
		 guess)]
	      [else status-letter])))
    (begin
      (set! new-knowledge false)
      (map reveal-one chosen-word status-word))))