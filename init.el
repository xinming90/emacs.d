;; 
(defalias 'yes-or-no-p 'y-or-n-p)

;; line number
(global-linum-mode t)
(setq linum-format "%3d ")

;; 
(global-hl-line-mode 1)
(set-face-background hl-line-face "color-254")


;; gdb
(setq gdb-many-windows t)
(global-set-key [f6] 'gdb)
(global-set-key [f9] 'gud-next)
(global-set-key [f10] 'gud-step)


;; elpa
(when (>= emacs-major-version 24)
  (require 'package)
    (add-to-list
     'package-archives
     '("melpa" . "http://melpa.org/packages/")
     t)
    (package-initialize))


;; smex
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)


;; magit
(global-set-key [f5] 'magit-diff-unstaged)
(global-set-key (kbd "S-<f5>") 'magit-diff-staged)
(setq magit-auto-revert-mode nil)
