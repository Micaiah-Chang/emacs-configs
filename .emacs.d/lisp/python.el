;; autoenables line number
;; (add-hook 'python-mode-hook
;; 		  #'(lambda ()
;; 			  (linum-mode t)
;; 			  (highlight-indentation-current-column-mode)
;; 			  (remove-hook 'before-save-hook 'delete-trailing-whitespace)))

(add-to-list 'load-path "~/.emacs.d/el-get/")
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")


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


;; (require 'flycheck)

;; We can safely declare this function, since we'll only call it in Python Mode,
;; that is, when python.el was already loaded.
(declare-function python-shell-calculate-exec-path "python")

(defun flycheck-virtualenv-set-python-executables ()
  "Set Python executables for the current buffer."
  (let ((exec-path (python-shell-calculate-exec-path)))
    (setq-local flycheck-python-pylint-executable
                (executable-find "pylint"))
    (setq-local flycheck-python-flake8-executable
                (executable-find "flake8"))))

(defun flycheck-virtualenv-setup ()
  "Setup Flycheck for the current virtualenv."
  (when (derived-mode-p 'python-mode)
    (add-hook 'hack-local-variables-hook
              #'flycheck-virtualenv-set-python-executables 'local)))

;;(require 'python-mode)
;; Python Mode things
(require 'ein)


(global-set-key (kbd "C-x j") 'python-django-open-project)

(defun increase-linter ()
  "Increase linter error catching"
  (when (< flycheck-checker-error-threshold 600)
    (setq flycheck-checker-error-threshold 600)))

(add-hook 'python-mode-hook 'jedi:setup)
(add-hook 'python-mode-hook 'increase-linter)
(setq jedi:complete-on-dot t)

(defun my-venv (dir-name)
  (interactive "D")
  (setq venv-location dir-name)
  (setq python-environment-directory venv-location)
  (call-interactively 'venv-workon)
  (setq jedi:server-args (list "--virtual-env" dir-name))
  (call-interactively 'jedi:start-dedicated-server)
  (jedi:setup))


(require 'virtualenvwrapper)
(setq venv-location '("/home/alan/dev/eBill/venv/" "/home/alan/okta/venv"))
;;=================================================================
;; (add-to-list 'load-path "~/.emacs.d/el-get/django-mode/")
;; (require 'django-html-mode)
;; (require 'django-mode)
;; (yas/load-directory "~/.emacs.d/el-get/django-mode/snippets")
;; (add-to-list 'auto-mode-alist '("\\.djhtml$" . django-html-mode))
;;=================================================================
;; Dunno if I need the above, will check on next startup

;; Where pymacs is installed to
(push "~/.emacs.d/el-get/pymacs" exec-path)
(setenv "PATH"
        (concat
         "~/.emacs.d/el-get/pymacs" ":"
         (getenv "PATH")
         ))

(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(autoload 'pymacs-autoload "pymacs")
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")
(add-hook 'python-mode #'ropemacs-mode)
