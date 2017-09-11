;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 22.3.3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(require htdp/gui)
;; A cell is either
;; 1. a number,
;; 2. a symbol.

;; A gui-table is a (listof (listof cell)).

(define pad
  '((1 2 3)
    (4 5 6)
    (7 8 9)
    (\# 0 *)))

(define pad2
  '((1 2 3  +)
    (4 5 6  -)
    (7 8 9  *)
    (0 = \. /)))

;; pad->gui : string gui-table -> (listof gui-items)
(define (pad->gui title agt)
  (local ((define prompt-msg (make-message "Make a selection:"))
          (define (loX->lob aloX) (map X->button aloX))
          (define (X->button x)
            (local ((define (update-prompt-with-n b)
                      (draw-message prompt-msg (number->string x)))
                    (define (update-prompt-with-s b)
                      (draw-message prompt-msg (symbol->string x))))
              (cond
                [(symbol? x) (make-button (symbol->string x)
                                          update-prompt-with-s)]
                [(number? x) (make-button (number->string x)
                                          update-prompt-with-n)]))))
    (cons (list (make-message title))
          (cons (list prompt-msg)
                (map loX->lob agt)))))

(create-window (pad->gui "Virtual Phone" pad))
(create-window (pad->gui "Calculator" pad2))