(add-to-list 'load-path "~/.emacs.d/el-get/jshint-mode")
(require 'flymake-jshint)
(add-hook 'js3-mode-hook
     (lambda () (flymake-mode t)))

(define-key js-mode-map "{" 'paredit-open-curly)
(define-key js-mode-map "}" 'paredit-close-curly-and-newline)
