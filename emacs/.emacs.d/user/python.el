;(setq skeleton-pair nil) ; don't auto-add parentheses
(autoload 'python-mode "python-mode" "Python Mode" t)
(add-hook 'rst-mode-hook (lambda() (electric-indent-local-mode -1)))
