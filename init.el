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


;; split window
(global-set-key (kbd "C-x v") 'split-window-right)
(global-set-key (kbd "C-x s") 'split-window-below)
;; http://stackoverflow.com/questions/6464738/how-can-i-switch-focus-after-buffer-split-in-emacs
(defadvice split-window (after move-point-to-new-window activate)
  "Moves the point to the newly created window after splitting."
  (other-window 1))


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


;; comment-dwim
;; Original idea from
;; http://www.opensubscriber.com/message/emacs-devel@gnu.org/10971693.html
(defun comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
  If no region is selected and current line is not blank and we are not at the end of the line,
  then comment current line.
  Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key (kbd "C-[ [ ;") 'comment-dwim-line)


;; python
(defun my-python-mode-hook ()
  (hs-minor-mode)
  (define-key hs-minor-mode-map (kbd "C-c h") 'hs-hide-all)
  (define-key hs-minor-mode-map (kbd "C-c s") 'hs-show-all)
  (define-key hs-minor-mode-map (kbd "C-[ [ -") 'hs-hide-block)
  (define-key hs-minor-mode-map (kbd "C-[ [ +") 'hs-show-block)
  ;;(view-mode)
)

(add-hook 'python-mode-hook 'my-python-mode-hook)


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


;; auto-insert-mode             http://www.emacswiki.org/emacs/AutoInsertMode
(auto-insert-mode)  ;;; Adds hook to find-files-hook
(setq auto-insert-directory "~/.emacs.d/templates/") ;;; Or use custom, *NOTE* Trailing slash important
(setq auto-insert-query nil) ;;; If you don't want to be prompted before insertion
(define-auto-insert "\.py" "template.py")


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


;; web-mode
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-enable-auto-closing t)
  (setq web-mode-auto-close-style 2))
  
(add-hook 'html-mode-hook 'web-mode)
(add-hook 'web-mode-hook 'my-web-mode-hook)


;; heml-ag
(global-set-key (kbd "C-x a g") 'helm-do-ag-project-root)


;; thrift-mode
(add-hook 'thrift-mode-hook 'whitespace-mode)
