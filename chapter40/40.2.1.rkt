;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 40.2.1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;;(define-struct boyfriend (name hair eyes phone))

(define (fm-make-boyfriend n h e p)
  (local ((define name n)
	  (define hair h)
          (define eyes e)
          (define phone p)
	  (define (service-manager msg)
	    (cond
	      [(symbol=? msg 'name) name]
	      [(symbol=? msg 'hair) hair]
              [(symbol=? msg 'eyes) eyes]
              [(symbol=? msg 'phone) phone]
	      [(symbol=? msg 'set-name) (lambda (name-new) (set! name name-new))]
	      [(symbol=? msg 'set-hair) (lambda (hair-new) (set! hair hair-new))]
              [(symbol=? msg 'set-eyes) (lambda (eyes-new) (set! eyes eyes-new))]
              [(symbol=? msg 'set-phone) (lambda (phone-new) (set! phone phone-new))]
	      [else (error 'boyfriend "Unkonwn service")])))
    service-manager))

(define (fm-boyfriend-name p)
  (p 'name))

(define (fm-boyfriend-hair p)
  (p 'hair))

(define (fm-boyfriend-eyes p)
  (p 'eyes))

(define (fm-boyfriend-phone p)
  (p 'phone))

(define (fm-set-boyfriend-name! p new-value)
  ((p 'set-name) new-value))

(define (fm-set-boyfriend-hair! p new-value)
  ((p 'set-hair) new-value))

(define (fm-set-boyfriend-eyes! p new-value)
  ((p 'set-eyes) new-value))

(define (fm-set-boyfriend-phone! p new-value)
  ((p 'set-phone) new-value))