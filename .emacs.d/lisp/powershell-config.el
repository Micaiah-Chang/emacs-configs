;;===========
;; Powershell
;;===========

(add-hook 'shell-mode-hook
          '(lambda ()
             (progn
               (linum-mode -1)
               (ansi-color-for-comint-mode-on))))
