(add-to-list 'load-path "~/.emacs.d/el-get/jshint-mode")


(add-hook 'js3-mode-hook
		  #'(lambda ()
			  (js3-auto-indent-p t)   ; it's nice for commas to right themselves.
			  (js3-enter-indents-newline t) ; don't need to push tab before typing
			  (js3-indent-on-enter-key t)   ; fix indenting before moving on
			  (define-key js-mode-map "{" 'paredit-open-curly)
			  (define-key js-mode-map "}" 'paredit-close-curly-and-newline)
			  (paredit-mode 1)))
