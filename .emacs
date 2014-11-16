(when (string-equal system-type "windows-nt")
  (setq user-emacs-directory "c:/Users/Alan/AppData/Roaming/.emacs.d/"))
;; Change load-path to the ~.emacs.d/lisp/ subdirectory

(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)
         (concat user-emacs-directory
                 (convert-standard-filename "lisp/")))
        ((boundp 'user-init-directory)
         (concat user-init-directory
                 (convert-standard-filename "lisp/")))
        (t "~/.emacs.d/lisp/")))
;; Dynamically set the home location

(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))

(server-start)

(load-user-file "init.el") ;; Everything is down this rabbit hole whee
