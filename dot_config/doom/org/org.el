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
  ;; (require 'org-roam-ql-dblock)

  (use-package! org-ql :after org)
  (use-package! org-roam-ql
    :after org-roam
    :config
    (org-roam-ql-mode))
  (use-package! org-super-agenda
    :after org-agenda
    :config
    (org-super-agenda-mode))
  (use-package! org-transclusion
    :after org
    :hook (org-mode . org-transclusion-mode))

  (use-package! org-journal
    :config
    (setq org-journal-date-format "%A, %d %B %Y"
          org-journal-dir "~/org/myjournal2/"
          org-journal-file-type 'weekly)
    ;; :custom
    ;; (org-journal-dir "~/org/myjournal/")  ;; set your journal directory TODO
    ;; (org-journal-file-type 'daily)        ;; daily journal files
    ;; (org-journal-date-prefix "#+TITLE: ") ;; optional, for org titles
    ;; :bind
    ;; ("C-c j" . org-journal-new-entry))    ;; keybinding to create new journal entry
    )

  ;; (add-to-list 'org-dynamic-block-alist '("test-block" . org-dblock-write:test-block))
  (add-to-list 'org-dynamic-block-alist '("org-ql" . org-dblock-write:org-ql))

  (load! "capture-templates.el")
  ;; Load agenda customizations (deferred until Org is ready)
  ;; (load! "agenda.el" (doom-path "~/.doom.d/org/")))
  (load! "agenda.el"))
