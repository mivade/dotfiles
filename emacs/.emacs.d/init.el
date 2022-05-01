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
(use-package monokai-theme)
(load-theme 'monokai t)

;; Autocompletion: https://company-mode.github.io/
(use-package company)
(add-hook 'after-init-hook 'global-company-mode)

;; Syntax checking
(use-package flycheck)

;; Git
(use-package magit)

;; Editorconfig
(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

;; Markdown
(use-package markdown-mode)

;; Python
;; FIXME: getting errors here (error in process sentinel)
;; See https://realpython.com/emacs-the-best-python-editor/
(use-package elpy)
(elpy-enable)

;; Set by Emacs
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(line-number-mode nil)
 '(package-selected-packages
   '(markdown-mode editorconfig flycheck elpy magit company monokai-theme zenburn-theme zenburn use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
