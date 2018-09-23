#lang racket

(define cpu%
  (class object%
    (super-new)
    (define/public (jump)
      (printf "Jumping to BOOT address\n"))
    (define/public (execute)
      (printf "Startup completed, start to work!\n"))))

(define memory%
  (class object%
    (super-new)
    (define/public (load)
      (printf "Loaded from BOOT address\n"))))

(define harddrive%
  (class object%
    (super-new)
    (define/public (read)
      (printf "Read from BOOT sector\n"))))

;; computer% 就是 facade
(define computer%
  (class object%
    (super-new)
    (field [cpu (new cpu%)]
           [mem (new memory%)]
           [hhd (new harddrive%)])
    (define/public (start)
      (send mem load)
      (send hhd read)
      (send cpu jump)
      (send cpu execute))))

(define (client)
  (define pc (new computer%))
  (send pc start))

(client)
