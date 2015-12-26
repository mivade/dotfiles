;; -*- emacs-lisp -*-

;; Syntax highlighting.
(global-font-lock-mode t)
(set-face-foreground 'font-lock-comment-face "red")

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

;; Delete trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; org-mode
(setq org-log-done t)

;; LaTeX mode settings.
(require 'latex nil 'noerror)
(add-hook 'LaTeX-mode-hook
	  (lambda nil (set-face-foreground 'font-latex-sedate-face "green")))
(add-hook 'LaTeX-mode-hook 'latex-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex
          (setq reftex-plug-into-AUCTeX t))
(eval-after-load "tex"
  '(add-to-list 'TeX-command-list '("Make" "make" TeX-run-command nil t)))
(add-to-list 'auto-mode-alist '("\\.tex\\'" . latex-mode))

;; C++ mode settings.
(defun my-c-mode-common-hook ()
  (c-set-style "stroustrup"))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; General text settings.
(add-hook 'text-mode-hook 'auto-fill-mode)
(add-hook 'text-mode-hook 'flyspell-mode)

;; Spelling settings.
(setq ispell-program-name "aspell")

;; Python settings
(load-file "~/.emacs.d/emacs-for-python/epy-init.el")
(epy-setup-checker "pyflakes %f") ; enable on-the-fly code checking
(epy-setup-ipython)
(setq skeleton-pair nil) ; don't auto-add parentheses
(setq epy-enable-ropemacs nil) ; it takes to long to load for each file...
(add-hook 'python-mode-hook (lambda() (electric-indent-mode -1)))

;; Web modes
(remove-hook 'html-mode-hook 'turn-on-auto-fill)
(require 'web-mode nil 'noerror)
(add-to-list 'auto-mode-alist '("\\.json\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(setq web-mode-engines-alist '(("html" . "\\.djhtml\\'")))
(defun my-web-mode-hook () "Hooks for Web mode."
  (local-set-key (kbd "RET") 'newline-and-indent)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 2))
(add-hook 'web-mode-hook 'my-web-mode-hook)

(eval-after-load 'js2-mode
  '(progn
     (require 'js2-imenu-extras)
     (setq js2-basic-offset 2)
     (add-to-list 'js2-imenu-available-frameworks 'react)
     (add-to-list 'js2-imenu-enabled-frameworks 'react)))

;; Window navigation
;; See http://www.emacswiki.org/emacs/WindMove
;;
;; This is moved below the Python stuff because epy overrides the
;; default keybindings.
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings 'meta))

;; Markdown mode
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Arduino mode
(require 'arduino-mode nil 'noerror)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(column-number-mode t)
 '(custom-enabled-themes (quote (deeper-blue)))
 '(display-time-mode t)
 '(font-use-system-font t)
 '(inhibit-startup-screen t)
 '(python-indent-guess-indent-offset nil)
 '(safe-local-variable-values
   (quote
    ((TeX-command-default . Make)
     (TeX-master . t)
     (TeX-engine . xetex)
     (TeX-PDF-mode . t))))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "unknown" :slant normal :weight normal :height 98 :width normal)))))
