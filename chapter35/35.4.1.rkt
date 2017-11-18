;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 35.4.1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(define address-book empty)

;; add-to-address-book : symbol number -> void 
(define (add-to-address-book name phone) 
  (set! address-book (cons (list name phone) address-book))) 

;; lookup : symbol (listof (list symbol number)) -> number or false
;; to lookup the phone number for name in ab 
(define (lookup name ab) 
  (cond 
    [(empty? ab) false] 
    [else (cond 
            [(symbol=? (first (first ab)) name) 
             (second (first ab))] 
            [else (lookup name (rest ab))])])) 

;; remove : symbol -> void
(define (remove-address name)
  (set! address-book (remove-from-address-book name address-book)))

;; remove-from-address-book : symbol address-book -> address-book
;; returns a new address book that corresponds to the original address book,
;; but with `name' removed from the book
(define (remove-from-address-book name ab)
  (cond
    [(empty? ab) empty]
    [else (cond
            [(symbol=? (first (first ab)) name)
             (remove-from-address-book name (rest ab))]
            [else 
             (cons (first ab)
                   (remove-from-address-book name (rest ab)))])]))

;; examples as tests

(add-to-address-book 'bill 7035551111)
(add-to-address-book 'alice 7035552222)

(lookup 'bill address-book)
"should be"
7035551111

(remove-address 'bill)

(lookup 'bill address-book)
"should be"
false