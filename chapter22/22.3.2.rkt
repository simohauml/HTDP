;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 22.3.2) (read-case-sensitive #t) (teachpacks ((lib "gui.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "gui.rkt" "teachpack" "htdp")) #f)))
;;;;;;;;;;;
;; MODEL ;;
;;;;;;;;;;;

(define-struct entry (name number))
;; An entry is a structure:
;; (make-entry n m)
;; where n is a string and m is a number

;; an example phonebook:
(define my-phonebook
  (list (make-entry "Sam Courtier" 1112223333)
        (make-entry "Anne Larson" 2223334444)
        (make-entry "Connie Rader" 3334445555)
        (make-entry "Ben Larson" 4445556666)
        (make-entry "Kevin McGary" 5556667777)))

;; lookup : (entry -> X) (entry -> Y) -> ((listof entry) X -> Y)
(define (lookup f g)
  (local ((define (lookup aloe x)
            (cond
              [(empty? aloe) false]
              [(equal? (f (first aloe)) x)
               (g (first aloe))]
              [else (lookup (rest aloe) x)])))
    lookup))

;; lookup-number : (listof entry) string -> number
(define lookup-number
  (lookup entry-name entry-number))

;; lookup-name : (listof entry) number -> string
(define lookup-name
  (lookup entry-number entry-name))

;;;;;;;;;;
;; VIEW ;;
;;;;;;;;;;

(define input
  (make-text "Enter name or number:\nFirst Last"))

(define a-msg
  (make-message "Welcome to Phonebook Search!"))

;;;;;;;;;;;;;;;;
;; CONTROLLER ;;
;;;;;;;;;;;;;;;;

(define (fetch-call-back b)
  (local ((define user-number-input (string->number (text-contents input)))
          (define user-string-input (text-contents input))
          (define not-found-msg "No entry found!"))
    (cond    
      [(number? user-number-input)
       (cond
         [(false? (lookup-name my-phonebook
                               user-number-input))
          (draw-message a-msg not-found-msg)]
         [else (draw-message a-msg
                             (lookup-name my-phonebook
                                          user-number-input))])]
      [else (cond
              [(false? (lookup-number my-phonebook
                                      user-string-input))
               (draw-message a-msg not-found-msg)]
              [else (draw-message a-msg
                                  (number->string (lookup-number my-phonebook
                                                                 user-string-input)))])])))


(create-window (list (list input a-msg (make-button "Search" fetch-call-back))))
  
;;;;;;;;;;;
;; TESTS ;;
;;;;;;;;;;;

(equal? (lookup-number my-phonebook "Connie Rader") 3334445555)
(equal? (lookup-number my-phonebook "Ben Larson") 4445556666)
(equal? (lookup-number my-phonebook "Edward Norton") false)

(equal? (lookup-name my-phonebook 1112223333) "Sam Courtier")
(equal? (lookup-name my-phonebook 5556667777) "Kevin McGary")
(equal? (lookup-name my-phonebook 1111111111) false)