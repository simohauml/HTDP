;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 16.3.4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(require htdp/dir)

(define dir-htdp (create-dir "/Users/zhangyue/Documents/GitHub/HTDP"))
(define dir-htdp-chapter16 (create-dir "/Users/zhangyue/Documents/GitHub/HTDP/chapter16"))

(define (find? a-dir a-name)
  (or (find?-in-dirs (dir-dirs a-dir) a-name)
      (find?-in-files (dir-files a-dir) a-name)))

(define (find?-in-files lof a-name)
  (cond
    [(empty? lof) false]
    [(equal? (file-name (first lof)) a-name) true]
    [else (find?-in-files (rest lof) a-name)]))

(define (find?-in-dirs lod a-name)
  (cond
    [(empty? lod) false]
    [else
     (or
      (find? (first lod) a-name)
      (find?-in-dirs (rest lod) a-name))]))

(define (find a-dir a-name)
  (cond
    [(find?-in-files (dir-files a-dir) a-name) (list (dir-name a-dir))]
    [(find?-in-dirs (dir-dirs a-dir) a-name) (append (list (dir-name a-dir))
                                                     (find-path (dir-dirs a-dir) a-name))]
    [else false]))

(define (find-path lod a-name)
  (cond
    [(empty? lod) '()]
    [else (local ((define in-subdir (find (first lod) a-name)))
            (cond
              [(boolean? in-subdir) (find-path (rest lod) a-name)]
              [else in-subdir]))]))