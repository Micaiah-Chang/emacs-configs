;;; packages.el --- El-get manages packages here.
;;; Commentary:

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))


(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get/recipes")

;;(el-get 'sync)

;; Sync all my packages together so long as it has a recipe
;; Note: The following has to be sync manually with git:
;; auctex, flymake, powershell.el, pylint, request
;; NOTE: python-mode now runs on bzr!!!!!
(setq my-packages (append
	  '(el-get
        ace-jump-mode ace-window
	    auto-complete color-theme-zenburn
	    highlight-indentation
	    js3-mode jshint-mode magit
		markdown-mode
	    package powerline paredit
	    popup pymacs quack
		racket-mode
	    smex undo-tree
	    yasnippet) ; yasnippet magit
	  (mapcar 'el-get-source-name el-get-sources)))


(cond ((eq system-type 'windows-nt) (el-get '() (append my-packages '(exec-path-from-shell))))
      ((eq system-type 'darwin) (el-get '() (append my-packages '(multi-term  exec-path-from-shell multiple-cursors
                                                                             dash-at-point))))
      (else (el-get '() (append my-packages '(multi-term python-mode pydoc-info flycheck multiple-cursors)))))


;; (defun el-get-cleanup (packages)
;;   "Remove packages not explicitly declared"
;;   (let* ((packages-to-keep (el-get-dependencies (mapcar 'el-get-as-symbol packages)))
;;          (packages-to-remove (set-difference (mapcar 'el-get-as-symbol
;;                                                      (el-get-list-package-names-with-status
;;                                                       "installed")) packages-to-keep)))
;;     (mapc 'el-get-remove packages-to-remove)))

;; (el-get-cleanup my-packages)


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

;; generate trusted root certs from
;; python's certifi
(let ((trustfile
       (replace-regexp-in-string
        "\\\\" "/"
        (replace-regexp-in-string
         "\n" ""
         (shell-command-to-string "python -m certifi")))))
  (setq tls-program
        (list
         (format "gnutls-cli%s --x509cafile %s -p %%p %%h"
                 (if (eq window-system 'w32) ".exe" "") trustfile)))
  (setf tls-checktrust t)
  (setq gnutls-verify-error t)
  (setq gnutls-trustfiles (list trustfile)))


(el-get 'sync)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;;(when
;;     (load(expand-file-name "~/.emacs.d/elpa/package.el"))
;;   (package-initialize))
