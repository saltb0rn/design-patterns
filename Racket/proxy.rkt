#lang racket

(define (input prompt)
  (printf "~a\n" prompt)
  (read-line (current-input-port) 'any))

(define sensitiveinfo%
  (class object%
    (super-new)

    (define users (list 'nick 'tom 'ben 'mike))

    (define/public (read)
      (printf "There are ~a uses:  ~a\n"
              (length users)
              users))

    (define/public (add user)
      (set! users (append users (list user))))))

(define protective-proxy%
  (class object%
    (super-new)

    (define-values (protected secret)
      (values (new sensitiveinfo%)
              "...././.-../.-../---/--..-- .--/---/.-./.-../-.."))

    (define/public (read)
      (send protected read))

    (define/public (add user)
      (define sec (input "what is the secret? your answer: "))
      (if (string=? sec secret)
          (send protected add user)
          (printf "This is so wrong!\n")))))

(define (main)
  (printf "1. read list |==| 2. add user |==| 3. quit\n")
  (define info (new protective-proxy%))
  (let loop ([key (input "choose option: ")])
    (cond
     [(string=? key "1") (send info read) (loop (input "choose option: "))]
     [(string=? key "2") (send info add (input "choose username: ")) (loop (input "choose option: "))]
     [(string=? key "3") (exit)]
     [else (printf "unknown option: \n" key)])))

(main)
