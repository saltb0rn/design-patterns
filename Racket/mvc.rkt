#lang racket

(define (input prompt)
  (printf "~a\n" prompt)
  (read-line (current-input-port) 'any))

(define quotes
  (list
   "A man is not complete until he is married. Then he is finished."
   "As I said before, I never repeat myself."
   "Behind a successful man is an exhausted woman."
   "Black holes really suck..."
   "Facts are stubborn things."))

(define quote-model%
  (class object%
    (super-new)

    (define/public (get-quote n)
      (with-handlers ([(lambda (v) #t)
                       (lambda (exn) "Not found!")])
        (list-ref quotes n)))))

(define quote-terminal-view%
  (class object%
    (super-new)

    (define/public (show quote)
      (printf "And the quote is: \"~s\"\n" quote))

    (define/public (error msg)
      (printf "Error: \"~s\"\n" msg))

    (define/public (select-quote)
      (input "Which quote number would you like to see? "))))

(define quote-terminal-controller%
  (class object%
    (super-new)
    (field [model (new quote-model%)]
           [view (new quote-terminal-view%)])

    (define/public (run)
      (let loop ([valid-input #f])
        (if (not valid-input)
            (begin
              (let ((n (send view select-quote)))
                (with-handlers ([(lambda (v) #t)
                                 (lambda (exn)
                                   (send view error (format "~s\n" n))
                                   (loop #f))])
                  (send view show (send model get-quote (string->number n))))))
            (loop #f))))))

(define (main)
  (define controller (new quote-terminal-controller%))
  (let loop ()
    (send controller run)
    (loop)))

(main)
