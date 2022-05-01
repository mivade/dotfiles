;; IDE-like functionality that is not language-specific lives here

(use-package better-defaults)

;; Autocompletion: https://company-mode.github.io/
(use-package company)
(add-hook 'after-init-hook 'global-company-mode)

;; Syntax checking
(use-package flycheck)

;; Always use ido-mode
;; See https://masteringemacs.org/article/introduction-to-ido-mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(use-package ido-hacks)
(use-package helm)
