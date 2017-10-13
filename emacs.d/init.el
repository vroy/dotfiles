
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
(load "hooks.el")
(load "snippets.el")
(load "rspec.el")
(load "clojure-cfg.el")
(load "paredit-cfg.el")
(load "golang.el")
(load "python-cfg.el")
;; (load "erlang.el")
