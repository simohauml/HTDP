;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 41.2.7) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(define-struct CD (price title artist))
(define-struct record (price antique title artist))
(define-struct DVD (price title artist to-appear))
(define-struct tape (price title artist))
(define-struct music (cd record dvd tape))

(define (inflate! m p)
  (local ((define a-cd (music-cd m))
          (define a-record (music-record m))
          (define a-dvd (music-dvd m))
          (define a-tape (music-tape m))
          (define rate (+ 1 p)))
    (begin
      (set-CD-price! a-cd (* (CD-price a-cd) rate))
      (set-record-price! a-record (* (record-price a-record) rate))
      (set-DVD-price! a-dvd (* (DVD-price a-dvd) rate))
      (set-tape-price! a-tape (* (tape-price a-tape) rate)))))

(define m1 (make-music (make-CD 10 'Hello 'Eagle)
                       (make-record 20 'Old 'Tomorrow 'Duke)
                       (make-DVD 15 'Go 'Share 'Top)
                       (make-tape 4 'Yesterday 'M&A)))
(inflate! m1 0.2)