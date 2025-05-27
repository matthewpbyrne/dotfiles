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
                 (org-agenda-overriding-header "CANCELLED:")))))
        ;; ))

        ("Q" "⚡ Org-QL with Super Agenda"
         ((org-ql-block
           '(and (not (done))
                 (todo)
                 (tags "@work" "@home" "@errands"))
           ((org-ql-block-header "⚡ Active Tasks")
            (org-super-agenda-groups
             '((:name "🧠 Work"
                :tag "@work")
               (:name "🏡 Home"
                :tag "@home")
               (:name "🛒 Errands"
                :tag "@errands")
               (:name "Waiting"
                :todo "WAIT")
               (:discard (:tag "someday"))))))))

        ("C" "Compound GTD View !!!"
         ((agenda ""
                  ((org-agenda-span 1)
                   (org-agenda-overriding-header "🕒 Today’s Schedule")))

          (tags-todo "*"
                     ((org-agenda-overriding-header "🏷 Contexts")
                      (org-super-agenda-groups
                       '((:name "Work"    :tag "@work")
                         (:name "Home"    :tag "@home")
                         (:name "Errands" :tag "@errands")
                         (:discard (:tag "ben_button"))))))

          (alltodo ""
                   ((org-agenda-overriding-header "📌 Category grouping")
                    (org-super-agenda-groups
                     '((:name "Inbox"       :category "inbox")
                       (:name "Projects"    :category "projects")
                       (:discard (:category "States"))))))

          (alltodo ""
                   ((org-agenda-overriding-header "📌 Client grouping")
                    (org-super-agenda-groups
                     '((:auto-property "Client")
                       (:discard (:anything))))))

          (alltodo ""
                   ((org-agenda-overriding-header "📌 Task Summary !!!")
                    (org-super-agenda-groups
                     '(
                       (:name "Quick Wins"   :effort< "0:15")
                       (:name "Deep Work"    :effort> "0:30")
                       (:name "Waiting On"   :todo "WAIT")
                       (:name "Next Actions" :todo "NEXT")
                       (:name "Priority H"    :priority>= "B" :todo ("NEXT" "TODO" "IDEA"))
                       (:name "Priority L"    :priority<= "B")
                       (:discard (:tag "someday"))))))))))
