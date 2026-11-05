;; Python

;; https://www.emacswiki.org/emacs?ProgrammingWithPythonModeDotEl
(use-package python-mode
  :init
  (autoload 'python-mode "python-mode" "Python Mode." t)
  (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
  (add-to-list 'interpreter-mode-alist '("python" . python-mode))
)

;; Suppress Python Completions buffer
(add-to-list 'display-buffer-alist
  '("\\*Python Completions\\*"
    (display-buffer-no-window)
    (allow-no-window . t)))
