;;------------------
;;Package Management
;;------------------

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))


(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get/recipes")

(push '(:name yasnippet
               :website "https://github.com/capitaomorte/yasnippet.git"
               :description "YASnippet is a template system for Emacs."
               :type github
               :pkgname "capitaomorte/yasnippet"
               :features "yasnippet"
               :compile "yasnippet.el")
       el-get-sources)

;;(el-get 'sync)

;; Sync all my packages together so long as it has a recipe
;; Note: The following has to be sync manually with git:
;; auctex, flymake, powershell.el, pylint, request
(setq my-packages (append
		   '(el-get ein nxhtml
			    auto-complete
			    jedi
			    package powerline
			    paredit popup pymacs
			    python-mode quack
			    request undo-tree websocket
				smex yasnippet zenburn) ; yasnippet magit
				   (mapcar 'el-get-source-name el-get-sources)))

(if (eq system-type 'windows-nt)
	(append my-packages '(multi-term))
  (append my-packages '(magit)))

(el-get 'sync my-packages)


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


(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))
