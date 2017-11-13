;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 33.1.1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct inex (mantissa sign exponent))

(define MAX-POSITIVE (make-inex 99 +1 99))
(define MIN-POSITIVE (make-inex 1 -1 99))

;; create-inex : N N N  ->  inex
;; to make an instance of inex after checking the appropriateness
;; of the arguments
(define (create-inex m s e)
  (cond
    [(and (<= 0 m 99) (<= 0 e 99) (or (= s +1) (= s -1)))
     (make-inex m s e)]
    [else
     (error 'make-inex "(<= 0 m 99), +1 or -1, (<= 0 e 99) expected")]))

;; inex->number : inex  ->  number
;; to convert an inex into its numeric equivalent 
(define (inex->number an-inex)
  (* (inex-mantissa an-inex) 
     (expt 10 (* (inex-sign an-inex) (inex-exponent an-inex)))))

; both adders are same sign
(define (same-exp inex1 inex2)
  (local ((define m (+ (inex-mantissa inex1) (inex-mantissa inex2)))
          (define s (inex-sign inex1))
          (define e (cond
                      [(= s 1) (inex-exponent inex1)]
                      [else (- (inex-exponent inex1))])))
    (cond
      [(<= m 99) (create-inex m s e)]
      [(= m 100)
       (cond
         [(> (+ e 2) 99) (error 'inex+ "out of range: max")]
         [else (create-inex 1 (if (>= (+ e 2) 0) 1 -1) (abs (+ e 2)))])]
      [(= (remainder m 10) 0)
       (cond
         [(> (+ e 1) 99) (error 'inex+ "out of range: max")]
         [else (create-inex (/ m 10) (if (>= (+ e 1) 0) 1 -1) (abs (+ e 1)))])]
      [else (cond
              [(> (+ e 1) 99) (error 'inex+ "out of range: max")]
              [(< (remainder m 10) 5) (create-inex (floor (/ m 10))
                                                   (if (>= (+ e 1) 0) 1 -1)
                                                   (abs (+ e 1)))]
              [else (create-inex (ceiling (/ m 10))
                                 (if (>= (+ e 1) 0) 1 -1)
                                 (abs (+ e 1)))])])))

; exponents differ by 1, inex1 is larger than inex2
(define (one-dif-exp inex1 inex2)
  (local ((define m (+ (* 10 (inex-mantissa inex1)) (inex-mantissa inex2)))
          (define s1 (inex-sign inex1))
          (define s2 (inex-sign inex2))
          (define e1 (if (= s1 1)
                         (inex-exponent inex1)
                         (- (inex-exponent inex1))))
          (define e2 (if (= s2 1)
                         (inex-exponent inex2)
                         (- (inex-exponent inex2)))))
    (cond
      [(<= m 99) (create-inex m (if (>= e2 0) 1 -1) (abs e2))]
      [(= m 100)
       (cond
         [(> (+ e2 2) 99) (error 'inex+ "out of range: max")]
         [else (create-inex 1 (if (>= (+ e 2) 0) 1 -1) (abs (+ e2 2)))])]
      [(= (remainder m 10) 0)
       (cond
         [(> (+ e2 1) 99) (error 'inex+ "out of range: max")]
         [else (create-inex (/ m 10) (if (>= (+ e2 1) 0) 1 -1) (abs (+ e 1)))])]
      [else (cond
              [(> (+ e 1) 99) (error 'inex+ "out of range: max")]
              [(< (remainder m 10) 5) (create-inex (floor (/ m 10))
                                                   (if (>= (+ e 1) 0) 1 -1)
                                                   (abs (+ e 1)))]
              [else (create-inex (ceiling (/ m 10))
                                 (if (>= (+ e 1) 0) 1 -1)
                                 (abs (+ e 1)))])])))

(define (inex+ inex1 inex2)
  (local ((define s1 (inex-sign inex1))
          (define s2 (inex-sign inex2))
          (define e1 (inex-exponent inex1))
          (define e2 (inex-exponent inex2)))
    (cond
      [(and (= s1 s2) (= e1 e2)) (same-exp inex1 inex2)]
      [(and (= s1 s2) (= (- e1 e2) 1)) (one-dif-exp inex1 inex2)]
      [(and (= s1 s2) (= (- e2 e1) 1)) (one-dif-exp inex2 inex1)]
      [(and (= s1 e2 1) (= s2 -1) (= e1 0)) (one-dif-exp inex1 inex2)]
      [(and (= s2 e1 1) (= s1 -1) (= e2 0)) (one-dif-exp inex2 inex1)]
      [else (error 'inex+ "not supported number")])))
      
    
; tests
(inex+ (create-inex 1 +1 0) (create-inex 2 +1 0))
(inex+ (create-inex 99 -1 1) (create-inex 1 -1 1))
(equal? (inex+ (create-inex 1 +1 0) (create-inex 1 -1 1))
        (create-inex 11 -1 1))

