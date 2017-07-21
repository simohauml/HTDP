;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 12.3.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(require htdp/draw)

;; draw-polygon : polygon -> true
;; to draw the polygon specified by a-poly  
(define (draw-polygon a-poly) 
  (connect-dots a-poly (first a-poly)))

;; connect-dots : polygon -> true 
;; to draw connections between the dots of a-poly 
(define (connect-dots a-poly first-a) 
  (cond 
    [(empty? (rest a-poly)) (draw-solid-line (first a-poly)
                                             first-a
                                             'red)]
    [else (and (draw-solid-line (first a-poly)
                                (second a-poly)
                                'red) 
               (connect-dots (rest a-poly) first-a))]))

;; EXAMPLES AS TESTS
(start 200 200)

(define example-polygon
  (cons
   (make-posn 10 10)
   (cons
    (make-posn 90 100)
    (cons
     (make-posn 10 190)
     (cons
      (make-posn 190 190)
      (cons
       (make-posn 110 100)
       (cons
        (make-posn 190 10)
        empty)))))))

(draw-polygon example-polygon)