#lang racket

(define-values (shotgun pistol rpg knife) (values 1 2 3 4))

(define scene%
  (class object%
    (super-new)

    (field [enemies (make-hash)]
           [enemy-counter 0])

    (define/public (load-resource)
      (printf "Loading resources ...\n"))

    (define/public (add-enemy type)
      (define enemy (make-object enemy% (init-enemy-template type)))
      (hash-set! enemies enemy-counter enemy)
      (set! enemy-counter (+ 1 enemy-counter))
      (- enemy-counter 1))

    (define/public (get-enemy enemy-counter)
      (hash-ref enemies enemy-counter (void)))

    (define/public (remove-enemy enemy-counter)
      ;; (send this get-enemy)
      (let ((enemy (get-enemy enemy-counter)))
        (unless (void? enemy)
          (hash-remove! enemies enemy-counter))))))

(define enemy-template%
  (class object%
    (super-new)

    (init-field type)))

(define init-enemy-template
  (let ((cache (make-hash)))
    (lambda (type)
      (unless (hash-ref cache type #f)
        (hash-set! cache type (make-object enemy-template% type)))
      (hash-ref cache type))))

(define enemy%
  (class object%
    (super-new)
    (init-field enemy_tpl)
    (field [hp 100]
           [armor 0])

    (define/public (get-damage damage)
      (define remained-armor (- armor damage))
      (if (>= remained-armor 0)
          (set! armor remained-armor)
          (set! hp remained-armor))
      hp)

    (define/public (buy-armor)
      (set! armor 100))))


(define (start-game)
  (define scene (new scene%))
  (define eid1 (send scene add-enemy shotgun))
  (send (send scene get-enemy eid1) get-damage 4)
  ;;(send scene remove-enemy eid1)
  (send scene get-enemy eid1))

(start-game)

;; (define scene (new scene%))
;; (send scene add-enemy 1)
;; (get-field enemies scene)
;; (send scene get-enemy 0)
