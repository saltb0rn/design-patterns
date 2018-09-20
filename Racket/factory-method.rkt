#lang racket

(define translator%
  (class object%

    (super-new)

    (abstract load-dictionary)

    (abstract translate-from)))

(define english-translator%
  (class translator%

    (super-new)

    (field
     [dict void]
     [lang "en"])

    (define/override (load-dictionary)
      (when (void? (get-field dict this))
        (set-field! dict this "English Dictionary")))

    (define/override (translate-from text lang)
      (displayln
       (format "Translate ~s from ~a to ~a"
               text lang (get-field lang this))))))


(define chinese-translator%
  (class translator%

    (super-new)

    (field
     [dict void]
     [lang "ch"])

    (define/override (load-dictionary)
      (when (void? (get-field dict this))
        (set-field! dict this "Chinese Dictionary")))

    (define/override (translate-from text lang)
      (displayln
       (format "Translate ~s from ~a to ~a"
               text lang (get-field lang this))))))


(define (translator-factory lang)
  (new
   (case lang
     [("en") english-translator%]
     [("ch") chinese-translator%]
     [else (error 'value-error (format "The language ~s is unavaliable" lang))])))
