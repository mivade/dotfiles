;; -*- emacs-lisp -*-

;; References:
;; - https://realpython.com/emacs-the-best-python-editor/

;; PACKAGING
;; ---------

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t))
  (package-initialize)
  (when (not package-archive-contents)
    (package-refresh-contents))

(defvar myPackages
  '(arduino-mode
    auto-complete
    better-defaults
    csv-mode
    dumb-jump
    dracula-theme ; dark theme
    fill-column-indicator
    firecode-theme ; high-contrast dark theme
    flycheck
    graphviz-dot-mode
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

;; LOOK AND FEEL
;; -------------

;; Don't show startup message
(setq inhibit-startup-message t)

;; Set color theme
(global-font-lock-mode t)
(load-theme 'dracula t)

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

;; WINDOWS-SPECIFIC SETTINGS
;; -------------------------

(if (eq system-type 'windows-nt)
  (progn
    (set-default-font "Consolas-9")
    (setq visible-bell 1)
    (setenv "PATH"
      (concat
       "C:/Program Files/Git/usr/bin" ";"
       (getenv "PATH")))))

;; STUFF SET BY EMACS
;; ------------------

(setq custom-file "~/.emacs.d/customize.el")
(when (file-exists-p custom-file) (load custom-file))
