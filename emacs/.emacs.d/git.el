;; The best git interface ever
;; https://magit.vc/
(use-package magit
  :ensure t
  :defer t
)

;; highlight changed lines in each buffer
;; https://github.com/dgutov/diff-hl
(use-package diff-hl
  :ensure t
  :init
  (global-diff-hl-mode 1)
  :config
  (diff-hl-flydiff-mode 1)
  :hook ((dired-mode . diff-hl-dired-mode)
         (magit-pre-refresh . diff-hl-magit-pre-refresh)
         (magit-post-refresh . diff-hl-magit-post-refresh)))
