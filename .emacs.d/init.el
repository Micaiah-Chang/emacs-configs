(load-file "~/.emacs.d/packages.el")
(load-file "~/.emacs.d/config.el")
(load-file "~/.emacs.d/clang.el")
(load-file "~/.emacs.d/elsp.el")
(load-file "~/.emacs.d/keybindings.el")
(load-file "~/.emacs.d/powershell-config.el")
(load-file "~/.emacs.d/term-config.el")
(load-file "~/.emacs.d/python.el")

(add-to-list 'load-path "~/.emacs.d/igor-mode-master")
(require 'igor-mode)



;;=============
;; Octave
;;=============
(setq auto-mode-alist (cons '("\\.m$" . octave-mode)
							auto-mode-alist))

;;=============
;; Scala
;;=============
(setq auto-mode-alist (cons '("\\.scala$" . scala-mode)
							auto-mode-alist))

;;=============
;; Magit
;;=============

(unless (eq system-type 'windows-nt)
  (add-to-list 'load-path "~/.emacs.d/el-get/magit"))
(require 'magit)
(global-set-key (kbd "\C-X \C-g") 'magit-status)

;;============
;; Global Modes
;;============
;; Make things pretty

(require 'powerline)
; (powerline-default-theme)


(require 'ido)
(ido-mode t)


 
;; aliases
(defalias 'rnb 'rename-buffer)
(defalias 'mt 'multi-term)
(defalias 'dtw 'delete-trailing-whitespace)
(defalias 'rb 'revert-buffer)

;; replacements for defaults
(defalias 'list-buffers 'ibuffer) ; always use ibuffer
(defalias 'man 'woman) ; I like my man like I like my woman: efficient with emacs.


(global-linum-mode 1) ; Show line numbers
(global-visual-line-mode 1) ; Soft word-wrapping
(column-number-mode 1) ; Show columns
(show-paren-mode 1) ; Parent matching for lisp + infix languages
(fset 'yes-or-no-p 'y-or-n-p) ; Shorten things!
(setq-default tab-width 4) ; From python habits
(setq indent-tabs-mode nil) ;; Convert tabs to spaces

;; whenever an external process changes a file underneath emacs, and there
;; was no unsaved changes in the corresponding buffer, just revert its
;; content to reflect what's on-disk.
;; Mostly used for git
(global-auto-revert-mode 1)

(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse) ;; Display file path after buffer name


;;yasnippet
(add-to-list 'load-path "~/.emacs.d/el-get/yasnippet/snippets")
(require 'yasnippet)
(setq yas/root-directory "~/.emacs.d/el-get/yasnippet/snippets")
(yas/load-directory yas/root-directory)
(yas-global-mode 1)


;; smex configurations
(setq smex-save-file "~/.emacs.d/.smex-items")
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)


(require 'desktop)
(desktop-save-mode 1)
(defun my-desktop-save ()
  (interactive)
  ;; Don't call desktop-save-in-desktop-dir, as it prints a message.
  (if (eq (desktop-owner) (emacs-pid))
      (desktop-save desktop-dirname)))
(add-hook 'auto-save-hook 'my-desktop-save)


(defun redo-tree-stuff ()
  (progn
    (require 'undo-tree)
    (global-undo-tree-mode 1)
    (defalias 'redo 'undo-tree-redo)
    (global-unset-key "\C-z")
    (global-set-key (kbd "\C-z") 'undo)
    (global-set-key [(ctrl shift z)] 'redo)))

(redo-tree-stuff)



;; Jesus christ ctrl-z should never be suspend arrggh

(setq backup-by-copying t)

(defun my-backup-file-name (fpath)
  "Return a new file path of a given file path.
If the new path's directories does not exist, create them."
  (let* ((backupRootDir
		  "~/.emacs.d/emacs-backup")
         (filePath
		  (replace-regexp-in-string "[A-Za-z]:" "" fpath )) ; remove Windows driver letter in path, "C:"
         (backupFilePath
		  (replace-regexp-in-string "//" "/"
									(concat backupRootDir filePath "~"))))
    (make-directory (file-name-directory backupFilePath)
					(file-name-directory backupFilePath))
    backupFilePath))

(setq make-backup-file-name-function 'my-backup-file-name)
(put 'upcase-region 'disabled nil)
