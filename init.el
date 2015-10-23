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


(global-set-key (kbd "C-x v") (lambda ()
                                (interactive)
                                (split-window-right)
                                (other-window 1)))

(global-set-key (kbd "C-x s") (lambda ()
                                (interactive)
                                (split-window-below)
                                (other-window 1)))

;; ido mode
(ido-mode)



;; paren
(show-paren-mode t)


;; electric-pair-mode
(electric-pair-mode t)


;;
;(desktop-save-mode t)


;; http://apple.stackexchange.com/questions/85222/configure-emacs-to-cut-and-copy-text-to-mac-os-x-clipboard
(defun pbcopy ()
  (interactive)
  (call-process-region (point) (mark) "pbcopy")
  (setq deactivate-mark t))
(global-set-key (kbd "C-[ c") 'pbcopy)


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

;; python-compile  https://www.cs.unc.edu/~gb/blog/2008/03/15/running-python-from-within-emacs/
(defun python-compile ()
  "Use compile to run python programs"
  (interactive)
  (compile (concat (getenv "VIRTUAL_ENV") "/bin/" "python " (buffer-name))))

(defun my-python-mode-hook ()
  (hs-minor-mode)
  (define-key hs-minor-mode-map (kbd "C-c h") 'hs-hide-all)
  (define-key hs-minor-mode-map (kbd "C-c s") 'hs-show-all)
  (define-key hs-minor-mode-map (kbd "C-[ [ -") 'hs-hide-block)
  (define-key hs-minor-mode-map (kbd "C-[ [ +") 'hs-show-block)
  (define-key python-mode-map (kbd "C-c C-c") 'python-compile))

(add-hook 'python-mode-hook 'my-python-mode-hook)



;; php
(defun php-compile ()
  "Use compile to run php programs"
  (interactive)
  (compile (concat "php " (buffer-name))))

(add-hook 'php-mode-hook (lambda ()
                           (define-key php-mode-map (kbd "C-c C-c") 'php-compile)))



;; golang
;; https://coderwall.com/p/kpp6ta/nice-emacs-go-mode-indenting-and-autoformat
(add-hook 'go-mode-hook (lambda ()
                          (add-hook 'before-save-hook 'gofmt-before-save)
                          (auto-complete-mode)
                          (flycheck-mode)
                          (setq tab-width 4)
                          (setq indent-tabs-mode t)
                          (local-set-key (kbd "C-[ [ ,") 'godef-jump)
                          (local-set-key (kbd "C-[ [ .") 'godef-jump-back)
                          ))

;; https://godoc.org/golang.org/x/tools/cmd/goimports
(setq gofmt-command "goimports")


;; ;; http://txt.arboreus.com/2013/02/21/jedi.el-jump-to-definition-and-back.html
;; (add-hook 'python-mode-hook
;;           '(lambda()
;;              (local-set-key (kbd "C-[ [ ,") 'jedi:goto-definition)
;;              (local-set-key (kbd "C-[ [ .") 'jedi:goto-definition-pop-marker)
;;              (local-set-key (kbd "C-x p") 'pylint)))

(defun go-compile ()
  "Use compile to run go programs"
  (interactive)
  (compile (concat "go run " (buffer-name))))
(add-hook 'go-mode-hook (lambda ()
                          (define-key go-mode-map (kbd "C-c C-c") 'go-compile)))

;; for gdb           https://lincolnloop.com/blog/introduction-go-debugging-gdb/
(defun go-build ()
  "Use compile to run go programs"
  (interactive)
  (compile (concat "go build -gcflags '-N -l' " (buffer-name))))




;; c/c++
;; irony-mode
;; apt-get install libclang-3.6-dev
;; M-x irony-install-server
(defun my-c-mode-hook()
  (company-mode)
  (irony-mode)
  (flycheck-mode))

(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

;; c 
(setq-default c-basic-offset 4)

;; rtags
;; (rtags-follow-symbol-at-point)

;; gdb
(setq gdb-many-windows t)
(global-set-key (kbd "C-x g") 'gdb)

;; (defadvice gdb-setup-windows (around setup-more-gdb-windows activate)
;;   ad-do-it
;;   (select-window-4)
;;   (split-window-below)
;;   (select-window-4)
;;   (gdb-display-disassembly-buffer)
;;   (select-window-1))
(global-set-key (kbd "C-x r") 'gud-run)
(global-set-key [f8] 'gud-cont)
(global-set-key [f9] 'gud-next)
(global-set-key [f10] 'gud-step)


;; http://stackoverflow.com/questions/3102988/how-to-set-emacs-gdb-so-that-it-shows-recent-command-on-arrow-up
(eval-after-load "gud"
  '(progn
     (define-key gud-mode-map (kbd "C-p") 'comint-previous-input)
     (define-key gud-mode-map (kbd "C-n") 'comint-next-input)))


;; org-mode
(setq org-log-done t)


;; json
(global-set-key (kbd "C-x j s") 'json-pretty-print-buffer)


;; auto-insert-mode             http://www.emacswiki.org/emacs/AutoInsertMode
(auto-insert-mode)  ;;; Adds hook to find-files-hook
(setq auto-insert-directory "~/.emacs.d/templates/") ;;; Or use custom, *NOTE* Trailing slash important
(setq auto-insert-query nil) ;;; If you don't want to be prompted before insertion
(define-auto-insert "\.py" "template.py")


;; DB
; https://truongtx.me/2014/08/23/setup-emacs-as-an-sql-database-client/
(setq sql-connection-alist
      '((mysql-server (sql-product 'mysql)
                      (sql-port 3306)
                      (sql-server "127.0.0.1")
                      (sql-user "test")
                      (sql-password "test")
                      (sql-database "test"))))

(defun mysql-server ()
  (interactive)
  (my-sql-connect 'mysql 'mysql-server))

(defun my-sql-connect (product connection)
  ;; remember to set the sql-product, otherwise, it will fail for the first time
  ;; you call the function
  (setq sql-product product)
    (sql-connect connection))

(global-set-key (kbd "C-x d") 'mysql-server)

(defun sql-send-line ()
  "Send the current line to the SQL process."
  (interactive)
  (sql-send-region (line-beginning-position) (line-end-position)))

(defun my-sql-mode-hook ()
  (define-key sql-mode-map (kbd "C-c C-c") 'sql-send-line))

(add-hook 'sql-mode-hook 'my-sql-mode-hook)


;;
(global-set-key (kbd "C-u") 'upcase-word)


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
(global-set-key (kbd "C-c g f") 'magit-current-file-log)
(global-set-key (kbd "C-c g d u") 'magit-diff-unstaged)
(global-set-key (kbd "C-c g d s") 'magit-diff-staged)


;; jedi
(add-hook 'python-mode-hook 'jedi:setup)

;; http://txt.arboreus.com/2013/02/21/jedi.el-jump-to-definition-and-back.html
(add-hook 'python-mode-hook
          '(lambda()
             (local-set-key (kbd "C-[ [ ,") 'jedi:goto-definition)
             (local-set-key (kbd "C-[ [ .") 'jedi:goto-definition-pop-marker)
             (local-set-key (kbd "C-x p") 'pylint)))


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
     (define-key helm-gtags-mode-map (kbd "C-[ [ ,") 'rtags-find-symbol-at-point)
     (define-key helm-gtags-mode-map (kbd "C-[ [ .") 'rtags-location-stack-back)
     (define-key helm-gtags-mode-map (kbd "C-[ [ [") 'helm-gtags-find-tag-from-here)
     (define-key helm-gtags-mode-map (kbd "C-[ [ ]") 'helm-gtags-previous-history)))

;; auto-update gtags
(setq helm-gtags-auto-update t)
(setq helm-gtags-update-interval-second nil)


;; rtags


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
(setq fci-rule-character 9608)


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
(global-set-key (kbd "C-x a f") 'helm-ag-this-file)

;; thrift-mode
(add-hook 'thrift-mode-hook 'whitespace-mode)


;; ropemacs
(defun load-ropemacs ()
  "Load pymacs and ropemacs"
  (interactive)
  (add-to-list 'load-path "~/.emacs.d/Pymacs")
  (require 'pymacs)
  (pymacs-load "ropemacs" "rope-")
  ;; Automatically save project python buffers before refactorings
  (setq ropemacs-confirm-saving 'nil)
  (define-key python-mode-map (kbd "C-c r r") 'rope-rename))
;(add-hook 'python-mode-hook 'load-ropemacs)


;; helm-projectile
(global-set-key (kbd "C-x C-f") 'ido-find-file)
(global-set-key (kbd "C-x f") 'helm-projectile-find-file-dwim)
