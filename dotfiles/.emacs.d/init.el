
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(let ((default-directory "/usr/local/share/emacs/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

(require 'cask)
(cask-initialize)

(require 'god-mode)

(add-to-list 'load-path "~/.emacs.d/personal/")
(load "configs.el")
(load "theme.el")
(load "functions.el")
(load "search.el")
(load "modes.el")
(load "bindings.el")
(load "snippets.el")
(load "golang.el")
(load "python-cfg.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(plantuml-jar-path "/usr/local/Cellar/plantuml/8053/libexec/plantuml.jar")
 '(standard-indent 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
