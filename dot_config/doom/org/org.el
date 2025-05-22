;;; org/org.el -*- lexical-binding: t; -*-

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/"
      org-enforce-todo-checkbox-dependencies t
      org-log-done 'time)

(after! org
  (require 'org-depend))

(use-package! org-ql
  :after org)

(load! "agenda.el")
