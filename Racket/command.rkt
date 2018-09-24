#lang racket

(define mv%
  (class object%
    (super-new)
    (init-field src dest)

    (define/public (execute)
      (rename-file-or-directory src dest))

    (define/public (undo)
      (rename-file-or-directory dest src))

    (define/public (redo)
      (rename-file-or-directory src dest))))

(define client%
  (class object%
    (super-new)

    (define command-stack null)
    
    (define/public (record command)
      (set! command-stack
            (append command-stack (list command))))

    (define/public (stack) command-stack)

    (define/public (execute-all)
      (for ([cmd (stack)])
        (send cmd execute)))

    (define/public (undo-all)
      (for ([cmd (reverse (stack))])
        (send cmd undo)))

    (define/public (redo-all)
      (for ([cmd (stack)])
        (send cmd execute)))))

(define (main)
  (define client (new client%))
  (send* client
    [record (make-object mv% "/home/salt/a.txt" "/home/salt/b.txt")]
    [record (make-object mv% "/home/salt/c.txt" "/home/salt/d.txt")]
    [execute-all]
    [undo-all]
    [redo-all]))

(main)
