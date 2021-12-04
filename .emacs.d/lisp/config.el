(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454"
    (lambda
      (x)
      (+ x x))
    (lambda
      (x)
      (+ x x))
    "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(column-number-mode t)
 '(company-idle-delay 0.7)
 '(cua-enable-cua-keys nil)
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes '(wombat))
 '(custom-file "~/.emacs.d/lisp/config.el")
 '(custom-safe-themes
   '("71b172ea4aad108801421cc5251edb6c792f3adbaecfa1c52e94e3d99634dee7" default))
 '(desktop-restore-eager 7)
 '(flycheck-check-syntax-automatically '(save idle-change mode- enabled))
 '(flycheck-idle-change-delay 4)
 '(geiser-racket-binary "C:\\Program files\\Racket\\Racket.exe")
 '(geiser-racket-gracket-binary "C:\\Program files\\Racket\\GRacket-text.exe")
 '(js3-indent-level 2)
 '(multi-term-program "/bin/zsh")
 '(py-indent-paren-spanned-multilines-p nil)
 '(safe-local-variable-values
   '((python-shell-interpretor . "python")
     (whitespace-style face tabs trailing lines-tail)
     (eval ignore-errors "Write-contents-functions is a buffer-local alternative to before-save-hook"
           (add-hook 'write-contents-functions
                     (lambda nil
                       (delete-trailing-whitespace)
                       nil))
           (require 'whitespace)
           "Sometimes the mode needs to be toggled off and on."
           (whitespace-mode 0)
           (whitespace-mode 1))
     (whitespace-line-column . 80)
     (whitespace-style face trailing lines-tail)
     (require-final-newline . t)))
 '(scroll-down-aggressively 0.4)
 '(scroll-up-aggressively 0.5)
 '(show-paren-mode t)
 '(standard-indent 2)
 '(tls-checktrust t t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Inconsolata" :foundry "outline" :slant normal :weight normal :height 130 :width normal)))))
