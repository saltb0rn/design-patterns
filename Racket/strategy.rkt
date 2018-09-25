#lang racket

(define (input prompt)
  (printf "~a\n" prompt)
  (read-line (current-input-port) 'any))

(define (all-unique-sort s)
  (define sorted-s-list (sort (string->list s) char<=?))
  (let loop ([chars sorted-s-list])
    (cond
     [(null? chars) #t]
     [(= [length chars] 1) #t]
     [(char=? (car chars)
              (cadr chars)) #f]
     [else
      (loop (cdr chars))])))

(define (all-unique-set s)
  (define s-list (string->list s))
  (define len (length s-list))
  (= len (length (set->list (list->set s-list)))))

(define (all-unique s strategy)
  (strategy s))

(define strategies (make-hash `((1 . ,all-unique-sort)
                                (2 . ,all-unique-set))))

(define (main)
  (let loop ([choose (input
                      "Choose your strategy: [1] Sort and pair [2] Use a set")])
    (cond
     [(string->number choose)
      => (lambda (v)
           (printf "~s\n"
                   (all-unique
                    (input "Insert word")
                    (hash-ref strategies v)))
           (loop
            (input "Choose your strategy: [1] Sort and pair [2] Use a set")))]
     [else #f])))

(main)
