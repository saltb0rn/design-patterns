#lang racket

(define publisher%
  (class object%
    (super-new)
    (field [subscribers (list)])

    (define/public (add subscriber)
      (if (memq subscriber subscribers)
          (printf "Failed to add: ~a\n" subscriber)
          (set! subscribers
                (append subscribers (list subscriber)))))

    (define/public (remove subscriber)
      (set! subscribers (remq subscriber subscriber)))

    (define/public (notify)
      (for ([o (in-list subscribers)])
        (send o update this)))))

(define concrete-publisher%
  (class publisher%
    (super-new)
    (init-field [name ""])
    (define data 0)
    (inherit notify)

    (define/public (get-data) data)

    (define/public (set-data v)
      (set! data v)
      (notify))))

(define normal-subscriber%
  (class object%
    (super-new)
    
    (define/public (update publisher)
      (printf "NormalSubscirber: Publisher: \"~a\" update data: \"~a\".\n"
              (get-field name publisher)
              (send publisher get-data)))))

(define vip-subscriber%
  (class object%
    (super-new)
    
    (define/public (update publisher)
      (printf "VIPSubscirber: Publisher: \"~a\" update data: \"~a\".\n"
              (get-field name publisher)
              (send publisher get-data)))))


(define (main)
  (define normal-channel (make-object concrete-publisher% "Normal Channel"))
  (define vip-channel (make-object concrete-publisher% "VIP Channel"))
  (define normal-subscriber (make-object normal-subscriber%))
  (define vip-subscriber (make-object vip-subscriber%))
  (send* normal-channel
    [add normal-subscriber]
    [add vip-subscriber])
  (send vip-channel add vip-subscriber)
  (send normal-channel set-data "This is the new update for everyone")
  (send vip-channel set-data "This is the new update for vip user"))

(main)

         
