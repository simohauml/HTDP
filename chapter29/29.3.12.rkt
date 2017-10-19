;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 29.3.12) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor mixed-fraction #t #t none #t ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; vector+ : (vectorof N) (vectorof N) -> (
;; computes pointwise sum of two vectors
;; ASSUMPTION: vectors are of equal length
(define (vector+ V1 V2)
  (local ((define (add-components i)
            (+ (vector-ref V1 i) (vector-ref V2 i))))
    (build-vector (vector-length V1) add-components)))

;; vector- : (vectorof N) (vectorof N) -> (
;; computes pointwise difference of two vectors
;; ASSUMPTION: vectors are of equal length
(define (vector- V1 V2)
  (local ((define (sub-components i)
            (- (vector-ref V1 i) (vector-ref V2 i))))
    (build-vector (vector-length V1) sub-components)))

;; checked-vector+ : (vectorof N) (vectorof N) -> (
;; computes pointwise sum of two vectors
;; ASSUMPTION: vectors are of equal length
(define (checked-vector+ V1 V2)
  (local ((define length-V1 (vector-length V1))
          (define length-V2 (vector-length V2)))
  (if (= length-V1 length-V2)
      (local ((define (add-components i)
                (+ (vector-ref V1 i) (vector-ref V2 i))))
        (build-vector length-V1 add-components))
      (error "vectors are of unequal length"))))

;; checked-vector- : (vectorof N) (vectorof N) -> (
;; computes pointwise difference of two vectors
;; ASSUMPTION: vectors are of equal length
(define (checked-vector- V1 V2)
  (local ((define length-V1 (vector-length V1))
          (define length-V2 (vector-length V2)))
  (if (= length-V1 length-V2)
      (local ((define (sub-components i)
                (- (vector-ref V1 i) (vector-ref V2 i))))
        (build-vector length-V1 sub-components))
      (error "vectors are of unequal length"))))

(equal?
 (vector+ (vector 1 3 6)
          (vector 2 4 5))
 (vector 3 7 11))
(equal?
 (vector- (vector 1 3 6)
          (vector 2 4 5))
 (vector -1 -1 1))
(equal?
 (checked-vector+ (vector 1 3 6)
          (vector 2 4 5))
 (vector 3 7 11))
(equal?
 (checked-vector- (vector 1 3 6)
          (vector 2 4 5))
 (vector -1 -1 1))
;; these should throw errors:
(checked-vector+ (vector 1 3 6)
                 (vector 4 5))
(checked-vector- (vector 1 3 6)
                 (vector 4 5))