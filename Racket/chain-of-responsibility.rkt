#lang racket

(require (for-syntax racket/match))
(define-syntax (make-point-class stx)
  (match (syntax->list stx)
    [(list name clsname start end handler-num next)
     (datum->syntax stx
                    `(define ,clsname
                       (class object%
                         (super-new)
                         (field [successor (void)])
                         (define/public (chain point)
                           (set! successor point))
                         (define/public (handle request)
                           (if (and (> request ,start) (<= request ,end))
                               (printf "request ~a in handler~a\n" request ,handler-num)
                               ,next)))))]))

(make-point-class point-1% 0 10 1 (send successor handle request))
(make-point-class point-2% 10 20 2 (send successor handle request))
(make-point-class point-3% 20 30 3 (void))


(define check-point-chain%
  (class object%
    (super-new)

    (field [p1 (new point-1%)]
           [p2 (new point-2%)]
           [p3 (new point-3%)])

    (define/public (chain-point)
      (send p1 chain p2)
      (send p2 chain p3))

    (define/public (check-request request)
      (send p1 handle request))

    (define/public (check-requests requests)
      (for ([request (in-list requests)])
        (check-request request)))))



(define (main)
  (define ckchain (new check-point-chain%))
  (send ckchain chain-point)
  (send ckchain
        check-requests
        (for/list ([i (in-naturals)]
                   #:break (= i 30)
                   #:when (= 0 (modulo i 2)))
          i)))

(main)
