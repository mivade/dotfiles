;; Show startup time
;; https://blog.d46.us/advanced-emacs-startup/
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

;; Tweak garbage collection parameters
;; https://github.com/jschaf/dotfiles/blob/master/emacs/start.el
(setq gc-cons-threshold (* 50 1000 1000))
(setq gc-cons-percentage 0.6)

;; Don't show the splash screen
(setq inhibit-splash-screen t)

;; Enable mouse usage in terminals
(unless (display-graphic-p)
  (xterm-mouse-mode 1)
  (global-set-key (kbd "<mouse-4>") 'scroll-down-line)
  (global-set-key (kbd "<mouse-5>") 'scroll-up-line)
)

;; Configure packaging
;; https://github.com/jwiegley/use-package
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(when (not package-archive-contents)
  (package-refresh-contents))
(require 'use-package)
(setq use-package-always-ensure 't)

;; Load additional functionality from other files
(load "~/.emacs.d/ide.el")
(load "~/.emacs.d/git.el")
(load "~/.emacs.d/markdown.el")
(load "~/.emacs.d/org.el")
(load "~/.emacs.d/python.el")
(load "~/.emacs.d/terraform.el")
(load "~/.emacs.d/themes.el")
(load "~/.emacs.d/web.el")
(load "~/.emacs.d/yaml.el")

;; Set color theme
(load-theme 'firecode t)
