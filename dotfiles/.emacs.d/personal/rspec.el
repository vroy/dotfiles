;;;; rspec-mode settings

;; Some custom binding for rspec-mode. Note that the resulting
;; command are "C-i" as per the translation at the end.
;;
;; See also:
;;
;;     http://barelyenough.org/projects/rspec-mode/
;;     https://github.com/pezra/rspec-mode/
;;


;; Auto scroll compilation output
(setq compilation-scroll-output nil)

(defun rspec-toggle-fail-fast-mode ()
  (interactive)
  (if (string-equal "rspec" rspec-spec-command)
      (setq rspec-spec-command "rspec --fail-fast")
    (setq rspec-spec-command "rspec")
    )
  (message rspec-spec-command))
