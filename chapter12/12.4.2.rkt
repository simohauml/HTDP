;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 12.4.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
#| ------------------------------------------------------------------------
   Permutations

   Data Definitions:
    A word is either
      * empty
      * (cons S W) where S is a (letter) symbol and W is a word. 

    A list-of-words is either
      * empty
      * (cons W L) where W is a word and L is a list-of-words.

    Examples:
      empty is a word
      (list 'b) is a word
      (list 'a 'b) is a word
      (list 'b 'a) is a word
     
      empty is a list of words
      (list (list 'a 'b)) is a list of words
      (list (list 'a 'b) (list 'b 'a)) is a list of words

   arrangements : word -> (listof word)

   Purpose: compute all possible arrangements (permutations)
     of all the letters in a a-word; the result is a list of
     words 

   Example:
     empty has one arrangement empty, so the result should be 
        - (list empty)
     (list 'a) has one arrangment: (list 'a), so the result 
        should be
	- (list (list 'a))
     (list 'a 'b) has two different arrangements: 
        - (list 'b 'a)
	- (list 'a 'b)
     (list 'a 'b 'c) has six different arrangements: 
        - (list 'a 'b 'c)
	- (list 'a 'c 'b)
	- (list 'b 'a 'c)
	- (list 'b 'c 'a)
	- (list 'c 'a 'b)
	- (list 'c 'b 'a)
    Note: we should treat all "letters" as distinct from each other. 	
|# 
(define (arrangements a-word)
  (cond
    ((empty? a-word) (list empty))
    (else (insert-everywhere/all-words (first a-word) 
 				       (arrangements (rest a-word))))))
;; We need a "helper" that combines the permutations for the rest 
;; of the word with the first letter: insert-everywhere/all-words does the job.

#| ------------------------------------------------------------------------
   insert-everywhere/all-words : letter list-of-words -> list-of-words 
   Purpose: insert a-letter into all words of lo-words
   Example: 
     'a (list (list 'b)) produces (list (list 'a 'b) (list 'b 'a))
     'a (list (list 'b) (list 'c)) produces 
         (list (list (list 'a 'b) (list 'b 'a))
	       (list (list 'a 'c) (list 'c 'a)))
|#
(define (insert-everywhere/all-words letter lo-words)
  (cond
    ((empty? lo-words) empty)
    (else (append (insert-everywhere letter (first lo-words))
		  (insert-everywhere/all-words letter (rest lo-words))))))
;; We need a "helper" that inserts a letter into a single word. 

#| ------------------------------------------------------------------------
   insert-everywhere : letter word -> list-of-words

   Purpose: insert a-letter everywhere into word, beginning, end and
    between all letters of the word 

   Examples:
    'a (list 'b) ==> (list (list 'a 'b) (list 'b 'a))
    'a (list 'b 'c) ==> (list (list 'a 'b 'c)
			      (list 'b 'a 'c)
			      (list 'b 'c 'a))
|#

(define (insert-everywhere a-letter a-word)
  (cond
    ((empty? a-word) (list (list a-letter)))
    (else (cons (cons a-letter a-word) 
		(add-at-beginning (first a-word)
				  (insert-everywhere a-letter (rest a-word)))))))
;; We need a helper that adds a letter to the beginning of a list of words. 

#| ------------------------------------------------------------------------
   add-at-beginning : letter list-of-words -> list-of-words
   Purpose: add a-letter to the beginning of every word in lo-words
   Example: 
     'a (list (list 'b 'c) (list 'c 'b))) should produce 
        (list (list 'a 'b 'c) (list 'a 'c 'b))) 
|#
(define (add-at-beginning a-letter lo-words)
  (cond
    ((empty? lo-words) empty)
    (else (cons (cons a-letter (first lo-words))
		(add-at-beginning a-letter (rest lo-words))))))

#| ------------------------------------------------------------------------
   Tests: 

(add-at-beginning 'a (list (list 'b 'c) (list 'c 'b)))
= 
(list (list 'a 'b 'c) (list 'a 'c 'b)) 

(insert-everywhere 'a (list 'b))
= 
(list (list 'a 'b) (list 'b 'a))

(insert-everywhere/all-words 'a (list (list 'b)))
=
(list (list 'a 'b) (list 'b 'a))

(insert-everywhere/all-words 'a (list (list 'b) (list 'c)))
=
(list (list 'a 'b) (list 'b 'a)
      (list 'a 'c) (list 'c 'a))
|#

;(arrangements empty) 
;= (list empty)
;
;(arrangements (list 'a))
;= (list (list 'a))
;
;(arrangements (list 'a 'b))
;= (list (list 'a 'b)
;	(list 'b 'a))
;
;(arrangements (list 'a 'b 'c))
;= (list (list 'a 'b 'c)
;	(list 'a 'c 'b)
;	(list 'b 'a 'c)
;	(list 'b 'c 'a)
;	(list 'c 'a 'b)
;	(list 'c 'b 'a))

