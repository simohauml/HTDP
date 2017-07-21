;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 6.5.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; DATA DEFINITION
;; a time is a structure:
;;   (make-time H M S)
;; where H, M, and S are numbers
(define-struct stime (hours minutes seconds))

(define (time->seconds a-stime)
  (+ (* 3600 (stime-hours a-stime))
     (* 60 (stime-minutes a-stime))
     (stime-seconds a-stime)))