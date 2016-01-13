;;; package. --- Init file for .emacs.
;;; Commentary: 

;;; Code:

(load-user-file "packages.el")
(load-user-file "config.el")
(load-user-file "clang.el")
(load-user-file "elsp.el")
(load-user-file "keybindings.el")
(load-user-file "powershell-config.el")
(unless (eq system-type 'windows-nt)
  (load-user-file "term-config.el"))
(load-user-file "python.el")
(load-user-file "js.el")

;; (add-to-list 'load-path "~/.emacs.d/igor-mode-master")
;; (require 'igor-mode)

;(add-hook 'after-init-hook #'global-flycheck-mode)


;;------------
;; Markdown
;;------------
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))



;;------------
;; Tramp
;;------------
(setq tramp-default-method "ssh")

;;------------
;; Octave
;;------------
(setq auto-mode-alist (cons '("\\.m$" . octave-mode)
			    auto-mode-alist))

;;------------
;; Scala
;;------------
(setq auto-mode-alist (cons '("\\.scala$" . scala-mode)
			    auto-mode-alist))

;;------------
;; Paredit
;;------------
(require 'paredit) 


(defun my-paredit-nonlisp ()
  "Turn on paredit mode for non-lisps."
  (interactive)
  (set (make-local-variable 'paredit-space-for-delimiter-predicates)
       '((lambda (endp delimiter) nil))))


(add-hook 'prog-mode 'my-paredit-nonlisp)
;;------------
;; Magit
;;------------
(unless (eq system-type 'windows-nt)
  (add-to-list 'load-path "~/.emacs.d/el-get/magit"))
(autoload 'magit "magit" "Magit" t)
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
  (magit-refresh))

(add-hook 'magit-mode-hook 
	  #'(lambda () (define-key magit-status-mode-map
	     (kbd "W")
	     'magit-toggle-whitespace)))

(setq magit-last-seen-setup-instructions "1.4.0")
;;------------
;; Global Modes
;;------------


(setq mac-option-modifier 'super)
(setq mac-command-modifier 'meta)


;;info stuff
;; (add-to-list 'load-path "~/.emacs.d/el-get/pydoc-info")
;; (unless (eq system-type 'windows-nt)
;;   (require 'pydoc-info))

;; (require 'info-look)

;; (info-lookup-add-help
;;  :mode 'python-mode
;;  :regexp "[[:alnum:]_]+"
;;  :doc-spec '(("(python)Index" nil "")))

;; whenever an external process changes a file underneath emacs, and there
;; was no unsaved changes in the corresponding buffer, just revert its
;; content to reflect what's on-disk.
;; Mostly used for git
(global-auto-revert-mode 1)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets) ;; Display file path after buffer name


;;yasnippet

(if (eq system-type 'windows-nt)
    (add-to-list 'load-path "~/.emacs.d/el-get/yasnippet/snippets")
  (add-to-list 'load-path "~/.emacs.d/el-get/yasnippet/snippets"))

(require 'yasnippet)

(if (eq system-type 'windows-nt)
    (setq yas/root-directory
	  "~/.emacs.d/el-get/package/elpa/yasnippet-20141102.1554/snippets")
  (setq yas/root-directory "~/.emacs.d/el-get/yasnippet/snippets"))

(yas-load-directory yas/root-directory 't)

(yas-global-mode 1)

;;web-mode
(setq auto-mode-alist (remove '("\\.[sx]?html?\\(\\.[a-zA-Z_]+\\)?\\'" . html-mode) auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-hook 'web-mode-hook #'(lambda () (yas-activate-extra-mode 'html-mode)
                             (yas-activate-extra-mode 'nxml-mode)))


(setq web-mode-engines-alist
      '(("php"    . "\\.phtml\\'")
        ("blade"  . "\\.blade\\.")
        ("django" . "\\.html\\'")))

(setq web-mode-content-types
	  '(("django" . "\\.html\\'")))


; ace-jump-mode
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)


;;autocomplete
(add-to-list 'load-path "~/.emacs.d/el-get/auto-complete")
(require 'auto-complete-config)
(add-to-list 'load-path "~/.emacs.d/el-get/auto-complete/dict")

;; Allow yas to trigger first then ac
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

;; smex configurations
(setq smex-save-file "~/.emacs.d/.smex-items")
(global-set-key (kbd "M-x") 'smex)
(global-set-key [(meta shift x)] 'smex-major-mode-commands)


(require 'desktop)
(desktop-save-mode 1)
(defun my-desktop-save ()
  (interactive)
  ;; Don't call desktop-save-in-desktop-dir, as it prints a message.
  (if (eq (desktop-owner) (emacs-pid))
      (desktop-save desktop-dirname)))
(add-hook 'auto-save-hook 'my-desktop-save)

(defun emacs-process-p (pid)
  "If pid is the process ID of an emacs process, return t, else nil.
Also returns nil if pid is nil."
  (when pid
    (let ((attributes (process-attributes pid)) (cmd))
      (dolist (attr attributes)
	(if (string= "comm" (car attr))
	    (setq cmd (cdr attr))))
      (if (and cmd (or (string= "emacs" cmd) (string= "emacs.exe" cmd))) t))))

(defadvice desktop-owner (after pry-from-cold-dead-hands activate)
  "Don't allow dead emacsen to own the desktop file."
  (when (not (emacs-process-p ad-return-value))
    (setq ad-return-value nil)))


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


(defun move-buffer-file (dir)
  "Moves both current buffer and file it's visiting to DIR."
  (interactive "DNew directory: ")
  (let* ((name (buffer-name))
	 (filename (buffer-file-name))
	 (dir
	  (if (string-match dir "\\(?:/\\|\\\\)$")
	      (substring dir 0 -1) dir))
	 (newname (concat dir "/" name)))

    (if (not filename)
	(message "Buffer '%s' is not visiting a file!" name)
      (progn
	(copy-file filename newname 1)
	(delete-file filename)
	(set-visited-file-name newname)
	(set-buffer-modified-p nil) 	t))))

(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
	(filename (buffer-file-name)))
    (if (not filename)
	(message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
	  (message "A buffer named '%s' already exists!" new-name)
	(progn
	  (rename-file name new-name 1)
	  (rename-buffer new-name)
	  (set-visited-file-name new-name)
	  (set-buffer-modified-p nil))))))



(setq make-backup-file-name-function 'my-backup-file-name)
(put 'upcase-region 'disabled nil)

;; Make things pretty

(require 'powerline)

(set-face-attribute 'mode-line nil
		    :background "OliveDrab3"
		    :foreground "black"
		    :box nil)

(powerline-center-theme)



;; No scrollbars on windows
(when (eq system-type 'windows-nt)
  (menu-bar-no-scroll-bar))


(require 'ido)
(ido-mode t)


;; Required to stop multi-term from breaking
;; (defmacro ad-macro-p (definition)
;;   ;;"non-nil if DEFINITION is a macro."
;;   (` (eq (car-safe (, definition)) 'macro)))


;; (defun ad-advised-definition-p (definition)
;;   ;;"non-nil if DEFINITION was generated from advice information."
;;   (if (or (ad-lambda-p definition)
;; 		  (ad-macro-p definition)
;; 		  (ad-compiled-p definition))
;; 	  (let ((docstring (ad-docstring definition)))
;; 		(and (stringp docstring)
;; 			 (string-match
;; 			  ad-advised-definition-docstring-regexp docstring)))))



;; aliases
(defalias 'rnb 'rename-buffer)
(defalias 'mt 'multi-term)
(defalias 'dtw 'delete-trailing-whitespace)
(defalias 'rb 'revert-buffer)

;; replacements for defaults
(defalias 'list-buffers 'ibuffer) ; always use ibuffer
(defalias 'man 'woman) ; I like my man like I like my woman: efficient with emacs.
(defalias 'mbf 'move-buffer-file )
(defalias 'rnfb 'rename-file-and-buffer)

(global-linum-mode 1) ; Show line numbers
(global-visual-line-mode 1) ; Soft word-wrapping
(column-number-mode 1) ; Show columns
(show-paren-mode 1) ; Parent matching for lisp + infix languages
(fset 'yes-or-no-p 'y-or-n-p) ; Shorten things!
(setq-default tab-width 4) ; From python habits
(setq-default indent-tabs-mode nil)
(tool-bar-mode -1) ;; Remove buttons

(provide 'init)
;;; init.el ends here
