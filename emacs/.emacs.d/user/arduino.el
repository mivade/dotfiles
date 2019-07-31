;; Arduino mode
(autoload 'arduino-mode "arduino-mode" "Arduino mode" t)
(add-to-list 'auto-mode-alist '("\\.ino\\'" . arduino-mode))
