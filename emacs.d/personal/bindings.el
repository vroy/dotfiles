;; Fix "C-c C-k" to work for sass-mode
(global-set-key (kbd "C-c C-k") 'comment-or-uncomment-region-or-line)
(define-key (current-global-map) (kbd "C-c C-k") 'comment-or-uncomment-region-or-line)
(define-key coffee-mode-map (kbd "C-c C-k") 'comment-or-uncomment-region-or-line)

;; @todo When opening a new window, ensure that the new window gets focus.
(global-set-key (kbd "C-x |") 'split-window-horizontally)
(global-set-key (kbd "C-x -") 'split-window-vertically)

(global-set-key [(control return)] 'vince-next-line)
(global-set-key (kbd "<s-return>") 'vince-next-line)
(global-set-key (kbd "<s-S-return>") 'zoom-window-zoom)

(global-set-key (kbd "C-S-k") 'vince-backward-kill-line)

(global-set-key (kbd "s-w") 'kill-this-buffer)
(global-set-key (kbd "s-s") 'save-buffer)

(global-set-key [(control tab)] 'other-window)
(global-set-key [(control shift tab)] 'previous-multiframe-window)
(global-set-key [(meta tab)] 'other-window)

(global-set-key (kbd "s-[") 'previous-multiframe-window)
(global-set-key (kbd "s-]") 'other-window)

(global-set-key (kbd "s-k") 'vince-kill-whole-line)

(global-set-key (kbd "C-x g") 'magit-status)

;; projectile
(global-set-key (kbd "s-t") 'projectile-find-file)
(global-set-key (kbd "s-p") 'projectile-switch-project)
(global-set-key (kbd "s-f") 'projectile-ag)

;; guru-mode
(global-set-key (kbd "<up>") 'nil)
(global-set-key (kbd "<left>") 'nil)
(global-set-key (kbd "<right>") 'nil)
(global-set-key (kbd "<down>") 'nil)

;; C-x C-r => prelude style file rename
(global-set-key (kbd "C-x C-r") 'vince-rename-file-and-buffer)

;; C-s C-d => goes to next instance of word under cursor. Use C-s to repeat.
(define-key isearch-mode-map (kbd "C-d") 'isearch-yank-symbol)


(global-set-key (kbd "<escape>") 'god-mode-all)
(define-key god-local-mode-map (kbd "i") 'god-local-mode)
(define-key god-local-mode-map (kbd "z") 'god-local-mode)
(define-key god-local-mode-map (kbd ".") 'repeat)



;; (define-key rspec-mode-map (kbd "s-i s-i") 'rspec-rerun)                  ;; Rerun
;; (define-key rspec-mode-map (kbd "s-i C-f") 'rspec-verify)                 ;; File
;; (define-key rspec-mode-map (kbd "s-i C-a") 'rspec-verify-all)             ;; All
;; (define-key rspec-mode-map (kbd "s-i C-t") 'rspec-toggle-spec-and-target) ;; Toggle
;; (define-key rspec-mode-map (kbd "s-i C-w") 'rspec-toggle-spec-and-target-find-example)
;; (define-key rspec-mode-map (kbd "s-i C-e") 'rspec-verify-single)          ;; Example
;; (define-key rspec-mode-map (kbd "s-i C-m") 'rspec-toggle-fail-fast-mode)  ;; Mode


;; https://www.emacswiki.org/emacs?action=browse;oldid=KeyBindingDiscussion;id=ChoosingKeysToBind
;; @todo figure this out:

(eval-after-load 'js2-mode
  '(define-key js2-mode-map (kbd "s-i C-f") 'mocha-test-file))

(eval-after-load 'js2-mode
  '(define-key js2-mode-map (kbd "s-i C-a") 'mocha-test-project))

(eval-after-load 'js2-mode
  '(define-key js2-mode-map (kbd "s-i C-e") 'mocha-test-at-point))


;; http://stackoverflow.com/a/4513683
(keyboard-translate ?\C-i ?\s-i)
