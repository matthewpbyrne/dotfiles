;;; org/org.el -*- lexical-binding: t; -*-

;; Early org settings (OK to go before `after!`)
(setq org-directory "~/org/"
      org-enforce-todo-checkbox-dependencies t
      org-log-done 'time)

;; ;; Example custom dynamic block:
;; (defun org-dblock-write:test-block (params)
;;   "Test block that just prints a message and dummy content."
;;   (insert "| Hello | World |\n|-------+--------|\n| This  | Works  |"))

;; Org configuration block
(after! org
  (require 'org-depend)

  (use-package! org-ql :after org)
  (use-package! org-super-agenda
    :after org-agenda
    :config
    (org-super-agenda-mode))
  (use-package! org-transclusion
    :after org
    :hook (org-mode . org-transclusion-mode))

  ;; (add-to-list 'org-dynamic-block-alist '("test-block" . org-dblock-write:test-block))
  (add-to-list 'org-dynamic-block-alist '("org-ql" . org-dblock-write:org-ql))

  (load! "capture-templates.el")
  ;; Load agenda customizations (deferred until Org is ready)
  ;; (load! "agenda.el" (doom-path "~/.doom.d/org/")))
  (load! "agenda.el"))
