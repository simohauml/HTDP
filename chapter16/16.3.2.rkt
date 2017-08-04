;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 16.3.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(require htdp/dir)

(define dir-htdp (create-dir "/Users/zhangyue/Documents/GitHub/HTDP"))
(define dir-htdp-chapter16 (create-dir "/Users/zhangyue/Documents/GitHub/HTDP/chapter16"))

(define (how-many d)
  (+ (how-many-dirs (dir-dirs d))
     (how-many-files (dir-files d))))

(define (how-many-files df)
  (cond
    [(empty? df) 0]
    [else
     (+ 1 (how-many-files (rest df)))]))

(define (how-many-dirs dd)
  (cond
    [(empty? dd) 0]
    [else
     (+ (how-many (first dd))
        (how-many-dirs (rest dd)))]))