#lang racket

;; ---------- 适配器 ----------
(define-syntax (make-adapter stx)
  (syntax-case stx ()
    [(_ adapter obj method)
     #'(new
        (class object%
          (super-new)
          (define/public adapter
            (lambda () (send obj method)))))]))

;; 需要被适配的类
(define human%
  (class object%
    (super-new)
    (init-field msg)
    (define/public (greeting) (printf "~a\n" msg))))

(define computer%
  (class object%
    (super-new)
    (define/public (welcome)
      (printf "Welcome to Debian!\n"))))

(define google%
  (class object%
    (super-new)
    (define/public (page-info)
      (printf "Discover the store!\n"))))

(define human-1 (new human% [msg "你好!"]))
(define human-2 (new human% [msg "Hello!"]))
(define computer (new computer%))
(define google (new google%))

;; ---------- 原本的系统 ----------
;; 原本的系统是为了 human% 的实例工作的
(define (greeting objs)
  (for ([obj (in-list objs)])
    (send obj greeting)))

;; ---------- 适配 computer% 和 google% 的实例
(define computer-adapter (make-adapter greeting computer welcome))
(define google-adapter (make-adapter greeting google page-info))

(define objs (list human-1 human-2 computer-adapter google-adapter))

(greeting objs) ; 正常工作
