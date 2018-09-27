;; -*- emacs-lisp -*-

;; References:
;; - https://realpython.com/emacs-the-best-python-editor/

;; TODO
;; - Split some configuration out to other files

;; PACKAGING
;; ---------

(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t))
  (when (not package-archive-contents)
    (package-refresh-contents))

(defvar myPackages
  '(arduino-mode
    auto-complete
    better-defaults
    dumb-jump
    fill-column-indicator
    firecode-theme ; high-contrast dark theme
    flycheck
    jinja2-mode
    js2-mode
    magit
    markdown-mode
    material-theme
    molokai-theme ; monokai-like theme
    neotree ; file tree
    python-mode
    qml-mode
    rust-mode
    spacemacs-theme
    web-mode
    yaml-mode
    zerodark-theme ; medium-contrast dark theme
    ))

(mapc #'(lambda (package)
  (unless (package-installed-p package)
    (package-install package)))
  myPackages)

;; GENERAL SETTINGS
;; ----------------

;; Syntax highlighting.
(global-font-lock-mode t)

;; Transient mark mode (highlight marked text)
(transient-mark-mode t)

;; Status line settings
(column-number-mode t)

;; Mouse support.
(xterm-mouse-mode t)
(mouse-wheel-mode t)

;; Fill column
(setq-default fill-column 80)
(require 'fill-column-indicator)
(setq fci-rule-width 1)
(add-hook 'c-mode-common-hook 'fci-mode)
(add-hook 'python-mode-hook 'fci-mode)
;(setq fci-rule-color "gridColor")
;(define-globalized-minor-mode my-global-fci-mode fci-mode turn-on-fci-mode)
;(my-global-fci-mode 1)

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

;; LANGUAGE-SPECIFIC SETTINGS
;; --------------------------

; see also https://www.emacswiki.org/emacs/LoadingLispFiles for furthersimplifications

(load "~/.emacs.d/user/arduino.el")
(load "~/.emacs.d/user/ccpp.el")
(load "~/.emacs.d/user/latex.el")
(load "~/.emacs.d/user/markdown.el")
(load "~/.emacs.d/user/python.el")
(load "~/.emacs.d/user/web.el")

;; Window navigation
;; See http://www.emacswiki.org/emacs/WindMove
;;
;; This is moved below the Python stuff because epy overrides the
;; default keybindings.
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings 'meta))

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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (zerodark-theme yaml-mode web-mode spacemacs-theme rust-mode qml-mode python-mode neotree molokai-theme material-theme markdown-mode magit js2-mode jinja2-mode flycheck firecode-theme fill-column-indicator dumb-jump better-defaults auto-complete arduino-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
