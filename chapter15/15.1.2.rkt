;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 15.1.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(define-struct parent (children name date eyes))

;; EXAMPLES OF DATA
(define robby (make-parent empty "Robby" 1972 'blue))
(define ted (make-parent empty "Ted" 1975 'brown))
(define pat (make-parent empty "Pat" 1978 'brown))
(define pete (make-parent empty "Pete" 1982 'brown))
(define alice (make-parent (list robby ted pat pete) "Alice" 1949 'blue))
(define bill (make-parent (list robby ted pat pete) "Bill" 1949 'brown))
(define lolly (make-parent empty "Lolly" 1951 'blue))
(define tutu (make-parent (list alice lolly) "Tutu" 1911 'brown))

;; blue-eyed-descendant? : parent  ->  boolean
;; to determine whether a-parent any of the descendants (children, 
;; grandchildren, and so on) have 'blue in the eyes field
(define (blue-eyed-descendant? a-parent)
  (cond
    [(symbol=? (parent-eyes a-parent) 'blue) true]
    [else (blue-eyed-children? (parent-children a-parent))]))

;; blue-eyed-children? : list-of-children  ->  boolean
;; to determine whether any of the structures in aloc is blue-eyed
;; or has any blue-eyed descendant
(define (blue-eyed-children? aloc)
  (cond
    [(empty? aloc) false]
    [else
      (cond
        [(blue-eyed-descendant? (first aloc)) true]
        [else (blue-eyed-children? (rest aloc))])]))

(define (how-far-removed a-parent)
  (cond
    [(eq? (parent-eyes a-parent) 'blue) 0]
    [(empty? (parent-children a-parent)) 0]
    [else (+ 1 (how-far-removed-children (parent-children a-parent)))]))

(define (how-far-removed-children lop)
  (cond
    [(empty? lop) 0]
    [else
     (min (how-far-removed (first lop))
          (how-far-removed-children (rest lop)))]))