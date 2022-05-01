;; Don't show the splash screen
(setq inhibit-splash-screen t)

;; Configure packaging
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

;; Color theme
;(use-package zenburn-theme)
;(load-theme 'zenburn t)
;(use-package monokai-theme)
;(load-theme 'monokai t)
(use-package firecode-theme)
(load-theme 'firecode t)

;; Load additional functionality from other files
(load "~/.emacs.d/ide.el")
(load "~/.emacs.d/git.el")
(load "~/.emacs.d/editorconfig.el")
(load "~/.emacs.d/markdown.el")
(load "~/.emacs.d/python.el")

;; Set by Emacs
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(line-number-mode nil)
 '(package-selected-packages
   '(firecode-theme markdown-mode editorconfig flycheck elpy magit company monokai-theme zenburn-theme zenburn use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
