;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 15.3.3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; Language: Beginning Student with List Abbreviations

;; Data Definitions

(define-struct wp (header body))
;; A Web-page (short: WP) is a structure:
;;   (make-wp h p) 
;; where h is a symbol and p is a (Web) document.

;; A (Web) document is either:
;; 1. empty
;; 2. (cons s p)  where s is a symbol and p is a (Web) document
;; 3. (cons wp p)  where wp is a web-page and p is a document

;; A list-of-symbols is either:
;; 1. empty
;; 2. (cons symbol list-of-symbols)

;; occurs : WP symbol -> boolean
(define (occurs wp word)
  (occurs-doc (wp-body wp) word))

;; occurs : document symbol -> boolean
(define (occurs-doc doc word)
  (cond
    [(empty? doc) false]
    [(symbol? (first doc))
     (or (symbol=? word (first doc))
         (occurs-doc (rest doc) word))]
    [else
     (or (occurs (first doc) word)
         (occurs-doc (rest doc) word))]))

;; --- test code

;; data examples:
(define empty-page (make-wp 'empty-page empty))
(define page-1-word (make-wp 'page-1-word (cons 'w1 empty)))
(define page-2-words (make-wp 'page-2-words (list 'w1 'w2)))
(define with-1-word-subpage (make-wp 'page-1-word-with-subpage (cons page-1-word empty)))
(define with-2-words-subpage (make-wp 'with-2-words-subpage (cons page-2-words empty)))
(define dense-page1 (make-wp 'realistic (list 'w3  page-2-words 'w4 page-1-word 'w5)))
(define dense-page2 (make-wp 'realistic (list 'w3  empty-page 'w4 with-1-word-subpage 'w5)))

;; test cases

;; test for 'find'
(equal? (occurs empty-page 'w1) false)
(equal? (occurs page-1-word 'w1) true)
(equal? (occurs page-2-words 'w3) false)
(equal? (occurs with-2-words-subpage 'w2) true)
(equal? (occurs dense-page1 'no-in-there) false)
(equal? (occurs dense-page1 'w1) true)
(equal? (occurs dense-page1 'w2) true)
(equal? (occurs dense-page2 'w1) true)
(equal? (occurs dense-page1 'w5) true)

;; --- end test code