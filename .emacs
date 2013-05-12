;;El-get 

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")


(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
     (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#242424" "#e5786d" "#95e454" (lambda (x) (+ x x)) (lambda (x) (+ x x)) "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(cua-enable-cua-keys nil)
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes (quote (wombat)))
 '(custom-safe-themes (quote ("71b172ea4aad108801421cc5251edb6c792f3adbaecfa1c52e94e3d99634dee7" default)))
 '(geiser-racket-binary "C:\\Program files\\Racket\\Racket.exe")
 '(geiser-racket-gracket-binary "C:\\Program files\\Racket\\GRacket-text.exe"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" .
						  "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))




;; (add-to-list 'load-path "~/.emacs.d/el-get/el-get")
;; (unless (require 'el-get nil 'noerror)
;;   (with-current-buffer
;;       (url-retrieve-synchronously
;;        "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
;;     (let (el-get-master-branch)
;;       (goto-char (point-max))
;;       (eval-print-last-sexp))))
;; (el-get 'sync)



(require 'ido)
(ido-mode t)



;;=======
;; Python
;;=======

;; autoenables line number
 (add-hook 'python-mode-hook #'(lambda ()
				 (linum-mode t)))

(add-to-list 'load-path "./python-mode/") 
(setq py-install-directory "./python-mode/")
(require 'python-mode)
;; Python Mode things

(require 'ein)

;;======
;; elisp
;;======

(add-hook 'lisp-mode-hook #'(lambda ()
			      (linum-mode t)))

;;===========
;; Powershell
;;===========


(autoload 'powershell "powershell" "Run powershell as a shell within emacs." t)

;; add dir to load path
(add-to-list 'load-path "~/.emacs.d/")

;; powershell-mode
(autoload 'powershell-mode "powershell-mode" "A editing mode for Microsoft PowerShell." t)
(add-to-list 'auto-mode-alist '("\\.ps1\\'" . powershell-mode)) ; PowerShell script
;; add dir to load path
(add-to-list 'load-path "~/.emacs.d/")

;; add the dir to load path
(add-to-list 'load-path "~/.emacs.d/")

;; autoload powershell interactive shell
(autoload 'powershell "powershell" "Start a interactive shell of PowerShell." t)

(add-hook 'shell-mode-hook 
	  '(lambda ()
	     (progn
	       (linum-mode -1)
	       (local-unset-key "C-z")
	       (local-set-key (kbd "\C-z")
			      'undo)
		   (ansi-color-for-comint-mode-on))))

;;=============
;; Key Bindings
;;=============

(global-set-key (kbd "\C-x t") 'transpose-buffers)

(global-set-key (kbd "\C-x e") 'eval-buffer)

(global-set-key (kbd "\C-c d") 'insert-date)

(defun transpose-buffers (arg)
  "Transpose the buffers shown in two windows."
  (interactive "p")
  (let ((selector (if (>= arg 0) 'next-window 'previous-window)))
    (while (/= arg 0)
      (let ((this-win (window-buffer))
            (next-win (window-buffer (funcall selector))))
        (set-window-buffer (selected-window) next-win)
        (set-window-buffer (funcall selector) this-win)
        (select-window (funcall selector)))
      (setq arg (if (plusp arg) (1- arg) (1+ arg))))))

 (defun insert-date (prefix)
    "Insert the current date. With prefix-argument, use ISO format. With
   two prefix arguments, write out the day and month name."
    (interactive "P")
    (let ((format (cond
                   ((not prefix) "%m/%d/%Y")
                   ((equal prefix '(4)) "%Y-%m-%d")
                   ((equal prefix '(16)) "%A, %d. %B %Y")))
          (system-time-locale "de_DE"))
      (insert (format-time-string format))))


;;============
;; Global Modes
;;============

(global-linum-mode 1) ; Show line numbers
(global-visual-line-mode 1) ; Soft word-wrapping
(show-paren-mode 1) ; Parent matching for lisp + infix languages
(fset 'yes-or-no-p 'y-or-n-p) ; Shorten things!
(defalias 'list-buffers 'ibuffer) ; always use ibuffer
(setq-default tab-width 4)
(setq indent-tabs-mode nil) ;; Convert tabs to spacesr

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
    (global-set-key (kbd "\C-Z") 'redo)))

(setq backup-by-copying t)

(defun my-backup-file-name (fpath)
  "Return a new file path of a given file path.
If the new path's directories does not exist, create them."
  (let* (
        (backupRootDir "c:/Users/N/Dropbox/backups/")
        (filePath (replace-regexp-in-string "[A-Za-z]:" "" fpath )) ; remove Windows driver letter in path, "C:"
        (backupFilePath (replace-regexp-in-string "//" "/" (concat backupRootDir filePath "~") ))
        )
    (make-directory (file-name-directory backupFilePath) (file-name-directory backupFilePath))
    backupFilePath
  )
)

(setq make-backup-file-name-function 'my-backup-file-name)
(put 'upcase-region 'disabled nil)

