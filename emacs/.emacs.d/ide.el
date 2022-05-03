;; IDE-like functionality that is not language-specific lives here

(use-package better-defaults)

;; Autocompletion: https://company-mode.github.io/
(use-package company)
(add-hook 'after-init-hook 'global-company-mode)

;; Syntax checking
(use-package flycheck
  :defer t
)

;; Always use ido-mode
;; See https://masteringemacs.org/article/introduction-to-ido-mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(use-package ido-hacks
  :defer t
)
(use-package helm
  :defer t
)

;; Use editorconfig to control indentation, whitespace, etc.
(use-package editorconfig
  :defer t
  :ensure t
  :config
  (editorconfig-mode 1))
