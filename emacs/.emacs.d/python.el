;; Python
;; See https://realpython.com/emacs-the-best-python-editor/
;; Note that if getting strange errors about a process exiting with code 1
;; it's likely because `virtualenv` cannot be found (see output of
;; `M-x elpy-config` to confirm). Just make sure that `virtualenv` is
;; installed (e.g., `conda install -y virtualenv`)
(use-package elpy
  :defer t
  :commands elpy-enable
  :init
  (with-eval-after-load 'python (elpy-enable))
)
