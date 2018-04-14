(add-to-list 'load-path "~/.emacs.d/el-get/jshint-mode")
(add-to-list 'load-path "~/.emacs.d/el-get/js3-mode")

(eval-after-load 'js2-mode
  '(progn
     (require 'js2-imenu-extras)

     ;; The code to record the class is identical to that for
     ;; Backbone so we just make an alias
     (defalias 'js2-imenu-record-react-class
       'js2-imenu-record-backbone-extend)

     (unless (loop for entry in js2-imenu-extension-styles
                   thereis (eq (plist-get entry :framework) 'react))
       (push '(:framework react
               :call-re "\\_<React\\.createClass\\s-*("
               :recorder js2-imenu-record-react-class)
             js2-imenu-extension-styles))

     (add-to-list 'js2-imenu-available-frameworks 'react)
     (add-to-list 'js2-imenu-enabled-frameworks 'react)))

(defun modify-syntax-table-for-jsx ()
  (modify-syntax-entry ?< "(>")
  (modify-syntax-entry ?> ")<"))

(add-hook 'js2-mode-hook 'modify-syntax-table-for-jsx)

(require 'js3-mode)

(add-hook 'js3-mode-hook
		  #'(lambda ()
			  (setq js3-auto-indent-p t)   ; it's nice for commas to right themselves.
			  (setq js3-enter-indents-newline t) ; don't need to push tab before typing
			  (setq js3-indent-on-enter-key t)   ; fix indenting before moving on
			  (define-key js-mode-map "{" 'paredit-open-curly)
			  (define-key js-mode-map "}" 'paredit-close-curly-and-newline)
			  (paredit-mode 1)))

;; for better jsx syntax-highlighting in web-mode
;; - courtesy of Patrick @halbtuerke
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
    (let ((web-mode-enable-part-face nil))
      ad-do-it)
    ad-do-it))

;; (setq-default flycheck-disabled-checkers
;;   (append flycheck-disabled-checkers
;;     '(javascript-jshint)))

;; use eslint with web-mode for jsx files
;; (flycheck-add-mode 'javascript-eslint 'web-mode)

(defun my/use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))

(setq js-indent-level 2)

(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)
