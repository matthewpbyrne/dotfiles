;;; org/agenda.el -*- lexical-binding: t; -*-

(setq org-agenda-log-mode-items '(state clock closed)
      org-agenda-start-with-log-mode t)

(setq org-agenda-custom-commands
      '(("d" "Dashboard"
         ((agenda ""
                  ((org-agenda-todo-keyword-format "")
                   (org-agenda-skip-function
                    '(org-agenda-skip-entry-if 'todo '("CANCELLED")))
                   (org-deadline-warning-days 14)))
          (todo "WAIT"
                ((org-agenda-todo-keyword-format "")
                 (org-agenda-overriding-header "BLOCKED:")))
          (todo "NEXT"
                ((org-agenda-todo-keyword-format "")
                 (org-agenda-overriding-header "NEXT:")))
          (todo "CANCELLED"
                ((org-agenda-todo-keyword-format "")
                 (org-agenda-overriding-header "CANCELLED:")))))))



