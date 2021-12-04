;; autoenables line number
;; (add-hook 'python-mode-hook
;; 		  #'(lambda ()
;; 			  (linum-mode t)
;; 			  (highlight-indentation-current-column-mode)
;; 			  (remove-hook 'before-save-hook 'delete-trailing-whitespace)))

(setq flycheck-flake8rc "~/.flake8")


(elpy-enable)

(setq auto-mode-alist
      (append '(("\\.html?$" . django-html-mumamo-mode)) auto-mode-alist))
(setq mumamo-background-colors nil)
(add-to-list 'auto-mode-alist '("\\.html$" . django-html-mumamo-mode))


;; Workaround the for the below warnings:
;; Warning (mumamo-per-buffer-local-vars):
;; Already 'permanent-local t: buffer-file-name
(when (and (>= emacs-major-version 24)
		   (>= emacs-minor-version 2))
  (eval-after-load "mumamo"
	'(setq mumamo-per-buffer-local-vars
		   (delq 'buffer-file-name mumamo-per-buffer-local-vars))))


;;(require 'python-mode)
;; Python Mode things

(defun increase-linter ()
  "Increase linter error catching"
  (when (< flycheck-checker-error-threshold 600)
    (setq flycheck-checker-error-threshold 600)))
;;=================================================================
;; (add-to-list 'load-path "~/.emacs.d/el-get/django-mode/")
;; (require 'django-html-mode)
;; (require 'django-mode)
;; (yas/load-directory "~/.emacs.d/el-get/django-mode/snippets")
;; (add-to-list 'auto-mode-alist '("\\.djhtml$" . django-html-mode))
;;=================================================================
;; Dunno if I need the above, will check on next startup
