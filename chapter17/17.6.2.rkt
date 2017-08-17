;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 17.6.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(require htdp/hangman)
(require htdp/draw)

;(define (reveal-list chosen status guess)
;  (cond
;    [(empty? chosen) empty]
;    [(eq? (car chosen) guess) (cons guess (rest status))]
;    [else
;     (cons (car status)
;           (reveal-list (rest chosen) (rest status) guess))]))

(define (reveal-list chosen status guess) 
  (cond
    [(empty? chosen) 
     empty]
    [else 
     (cond
       [(equal? (first chosen) guess)
        (cons guess 
              (reveal-list (rest chosen) 
                           (rest status) 
                           guess))]
       [else
        (cons (first status) 
              (reveal-list (rest chosen) 
                           (rest status) 
                           guess))])]))

(define (draw-next-part body-part)
  (cond 
    [(eq? body-part 'body)
     (draw-solid-line (make-posn 100 60)
                      (make-posn 100 130)
                      'black)]
    [(eq? body-part 'right-leg)
     (draw-solid-line (make-posn 100 130)
                      (make-posn 30 170)
                      'black)]
    [(eq? body-part 'left-leg)
     (draw-solid-line (make-posn 100 130)
                      (make-posn 170 170)
                      'black)]
    [(eq? body-part 'right-arm)
     (draw-solid-line (make-posn 100 75)
                      (make-posn 40 65)
                      'black)]
    [(eq? body-part 'left-arm)
     (draw-solid-line (make-posn 100 75)
                      (make-posn 160 65)
                      'black)]
    [(eq? body-part 'head)
     (and       
      (draw-solid-disk (make-posn 120 50) 30 'red)
      (draw-solid-line (make-posn 115 35)
                       (make-posn 123 43)
                       'black)
      (draw-solid-line (make-posn 123 35)
                       (make-posn 115 43)
                       'black)
      (draw-solid-line (make-posn 131 40)
                       (make-posn 139 48)
                       'black)
      (draw-solid-line (make-posn 139 40)
                       (make-posn 131 48)
                       'black))]
    [(eq? body-part 'noose)
     (and
      (draw-solid-line (make-posn 100 30)
                       (make-posn 100 10)
                       'black)
      (draw-solid-line (make-posn 100 10)
                       (make-posn 0 10)
                       'black))]))

(start 200 200)
(hangman-list reveal-list draw-next-part)