;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 18.1.8) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(require htdp/draw)
;; draw-polygon : polygon  ->  true
;; to draw the polygon specified by a-poly 
;(define (draw-polygon a-poly)
;  (connect-dots (cons (last a-poly) a-poly)))

;; connect-dots : polygon  ->  true
;; to draw connections between the dots of a-poly
;(define (connect-dots a-poly)
;  (cond
;    [(empty? (rest a-poly)) true]
;    [else (and (draw-solid-line (first a-poly) (second a-poly) 'red)
;               (connect-dots (rest a-poly)))]))

;; last : polygon  ->  posn
;; to extract the last posn on a-poly
;(define (last a-poly)
;  (cond
;    [(empty? (rest a-poly)) (first a-poly)]
;    [else (last (rest a-poly))]))

(define (draw-polygon a-poly)
  (local (
          (define (draw-polygon1 a-poly)
            (connect-dots (cons (last a-poly) a-poly)))
          (define (connect-dots a-poly)
            (cond
              [(empty? (rest a-poly)) true]
              [else (and (draw-solid-line (first a-poly)
                                          (second a-poly)
                                          'red)
                         (connect-dots (rest a-poly)))]))
          (define (last a-poly)
            (cond
              [(empty? (rest a-poly)) (first a-poly)]
              [else (last (rest a-poly))])))
    (draw-polygon1 a-poly)))

(start 200 200)
(draw-polygon (cons (make-posn 10 10)
                    (cons (make-posn 60 60)
                          (cons (make-posn 10 60)
                                empty))))