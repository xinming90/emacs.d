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


;; paren
(show-paren-mode t)


;; electric-pair-mode
(electric-pair-mode t)


;;
;(desktop-save-mode t)


;; ediff
(setq ediff-split-window-function 'split-window-horizontally)
(global-set-key (kbd "C-c d") 'vc-ediff)


;;
;(set-face-attribute 'vertical-border
;                   nil
;                   :foreground "#282a2e")


;; line number
(global-linum-mode t)
(setq linum-format "%4d ")
(setq line-number-mode t)
(setq column-number-mode t)
(setq size-indication-mode t)

; https://github.com/viseztrance/.emacs.d/blob/master/config/user-interface-setup.el
(set-face-attribute 'linum nil
                    :foreground "#ccc"
                    :background "#444")


;; time
(setq display-time-day-and-date t)
(display-time)


;; c/c++
(add-hook 'c-mode-hook 'auto-complete-mode)
(add-hook 'c++-mode-hook 'auto-complete-mode)

;; c 
(setq-default c-basic-offset 4)


;; gdb
(setq gdb-many-windows t)
(global-set-key [f6] 'gdb)
(global-set-key [f9] 'gud-next)
(global-set-key [f10] 'gud-step)


;; org-mode
(setq org-log-done t)


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
(global-set-key (kbd "C-c g s") 'magit-status)
(global-set-key (kbd "C-c g l") 'magit-log)
(global-set-key (kbd "C-c g f") 'magit-file-log)
(global-set-key (kbd "C-c g d u") 'magit-diff-unstaged)
(global-set-key (kbd "C-c g d s") 'magit-diff-staged)


;; jedi
(add-hook 'python-mode-hook 'jedi:setup)

;; http://txt.arboreus.com/2013/02/21/jedi.el-jump-to-definition-and-back.html
(add-hook 'python-mode-hook
          '(lambda()
             (local-set-key (kbd "C-[ [ ,") 'jedi:goto-definition)
             (local-set-key (kbd "C-[ [ .") 'jedi:goto-definition-pop-marker)))


;; flycheck
(add-hook 'python-mode-hook 'flycheck-mode)


;; window-numbering
(window-numbering-mode)


;; git-gutter
(global-git-gutter-mode t)

;; Jump to next/previous hunk
(global-set-key (kbd "C-x p") 'git-gutter:previous-hunk)
(global-set-key (kbd "C-x n") 'git-gutter:next-hunk)


;; anzu
(global-anzu-mode)


;; flx-ido
(flx-ido-mode)



;; ecb
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;
;(global-set-key (kbd "<f12>") 'ecb-activate)


;; Enable helm-gtags-mode
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)


;; Set key bindings
; http://superuser.com/questions/731427/how-do-i-send-ctrl-in-iterm2
(eval-after-load "helm-gtags"
  '(progn
     (define-key helm-gtags-mode-map (kbd "C-[ [ ,") 'helm-gtags-find-tag-from-here)
     (define-key helm-gtags-mode-map (kbd "C-[ [ .") 'helm-gtags-previous-history)))

;; auto-update gtags
(setq helm-gtags-auto-update t)
(setq helm-gtags-update-interval-second nil)


;; auto-highlight-symbol
(global-auto-highlight-symbol-mode)


;; cython-mode
; for gevent
(add-to-list 'auto-mode-alist '("\\.ppyx\\'" . cython-mode))


;; fill-column-indicator
(add-hook 'python-mode-hook 'fci-mode)
(setq fci-rule-column 80)
(setq fci-rule-width 1)
(setq fci-rule-color "color-240")
(setq fci-rule-character 10006)


;; multi-term
(add-hook 'term-mode-hook
          (lambda()
            (delete '("C-n" . next-line) term-bind-key-alist)
            (delete '("C-p" . previous-line) term-bind-key-alist)))
