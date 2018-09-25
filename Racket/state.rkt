#lang racket

(define state%
  (class object%
    (super-new)
    (init-field radio)
    (field [stations null]
           [name ""])
    (define pos 0)

    (define/public (scan)
      (set! pos (+ 1 pos))
      (when (= pos (length stations))
        (set! pos 0))
      (printf "Scanning ... Station is ~a ~a\n"
              (list-ref stations pos)
              name))))

(define am-state%
  (class state%
    (super-new)
    (inherit-field radio
                   stations
                   name)
    (inherit scan)
    (set! stations (list "1250" "1380" "1510"))
    (set! name "AM")

    (define/public (toggle-amfm)
      (printf "Switching to FM\n")
      (set-field! state radio (get-field fmstate radio)))))

(define fm-state%
  (class state%
    (super-new)
    (inherit-field radio
                   stations
                   name)
    (inherit scan)
    (set! stations (list "81.3" "89.1" "103.9"))
    (set! name "FM")

    (define/public (toggle-amfm)
      (printf "Switching to AM\n")
      (set-field! state radio (get-field amstate radio)))))

(define radio%
  (class object%
    (super-new)
    (field [amstate (make-object am-state% this)]
           [fmstate (make-object fm-state% this)]
           [state amstate])

    (define/public (toggle-amfm)
      (send state toggle-amfm))

    (define/public (scan)
      (send state scan))))

(define (main)
  (let ([r (new radio%)])
    (with-method ([scan (r scan)]
                  [toggle-amfm (r toggle-amfm)])
                 (let ([scan-wrapper (lambda () (scan))]
                       [toggle-amfm-wrapper (lambda () (toggle-amfm))])
                   (define actions
                     (list scan-wrapper scan-wrapper toggle-amfm-wrapper
                           scan-wrapper scan-wrapper))
                   (set! actions (append actions actions))
                   (for ([action actions])
                     (action))))))

(main)
