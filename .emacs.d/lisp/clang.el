;;=======
;; C
;;=======

(add-hook 'c-mode-common-hook #'(lambda ()
                                  (c-set-style "k&r")))