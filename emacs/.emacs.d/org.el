;; org-mode configuration

;; Structure templates
;; https://orgmode.org/manual/Structure-Templates.html
(require 'org-tempo)

;; Evaluating code blocks
;; https://orgmode.org/worg/org-contrib/babel/languages/index.html#configure
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (C . t)
   (python . t)
   (shell . t)
   (sqlite . t)
  )
)
(setq org-confirm-babel-evaluate nil)
(setq org-todo-keyword-faces
  '(("TODO" . "red")
    ("DOING" . "yellow")
    ("DONE" . "green"))
)
