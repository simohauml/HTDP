;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 16.3.3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(require htdp/dir)

(define dir-htdp (create-dir "/Users/zhangyue/Documents/GitHub/HTDP"))
(define dir-htdp-chapter16 (create-dir "/Users/zhangyue/Documents/GitHub/HTDP/chapter16"))

(define (du-dir d)
  (+ (du-dirs (dir-dirs d))
     (du-files (dir-files d))))

(define (du-files df)
  (cond
    [(empty? df) 0]
    [else
     (+ (file-size (first df))
        (du-files (rest df)))]))

(define (du-dirs dd)
  (cond
    [(empty? dd) 0]
    [else
     (+ (du-dir (first dd))
        (du-dirs (rest dd)))]))