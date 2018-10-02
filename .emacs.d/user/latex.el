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
