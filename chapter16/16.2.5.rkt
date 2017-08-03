;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 16.2.5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
#|
16.2.3
A directory (short: dir) is a structure:
      (make-dir n c s sys) 
where n is a symbol
      c is a list of files and directories
      s is a number and
      sys is a boolean.
|#
(define-struct dir (name content size systems))

(define (how-many dir)
  (how-many-c dir))

(define (how-many-c lofd)
  (cond
    [(empty? lofd) 0]
    [(symbol? (first lofd)) (+ 1 (how-many-c (rest lofd)))]
    [(dir? (first lofd)) (+ (how-many (first lofd))
                            (how-many-c (rest lofd)))]))