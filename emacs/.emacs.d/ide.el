;; IDE-like functionality that is not language-specific lives here

(global-display-line-numbers-mode)

(use-package better-defaults)
(use-package xclip
  :config
  (xclip-mode 1)
)

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

;; File explorer
(use-package treemacs
  :bind
  ("C-c t" . treemacs))

;; Use editorconfig to control indentation, whitespace, etc.
(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1)
)

;; Language server
(use-package lsp-mode
  :ensure t
)

;; Project management
(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("s-p" . projectile-command-map)
              ("C-c p" . projectile-command-map)))

;; Tree-sitter
(use-package tree-sitter
  :config
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))
(use-package tree-sitter-langs)
