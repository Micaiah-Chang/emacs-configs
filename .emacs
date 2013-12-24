(when (string-equal system-type "windows-nt")
  (setq user-emacs-directory "c:/Users/Alan/AppData/Roaming/.emacs.d/"))

(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)
         user-emacs-directory)
        ((boundp 'user-init-directory)
         user-init-directory)
        (t "~/.emacs.d/")))
;; Dynamically set the home location

(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))


(load-user-file "init.el") ;; Everything is down this rabbit hole whee
