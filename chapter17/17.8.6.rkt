;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 17.8.6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; Language: Beginning Student with List Abbreviations

#| 17.8.6 testing web=?
------------------------------------------------------------
                            (empty? a-wp) (symbol? (first a-wp)) (cons? (first a-wp))
------------------------------------------------------------------------------------
(empty? another-wp)          |     1     |          2           |        3          |
(symbol? (first another-wp)) |     4     |          5           |        6          | 
(cons? (first another-wp))   |     7     |          8           |        9          |
------------------------------------------------------------------------------------
The numbers in the boxes are referenced in the examples below.
 
;Data Definition:
A Web-page (short: WP) is either
   1. empty;
   2. (cons s wp)
      where s is a symbol and wp is a Web page; or
   3. (cons ewp wp)
      where both ewp and wp are Web pages.

;template:
(define (web=? a-wp another-wp)
  (cond
    [(empty? a-wp) ...]
    [(symbol? (first a-wp))
     ... (first a-wp) ... (first another-wp) ...
     ... (web=? (rest a-wp) (rest another-wp)) ...]
    [else 
     ... (web=? (first a-wp) (first another-wp)) ...
     ... (web=? (rest a-wp) (rest another-wp)) ...]))
|#
;; web=? : web-page web-page  ->  boolean
;; to determine whether a-wp and another-wp have the same tree shape
;; and contain the same symbols in the same order
(define (web=? a-wp another-wp)
  (cond
    [(empty? a-wp) (empty? another-wp)]
    [(symbol? (first a-wp))
     (and (and (cons? another-wp) (symbol? (first another-wp)))
          (and (symbol=? (first a-wp) (first another-wp))
               (web=? (rest a-wp) (rest another-wp))))]
    [else 
     (and (and (cons? another-wp) (cons? (first another-wp)))
          (and (web=? (first a-wp) (first another-wp))
               (web=? (rest a-wp) (rest another-wp))))]))

;Examples as Tests:
;Combination numbers are listed in the table above.
;combination 1
(check-expect
 (web=? empty empty)
 true)

;combination 2
(check-expect
 (web=? (list 'Hello 'World) empty)
 false)

;combination 3
(check-expect
 (web=? (list (list 'Goodbye)) empty)
 false)

;combination 4
(check-expect
 (web=? empty (list 'Homework))
 false)

;combination 5
(check-expect
 (web=? (list 'Hello 'World) (list 'Homework))
 false)

;combination 5
(check-expect
 (web=? (list 'Homework) (list 'Homework))
 true)

;combination 6
(check-expect
 (web=? (list (list 'Goodbye)) (list 'Homework))
 false)

;combination 7
(check-expect
 (web=? empty (list (list 'Solutions)))
 false)

;combination 8
(check-expect
 (web=? (list 'Hello 'World) (list (list 'Solutions)))
 false)

;combination 9
(check-expect
 (web=? (list (list 'Solutions)) (list (list 'Solutions)))
 true)

;combination 9
(check-expect
 (web=? (list (list 'Goodbye)) (list (list 'Solutions)))
 false)