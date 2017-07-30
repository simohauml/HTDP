;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 14.3.4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; size : WP  ->  number
;; to count the number of symbols that occur in a-wp
(define (size a-wp) 
  (cond
    [(empty? a-wp) 0]
    [(symbol? (first a-wp)) (+ 1 (size (rest a-wp)))]
    [else (+ (size (first a-wp)) (size (rest a-wp)))]))

(define (depth a-wp) 
  (cond
    [(empty? a-wp) 0]
    [(symbol? (first a-wp)) (depth (rest a-wp))]
    [else
     (max
      (+ 1 (depth (first a-wp)))
      (depth (rest a-wp)))]))