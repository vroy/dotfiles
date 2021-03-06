(require 'rhtml-mode)
(require 'yaml-mode)
(require 'scss-mode)
(require 'sass-mode)
(require 'nginx-mode)

;; Auto setup of modes based on extensions
(add-to-list 'auto-mode-alist '("\\.xhtml$" . rhtml-mode) )
(add-to-list 'auto-mode-alist '("\\.html$" . rhtml-mode) )
(add-to-list 'auto-mode-alist '("\\.eco$" . rhtml-mode) )
(add-to-list 'auto-mode-alist '("\\.ejs$" . rhtml-mode) )
(add-to-list 'auto-mode-alist '("\\.erb$" . rhtml-mode) )
(add-to-list 'auto-mode-alist '("\\.html\\.erb$" . rhtml-mode) )

(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode) )

(add-to-list 'auto-mode-alist '("\\.yml\\.?" . yaml-mode) )

(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode) )
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode) )
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode) )
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode) )
(add-to-list 'auto-mode-alist '("\\.thor$" . ruby-mode) )
(add-to-list 'auto-mode-alist '("\\.rabl$" . ruby-mode) )

(add-to-list 'auto-mode-alist '("\/\\.env" . sh-mode) )

(add-to-list 'auto-mode-alist '("/etc/nginx/sites-available/.*" . nginx-mode))

(add-to-list 'auto-mode-alist '("Jenkinsfile$" . groovy-mode) )

(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG$" . diff-mode))
(add-to-list 'auto-mode-alist '("\\.patch$" . diff-mode))
(add-to-list 'auto-mode-alist '("\\.diff$" . diff-mode))

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(add-to-list 'auto-mode-alist '("\\.ino$" . arduino-mode))
