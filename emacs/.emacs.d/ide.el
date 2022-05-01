;; IDE-like functionality that is not language-specific lives here

;; Autocompletion: https://company-mode.github.io/
(use-package company)
(add-hook 'after-init-hook 'global-company-mode)

;; Syntax checking
(use-package flycheck)
