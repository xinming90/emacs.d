;;
;; emacs
;;


;;
(defalias 'yes-or-no-p 'y-or-n-p)
(global-hl-line-mode 1)
(set-face-background hl-line-face "color-240")
(menu-bar-mode 0)
; table to space
(setq-default indent-tabs-mode nil)


;; ido mode
(ido-mode)

;; line number
(global-linum-mode t)
(setq linum-format "%3d ")
(setq line-number-mode t)
(setq column-number-mode t)
(setq size-indication-mode t)

;; time
(setq display-time-day-and-date t)
(display-time)


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


;; theme zenburn
(load-theme 'zenburn t)


;; powerline
(powerline-default-theme)
(setq powerline-utf-8-separator-left 9654)
(setq powerline-utf-8-separator-right 9664)


;; smex
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)


;; magit
(global-set-key (kbd "<f5> <f5>") 'magit-log)
(global-set-key (kbd "<f5> <f6>") 'magit-file-log)
(global-set-key (kbd "<f5> <f7>") 'magit-diff-unstaged)
(global-set-key (kbd "<f5> <f8>") 'magit-diff-staged)


;; jedi
(add-hook 'python-mode-hook 'jedi:setup)


;; flycheck
(global-flycheck-mode)
