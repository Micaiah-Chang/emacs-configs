(add-to-list 'load-path "~/.emacs.d/el-get/jshint-mode")
(add-to-list 'load-path "~/.emacs.d/el-get/js3-mode")

(require 'js3-mode)

(add-hook 'js3-mode-hook
		  #'(lambda ()
			  (setq js3-auto-indent-p t)   ; it's nice for commas to right themselves.
			  (setq js3-enter-indents-newline t) ; don't need to push tab before typing
			  (setq js3-indent-on-enter-key t)   ; fix indenting before moving on
			  (define-key js-mode-map "{" 'paredit-open-curly)
			  (define-key js-mode-map "}" 'paredit-close-curly-and-newline)
			  (paredit-mode 1)))
