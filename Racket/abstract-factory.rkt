#lang racket

;; 抽象

(define cpu%
  (class object%

    (super-new)

    (init-field spec)

    (abstract get-cpu-info)))


(define gpu%
  (class object%

    (super-new)

    (init-field spec)

    (abstract get-gpu-info)))


(define console-factory%
  (class object%

    (super-new)

    (field [cpu #f] [gpu #f])

    (abstract ship-cpu)

    (abstract ship-gpu)))

;; ---------- 具体 ----------

(define intel-cpu%
  (class cpu%

    (super-new)

    (define/override (get-cpu-info)
      (format "Intel CPU : ~s" (get-field spec this)))))


(define amd-cpu%
  (class cpu%

    (super-new)

    (define/override (get-cpu-info)
      (format "AMD CPU : ~s" (get-field spec this)))))

(define nvidia-cpu%
  (class cpu%

    (super-new)

    (define/override (get-cpu-info)
      (format "Nvidia CPU : ~s" (get-field spec this)))))

(define nvidia-gpu%
  (class gpu%

    (super-new)

    (define/override (get-gpu-info)
      (format "Nvidia GPU : ~s" (get-field spec this)))))

(define amd-gpu%
  (class gpu%

    (super-new)

    (define/override (get-gpu-info)
      (format "AMD GPU : ~s" (get-field spec this)))))

(define xbox-factory%
  (class console-factory%

    (super-new)

    (define/override (ship-cpu)
      (unless (get-field cpu this)
        (set-field! cpu this (new amd-cpu% [spec ""])))
      (get-field cpu this))

    (define/override (ship-gpu)
      (unless (get-field gpu this)
        (set-field! gpu this (new amd-gpu% [spec "AMD Radeon GCN (36U 2304 Cores)"])))
      (get-field gpu this))))

(define playstation-factory%
  (class console-factory%

    (super-new)

    (define/override (ship-cpu)
      (unless (get-field cpu this)
        (set-field! cpu this (new amd-cpu% [spec "x86-64 AMD Jaguar 8 cores"])))
      (get-field cpu this))

    (define/override (ship-gpu)
      (unless (get-field gpu this)
        (set-field! gpu this (new amd-gpu% [spec "AMD Radeon GCN (36U 2304 Cores)"]))
        )
      (get-field gpu this))))

(define nintendoswitch-factory%
  (class console-factory%

    (super-new)

    (define/override (ship-cpu)
      (unless (get-field cpu this)
        (set-field! cpu this (new amd-cpu% [spec "Cortex A57 4 cores"])))
      (get-field cpu this))

    (define/override (ship-gpu)
      (unless (get-field gpu this)
        (set-field! gpu this (new amd-gpu% [spec "Tegra X1"])))
      (get-field gpu this))))

;; ---------- 客户端 ----------
(define console%
  (class object%
    (super-new)

    (init-field cpu gpu)

    (define/public (get-info)
      (hash 'cpu (get-field cpu this)
            'gpu (get-field gpu this)))))

(define (make-console factory)
  (new console%
       [cpu (send factory ship-cpu)]
       [gpu (send factory ship-gpu)]))

(define ns (make-console (new nintendoswitch-factory%)))
(send ns get-info)
