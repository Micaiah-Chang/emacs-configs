;;; packages.el --- El-get manages packages here.
;;; Commentary:


(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))



;;(el-get 'sync)


;; (cond ((eq system-type 'windows-nt) (el-get '() (append my-packages '(exec-path-pfrom-shell))))
;;       ((eq system-type 'darwin) (el-get '() (append my-packages '(exec-path-from-shell multiple-cursors
;; ))))
;;       (else (el-get '() (append my-packages '(multi-term python-mode pydoc-info flycheck multiple-cursors)))))

(straight-use-package 'use-package)
(setq straight-use-package-by-default 't)

(use-package ace-jump-mode
  :config
  (define-key global-map (kbd "C-c SPC") 'ace-jump-mode))
(use-package ace-window)
(use-package zenburn-theme)
(use-package desktop
  :config
  (desktop-save-mode 1)
  (defun my-desktop-save ()
    (interactive)
    ;; Don't call desktop-save-in-desktop-dir, as it prints a message.
    (if (eq (desktop-owner) (emacs-pid))
        (desktop-save desktop-dirname)))
  (add-hook 'auto-save-hook 'my-desktop-save))
(use-package editorconfig)
(use-package elpy)
(use-package eterm-256color)
(use-package flycheck)
(use-package ido
  :config
  (ido-mode t))
(use-package highlight-indentation)
(use-package paredit)
(use-package magit
  :init
  (add-hook 'magit-mode-hook
	        #'(lambda () (define-key magit-status-mode-map
	                       (kbd "W")
	                       'magit-toggle-whitespace)))

  :config
  (global-set-key (kbd "\C-c g") 'magit-status)
  (defun magit-toggle-whitespace ()
    (interactive)
    (if (member "-w --ignore-space-at-eol" magit-diff-options)
        (magit-dont-ignore-whitespace)
      (magit-ignore-whitespace)))

  (defun magit-ignore-whitespace ()
    (interactive)
    (add-to-list 'magit-diff-options "-w --ignore-space-at-eol")
    (magit-refresh))

  (defun magit-dont-ignore-whitespace ()
    (interactive)
    (setq magit-diff-options (remove "-w --ignore-space-at-eol" magit-diff-options))
    (magit-refresh)))
(use-package multi-term
  :config
  (add-hook 'term-mode-hook #'eterm-256color-mode))
(use-package popup)
(use-package quack)
(use-package racket-mode)
(use-package smex
  :config
  (setq smex-save-file "~/.emacs.d/.smex-items")
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key [(meta shift x)] 'smex-major-mode-commands))
(use-package undo-tree
  :config
  (global-undo-tree-mode 1)
  (defalias 'redo 'undo-tree-redo)
  (global-unset-key "\C-z")
  (global-set-key (kbd "\C-z") 'undo)
  (global-set-key [(ctrl shift z)] 'redo))
(use-package powerline)
(set-face-attribute 'mode-line nil
		            :background "OliveDrab3"
		            :foreground "black"
		            :box nil)
(powerline-center-theme)
(use-package powershell)
(use-package powershell-mode)

(use-package company-tabnine :ensure t)
(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (add-to-list 'company-backends #'company-tabnine)
  ;; Trigger completion immediately.
  (setq company-idle-delay 0)

  ;; Number the candidates (use M-1, M-2 etc to select completions).
  (setq company-show-numbers t))
(require 'uniquify)

(setq uniquify-buffer-name-style 'post-forward-angle-brackets) ;; Display file path after buffer name
