;;===========
;; Powershell
;;===========


(autoload 'powershell "powershell" "Run powershell as a shell within emacs." t)

;; add dir to load path
(add-to-list 'load-path "~/.emacs.d/")

;; powershell-mode
(autoload 'powershell-mode "powershell-mode" "A editing mode for Microsoft PowerShell." t)
(add-to-list 'auto-mode-alist '("\\.ps1\\'" . powershell-mode)) ; PowerShell script


;; autoload powershell interactive shell
(autoload 'powershell "powershell" "Start a interactive shell of PowerShell." t)

(add-hook 'shell-mode-hook
          '(lambda ()
             (progn
               (linum-mode -1)
               (ansi-color-for-comint-mode-on))))
