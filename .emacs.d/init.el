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

;; Enable UTF-8
(if (not (eq window-system 'x))
    (progn
      (set-keyboard-coding-system 'utf-8)))

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
  (c-set-offset 'innamespace 0)
  (c-set-offset 'substatement-open 0)
  (setq c-basic-offset 4))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
(defun my-c++-mode-hook ()
  (setq flycheck-gcc-language-standard "c++14")
  (setq flycheck-clang-language-standard "c++14"))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)

;; Python
;; (setq skeleton-pair nil) ; don't auto-add parentheses
(autoload 'python-mode "python-mode" "Python Mode" t)
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
(autoload 'web-mode "web-mode" "Web mode" t)
(add-to-list 'auto-mode-alist '("\\.json\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-jsx-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-jsx-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-hook 'web-mode-hook (lambda ()
  ;;(setq web-mode-engines-alist '(("django" . "\\.html")))
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 2))
  ;; FIXME
  ;;(add-to-list 'web-mode-engine-file-regexps '("django" . "\\.html"))
)
(add-hook 'js2-mode-hook (lambda ()
  (electric-indent-local-mode 1)
  (setq js2-basic-offset 2)))

;; Markdown
(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Arduino mode
(autoload 'arduino-mode "arduino-mode" "Arduino mode" t)
(add-to-list 'auto-mode-alist '("\\.ino\\'" . arduino-mode))

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
