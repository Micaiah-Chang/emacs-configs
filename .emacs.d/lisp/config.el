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
 '(cua-enable-cua-keys nil)
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes (quote (wombat)))
 '(custom-file "~/.emacs.d/lisp/config.el")
 '(custom-safe-themes
   (quote
    ("71b172ea4aad108801421cc5251edb6c792f3adbaecfa1c52e94e3d99634dee7" default)))
 '(desktop-restore-eager 7)
 ;; '(flycheck-highlighting-mode (quote lines))
 '(geiser-racket-binary "C:\\Program files\\Racket\\Racket.exe")
 '(geiser-racket-gracket-binary "C:\\Program files\\Racket\\GRacket-text.exe")
 '(js3-indent-level 2)
 '(py-indent-paren-spanned-multilines-p nil)
 '(safe-local-variable-values
   (quote
	((whitespace-style face tabs trailing lines-tail)
	 (eval ignore-errors "Write-contents-functions is a buffer-local alternative to before-save-hook"
		   (add-hook
			(quote write-contents-functions)
			(lambda nil
			  (delete-trailing-whitespace)
			  nil))
		   (require
			(quote whitespace))
		   "Sometimes the mode needs to be toggled off and on."
		   (whitespace-mode 0)
		   (whitespace-mode 1))
	 (whitespace-line-column . 80)
	 (whitespace-style face trailing lines-tail)
	 (require-final-newline . t))))
 '(scroll-down-aggressively 0.4)
 '(scroll-up-aggressively 0.5)
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight normal :height 98 :width normal)))))
