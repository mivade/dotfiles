;; -*- emacs-lisp -*-

;; Syntax highlighting.
(global-font-lock-mode t)
;(set-face-foreground 'font-lock-comment-face "red")

;; Hopefully never insert tab characters
(setq-default indent-tabs-mode nil)

;; Transient mark mode (highlight marked text)
(transient-mark-mode t)

;; Enable UTF-8
(if (not (eq window-system 'x))
    (progn
      (set-keyboard-coding-system 'utf-8)))

;; Status line settings
(setq display-time-24hr-format t)
(display-time)
(column-number-mode t)

;; Mouse support.
(xterm-mouse-mode t)
(mouse-wheel-mode t)

;; Emacs package management
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t))

;; Fill column
(setq-default fill-column 80)
(require 'fill-column-indicator)
(setq fci-rule-width 1)
;;(setq fci-rule-color "gridColor")
(define-globalized-minor-mode my-global-fci-mode fci-mode turn-on-fci-mode)
(my-global-fci-mode 1)

;; ido-mode
(require 'ido)
(ido-mode t)

;; Autocompletion
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)
(dumb-jump-mode)

;; General text settings
(add-hook 'after-init-hook 'global-flycheck-mode)
(add-hook 'text-mode-hook 'auto-fill-mode)
(add-hook 'text-mode-hook 'flyspell-mode)
(setq ispell-program-name "aspell")
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; ediff
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; Tree view
(require 'neotree)
;(require 'all-the-icons)
;(setq neo-theme (if (display-graphic-p) 'icons))
(global-set-key [f8] 'neotree-toggle)

;; org-mode
(setq org-log-done t)  ; capture timestamp when a task is set to DONE

;; LaTeX
(autoload 'latex-mode "latex-mode" "AUCTeX" t)
(add-to-list 'auto-mode-alist '("\\.tex\\'" . latex-mode))
(add-hook 'LaTeX-mode-hook
	  (lambda nil (set-face-foreground 'font-latex-sedate-face "green")))
(add-hook 'LaTeX-mode-hook 'latex-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex
          (setq reftex-plug-into-AUCTeX t))
(eval-after-load "tex"
  '(add-to-list 'TeX-command-list '("Make" "make" TeX-run-command nil t)))

;; C/C++
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(defun my-c-mode-common-hook ()
  (c-set-style "stroustrup")
  (c-set-offset 'innamespace 0))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
(defun my-c++-mode-hook ()
  (setq flycheck-gcc-language-standard "c++11")
  (setq flycheck-clang-language-standard "c++11")
  (setq c-bassic-offset 4))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)

;; Python
;; (setq skeleton-pair nil) ; don't auto-add parentheses
(require 'python-mode)
(add-hook 'rst-mode-hook (lambda() (electric-indent-local-mode -1)))

;; Window navigation
;; See http://www.emacswiki.org/emacs/WindMove
;;
;; This is moved below the Python stuff because epy overrides the
;; default keybindings.
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings 'meta))

;; Web modes
(remove-hook 'html-mode-hook 'turn-on-auto-fill)
(require 'web-mode nil 'noerror)
(add-to-list 'auto-mode-alist '("\\.json\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-jsx-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-jsx-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'web-mode-engine-file-regexps '("django" . "\\.html"))
(add-hook 'web-mode-hook (lambda ()
  ;;(setq web-mode-engines-alist '(("django" . "\\.html")))
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 2)))
(add-hook 'js2-mode-hook (lambda ()
  (electric-indent-local-mode 1)
  (setq js2-basic-offset 2)))

;; Markdown
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Arduino mode
(require 'arduino-mode nil 'noerror)

;; Shortcut for commenting/uncommenting
;; Taken from https://stackoverflow.com/questions/9688748/emacs-comment-uncomment-current-line#9697222
(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)))
(global-set-key (kbd "C-/") 'comment-or-uncomment-region)

;; Windows-specific configuration
(if (eq system-type 'windows-nt)
  (progn
    (set-default-font "Consolas-9")
    (setq visible-bell 1)
    (setenv "PATH"
      (concat
       "C:/Program Files/Git/usr/bin" ";"
       (getenv "PATH")))))

;; Set default fonts depending on the platform
;;(if (not (eq window-system nil))
;;  (if (eq system-type 'windows-nt)
;;    (set-default-font "Consolas-9")))

;; Stuff set with customize menus
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(ansi-term-color-vector
   [unspecified "#151718" "#CE4045" "#9FCA56" "#DCCD69" "#55B5DB" "#A074C4" "#55B5DB" "#D4D7D6"])
 '(column-number-mode t)
 '(cursor-type (quote bar))
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "b571f92c9bfaf4a28cb64ae4b4cdbda95241cd62cf07d942be44dc8f46c491f4" "18a33cdb764e4baf99b23dcd5abdbf1249670d412c6d3a8092ae1a7b211613d5" "bffa9e9d8c1af5456a2a66957c5efe7dac080b5deca30ece7d41b96e966d3651" "94ba29363bfb7e06105f68d72b268f85981f7fba2ddef89331660033101eb5e5" "b93ce589c81df2a0cf7e07d2b84d298105ce0ea189166239915530113d9c07aa" default)))
 '(display-time-mode t)
 '(font-use-system-font t)
 '(inhibit-startup-screen t)
 '(js2-basic-offset 2)
 '(notmuch-search-line-faces
   (quote
    (("unread" :foreground "#aeee00")
     ("flagged" :foreground "#0a9dff")
     ("deleted" :foreground "#ff2c4b" :bold t))))
 '(package-selected-packages
   (quote
    (neotree markdown-mode fill-column-indicator spacemacs-theme magit zerodark-theme yaml-mode web-mode seti-theme rust-mode qml-mode python-mode powerline molokai-theme kivy-mode js2-mode jdee flycheck firecode-theme badwolf-theme auto-complete arduino-mode)))
 '(python-indent-guess-indent-offset nil)
 '(safe-local-variable-values
   (quote
    ((TeX-command-default . Make)
     (TeX-master . t)
     (TeX-engine . xetex)
     (TeX-PDF-mode . t))))
 '(show-paren-mode t)
 '(web-mode-jsx-expression-padding 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
