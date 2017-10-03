;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 27.1.4) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; sav-tree : posn number number -> bool
(define (sav-tree c r angle)
  (local ((define a
            (make-posn (+ (posn-x c) (* r (cos angle)))
                       (+ (posn-y c) (* -1 r (sin angle)))))
          (define r1
            (make-posn (+ (posn-x c) (/ (* r (cos angle)) 3))
                       (+ (posn-y c) (/ (* -1 r (sin angle)) 3))))
          (define r2
            (make-posn (+ (posn-x c) (/ (* 2 r (cos angle)) 3))
                       (+ (posn-y c) (/ (* -2 r (sin angle)) 3)))))
    (if (> r 1)
        (and (draw-solid-line c a)
             (sav-tree r1 (/ r 2) (+ angle (/ pi 8)))
             (sav-tree r2 (/ r 2) (- angle (/ pi 8))))
        true)))
           
;; TEST
(start 400 400)
(sav-tree (make-posn 200 400) 300 (/ pi 2))