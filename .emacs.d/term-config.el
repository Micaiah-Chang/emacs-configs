;;=============
;; Terminal
;;=============


;; in case el-get doesn't work from some userland restrictions or WINDOWS
(ignore-errors (require 'multi-term)
               (setq multi-term-program "/bin/bash"))
;; Set bash as default shell for multi-term



(add-hook 'term-mode-hook
          '(lambda ()
             (progn
               (linum-mode -1)
               (ansi-color-for-comint-mode-on)
               (yas-minor-mode -1))))
