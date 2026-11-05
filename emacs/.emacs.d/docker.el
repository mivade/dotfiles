(use-package dockerfile-mode
  :ensure t
  :defer t
  :mode (("Dockerfile\\'" . dockerfile-mode)
         ("\\.Dockerfile\\'" . dockerfile-mode))
)
