;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 17.6.5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;;17.6.4 | Problem Statement | Table of Contents | 17.6.6
;; Language: Beginning Student with List Abbreviations

#| 17.6.5 gift-pick
------------------------------------------------------------
;Data Definition:
a name is a symbol

a list-of-names is either
  1. empty or
  2. (cons n lon)
  where n is a name and lon is a list-of-names

a list-of-list-of-names (list of arrangements) is either
  1. empty or
  2. (cons lon lolon)
  where lon is a list-of-names and
  lolon is a list-of-list-of-names

;Template:
This function is used to call the other functions
and does not follow a template based on the data.
|#

;; gift-pick: list-of-names  ->  list-of-names
;; to pick a "random" non-identity arrangement of names
(define (gift-pick names)
  (random-pick
   (non-same names (arrangements names))))

;Examples as Tests
(check-expect
 (gift-pick (list 'Carol 'Mary))
 (list 'Mary 'Carol))

(check-expect 
 (member (gift-pick (list 'Carol 'Mary 'John)) 
         (list
          (list 'Mary 'John 'Carol)
          (list 'John 'Carol 'Mary)))
 true)

(check-expect 
 (member (gift-pick (list 'Carol 'Mary 'John 'Ron)) 
         (list
          (list 'John 'Carol 'Ron 'Mary)
          (list 'Mary 'Carol 'Ron 'John)
          (list 'Mary 'Ron 'Carol 'John)
          (list 'Mary 'John 'Ron 'Carol)
          (list 'John 'Ron 'Carol 'Mary)
          (list 'Ron 'John 'Carol 'Mary)
          (list 'Ron 'Carol 'Mary 'John)
          (list 'John 'Ron 'Mary 'Carol)
          (list 'John 'Ron 'Carol 'Mary)
          (list 'Ron 'John 'Mary 'Carol)))
 true)

#|We need a helper function that chooses the lists 
that do not have the same symbol in the same place
------------------------------------------------------------
;Template:
(define (non-same names arrangements)
  (cond
    [(empty? arrangements)...]
    [else ...(first arrangements)...
          ...(non-same names (rest arrangements))...]))
|#

;;non-same:
;;  list-of-names list-of-list-of-names -> list-of-list-of-names
;;consumes a list of names L and a list of 
;;arrangements and produces the list of those 
;;that do not agree with L at any position
(define (non-same names arrangements)
  (cond
    [(empty? arrangements) empty]
    [else 
     (cond 
       [(any-match names (first arrangements))
        (non-same names (rest arrangements))]
       [else (cons (first arrangements)
                   (non-same names (rest arrangements)))])]))

;Examples as Tests:
(check-expect
 (non-same 
  (list 'Carol 'Mary)
  (list (list 'Carol 'Mary)
        (list 'Mary 'Carol)))
 (list (list 'Mary 'Carol)))

(check-expect
 (non-same 
  (list 'Carol 'Mary 'John)
  (list (list 'Mary 'John 'Carol)
        (list 'Mary 'Carol 'John)
        (list 'John 'Carol 'Mary)
        (list 'John 'Mary 'Carol)
        (list 'Carol 'John 'Mary)
        (list 'Carol 'Mary 'John)))
 (list (list 'Mary 'John 'Carol)
       (list 'John 'Carol 'Mary)))


#|We need a helper function that 
randomly selects one of the lists
------------------------------------------------------------
;Template:
(define (random-pick arrangements)
  (cond
    [(empty? arrangements)...]
    [else 
     ...(first arrangements)...
     ...(random-pick (rest arrangements))...]))
|#

;;random-pick : non-empty-list-of-list-of-names  ->  list-of-names
;;consumes a list of items and randomly 
;;picks one of them as the result;
(define (random-pick arrangements)
  (pick-nth (random (size-of arrangements)) arrangements))

(check-expect
 (random-pick (list (list 'Carol 'Mary)))
 (list  'Carol 'Mary))

(check-expect
 (member (random-pick (list (list 'Mary 'John 'Carol)
                            (list 'John 'Carol 'Mary)))
         (list 
          (list 'Mary 'John 'Carol)
          (list 'John 'Carol 'Mary)))
 true)

(check-expect
 (member (random-pick (list (list 'John 'Carol 'Ron 'Mary)
                            (list 'Mary 'Carol 'Ron 'John)
                            (list 'Mary 'Ron 'Carol 'John)
                            (list 'Mary 'John 'Ron 'Carol)
                            (list 'John 'Ron 'Carol 'Mary)
                            (list 'Ron 'John 'Carol 'Mary)
                            (list 'Ron 'Carol 'Mary 'John)
                            (list 'John 'Ron 'Mary 'Carol)
                            (list 'John 'Ron 'Carol 'Mary)
                            (list 'Ron 'John 'Mary 'Carol)))
         (list 
          (list 'John 'Carol 'Ron 'Mary)
          (list 'Mary 'Carol 'Ron 'John)
          (list 'Mary 'Ron 'Carol 'John)
          (list 'Mary 'John 'Ron 'Carol)
          (list 'John 'Ron 'Carol 'Mary)
          (list 'Ron 'John 'Carol 'Mary)
          (list 'Ron 'Carol 'Mary 'John)
          (list 'John 'Ron 'Mary 'Carol)
          (list 'John 'Ron 'Carol 'Mary)
          (list 'Ron 'John 'Mary 'Carol)))
 true)

#|We need a helper function that reports if any names 
in two list-of-names are in the same position
------------------------------------------------------------
;Template:
(define (any-match name arrangement)
  (cond
    [(empty? name)...]
    [else ...(first name)...(first arrangement)...
          ...(any-match (rest name) (rest arrangement))...]))
|#

;;any-match: list-of-names list-of-names -> true or false
;;consumes two list-of-names and returns true if 
;;any name is in the same position in both lists
;;ASSUMPTION: both lists are the same length
(define (any-match name arrangement)
  (cond
    [(empty? name) false]
    [else 
     (or (symbol=? (first name) (first arrangement))
         (any-match (rest name) (rest arrangement)))]))

;Examples as Tests:
(check-expect
 (any-match 
  (list 'Carol 'Mary)
  (list 'Carol 'Mary))
 true)

(check-expect
 (any-match 
  (list 'Carol 'Mary)
  (list 'Mary 'Carol))
 false)

(check-expect
 (any-match 
  (list 'Carol 'Mary 'John)
  (list 'Mary 'John 'Carol))
 false)

(check-expect
 (any-match 
  (list 'Carol 'Mary 'John)
  (list 'Carol 'John 'Mary))
 true) 

#|We need a helper function that determines how 
many arrangements are in a list of arrangements.
------------------------------------------------------------
;Template:
(define (size-of arrangements)
  (cond
    [(empty? arrangements)...]
    [else ...(first arrangements)...
          ...(size-of (rest arrangements))...]))
|#

;;size-of: list-of-list-of-names -> number
;;consumes a list of arrangements and returns 
;;how many arrangments are in the list
(define (size-of arrangements)
  (cond
    [(empty? arrangements) 0]
    [else (+ 1 (size-of (rest arrangements)))]))

;Examples as Tests:
(check-expect
 (size-of empty)
 0)

(check-expect
 (size-of 
  (list (list 'Carol 'Mary)))
 1)

(check-expect
 (size-of 
  (list (list 'Carol 'Mary)
        (list 'Mary 'Carol)))
 2)
(check-expect
 (size-of 
  (list (list 'Mary 'John 'Carol)
        (list 'Mary 'Carol 'John)
        (list 'John 'Carol 'Mary)
        (list 'John 'Mary 'Carol)
        (list 'Carol 'John 'Mary)
        (list 'Carol 'Mary 'John)))
 6)

#|We need a helper function that picks the
nth arrangement in a list of arrangements
------------------------------------------------------------
;Template:
(define (pick-nth n arrangements)
  (cond
    [(empty? arrangements)...]
    [else
     ...(first arrangements)...
     ...(pick-nth (sub1 n) (rest arrangements))...]))
|#

;;pick-nth: natural-number list-of-list-of-names -> list-of-names
;;consumes a number and a list of arrangements and returns the
;;arrangement in the list at postion n (position starts at 0)
;;ASSUMPTION: The list of arrangements contains at least n+1 
;;arrangements
(define (pick-nth n arrangements)
  (cond
    [(zero? n) (first arrangements)]
    [else (pick-nth (sub1 n) (rest arrangements))]))

;Examples as Tests:
(check-expect
 (pick-nth 0 
           (list (list 'Carol 'Mary)))
 (list 'Carol 'Mary))

(check-expect
 (pick-nth 0 
           (list (list 'Carol 'Mary)
                 (list 'Mary 'Carol)))
 (list 'Carol 'Mary))

(check-expect
 (pick-nth 1 
           (list (list 'Carol 'Mary)
                 (list 'Mary 'Carol)))
 (list 'Mary 'Carol))

(check-expect
 (pick-nth 3
           (list (list 'Mary 'John 'Carol)
                 (list 'Mary 'Carol 'John)
                 (list 'John 'Carol 'Mary)
                 (list 'John 'Mary 'Carol)
                 (list 'Carol 'John 'Mary)
                 (list 'Carol 'Mary 'John)))
 (list 'John 'Mary 'Carol))


#|----------------------------------------------------------
 arrangements copied from solutions 12.4.2
In 17.6.5 we are using name, list-of-names, and 
 list-of-list-of-names
These data definitions correspond in the following way
A name corresponds to a letter
A list-of-names corresponds to a word
A list-of-list-of-names corresponds to a list-of-words
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

   arrangements : word -> list-of-words

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
    (else (insert-everywhere/all-words 
           (first a-word) 
           (arrangements (rest a-word))))))

;; We need a "helper" that combines the permutations for the  
;; rest of the word with the first letter: 
;;insert-everywhere/all-words does the job.

#| ---------------------------------------------------------
insert-everywhere/all-words : 
letter list-of-words -> list-of-words 
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
    (else 
     (append 
      (insert-everywhere letter (first lo-words))
      (insert-everywhere/all-words letter (rest lo-words))))))
;; We need a "helper" that inserts a letter into a single word. 

#| ---------------------------------------------------------
   insert-everywhere : letter word -> list-of-words

   Purpose: insert a-letter everywhere into word, beginning,
    end and between all letters of the word 

   Examples:
    'a (list 'b) ==> (list (list 'a 'b) (list 'b 'a))
    'a (list 'b 'c) ==> (list (list 'a 'b 'c)
			      (list 'b 'a 'c)
			      (list 'b 'c 'a))
|#

(define (insert-everywhere a-letter a-word)
  (cond
    ((empty? a-word) (list (list a-letter)))
    (else 
     (cons (cons a-letter a-word) 
           (add-at-beginning 
            (first a-word)
            (insert-everywhere a-letter (rest a-word)))))))
;; We need a helper that adds a letter to the beginning of a
;; list of words. 

#| ---------------------------------------------------------
add-at-beginning : letter list-of-words -> list-of-words
Purpose: add a-letter to the beginning of every word in 
lo-words
Example: 
  'a (list (list 'b 'c) (list 'c 'b))) should produce 
     (list (list 'a 'b 'c) (list 'a 'c 'b))) 
|#
(define (add-at-beginning a-letter lo-words)
  (cond
    ((empty? lo-words) empty)
    (else (cons (cons a-letter (first lo-words))
                (add-at-beginning a-letter (rest lo-words))))))

#| ---------------------------------------------------------
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

(check-expect 
 (arrangements empty) 
 (list empty))

(check-expect 
 (arrangements (list 'a))
 (list (list 'a)))

(check-expect 
 (arrangements (list 'a 'b))
 (list (list 'a 'b)
       (list 'b 'a)))

(check-expect 
 (arrangements (list 'a 'b 'c))
 (list (list 'a 'b 'c)
       (list 'b 'a 'c)
       (list 'b 'c 'a)
       (list 'a 'c 'b)
       (list 'c 'a 'b)
       (list 'c 'b 'a)))

