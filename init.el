; 
(defalias 'yes-or-no-p 'y-or-n-p)

;; line number
(global-linum-mode t)
(setq linum-format "%3d ")

;; 高亮当前行
(global-hl-line-mode 1)
(set-face-background hl-line-face "color-254")

;; gdb
(setq gdb-many-windows t)
(global-set-key [f6] 'gdb)
(global-set-key [f9] 'gud-next)
(global-set-key [f10] 'gud-step)

(when (>= emacs-major-version 24)
  (require 'package)
    (add-to-list
     'package-archives
     '("melpa" . "http://melpa.org/packages/")
     t)
    (package-initialize))
