#lang racket

;; ---------- Director ----------
(define director%
  (class object%

    (super-new)

    (init-field [builder (void)])

    (define/public (construct-building)
      (if (not (void? builder))
          (begin
            (send builder new-building)
            (send builder build-floor)
            (send builder build-window)
            (send builder decorate)
            (send builder clean-up))
          (printf "no builder works for you.")))

    (define/public (get-building)
      (get-field building (get-field builder this)))))

;; ---------- 抽象建筑工 ----------
(define builder%
  (class object%

    (super-new)

    (field [building (void)])

    (abstract new-building
              build-floor
              build-window
              decorate
              clean-up)))

(define building%
  (class object%
    (super-new)
    (field [floor (void)]
           [window (void)]
           [style (void)]
           [time (void)])))

;; ---------- 具体的建筑工人 ----------

(define cottage-builder%
  (class builder%

    (super-new)

    (field
     [floor "One"]
     [window "Small"]
     [style "Classical"]
     [time "2 days"])

    (define/override (new-building)
      (when (void? (get-field building this))
        (printf "prepare to build\n")
        (set-field! building this (new building%))))

    (define/override (build-floor)
      (printf "building floor ... for 2 days\n")
      (set-field! floor (get-field building this) floor))

    (define/override (build-window)
      (printf "building window ... for 3 days\n")
      (set-field! window (get-field building this) window))

    (define/override (decorate)
      (printf "decorating for ... 5 days\n")
      (set-field! style (get-field building this) style))

    (define/override (clean-up)
      (printf "it will take us ~s to clean up\n" (get-field time this)))))


;; 现在有一个工程要启动,指挥者接手工程给他团队的工人完成
(define director (new director% [builder (new cottage-builder%)]))
(send director construct-building)
(send director get-building)
