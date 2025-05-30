;;; org/org.el -*- lexical-binding: t; -*-

;; Early org settings (OK to go before `after!`)
(setq org-directory "~/org/"
      org-enforce-todo-checkbox-dependencies t
      org-log-done 'time)

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

  ;; Load agenda customizations (deferred until Org is ready)
  ;; (load! "agenda.el" (doom-path "~/.doom.d/org/")))
  (load! "agenda.el"))
