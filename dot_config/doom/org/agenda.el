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

        ("p" "Projects"
         (
          ;; ;; without org-ql, lists top-level projects
          ;; (todo "" ((org-agenda-overriding-header "Active Projects")
          ;;           (org-super-agenda-groups
          ;;            '((:name none  ; Disable super group header
          ;;               :children todo)
          ;;              (:discard (:anything t))))))
          (org-ql-block
           '(and
             (or (todo) (done))
             (not  (ancestors (done)))
             (parent (todo)))
           ((org-ql-block-header "Acitve Projects")
            (org-super-agenda-groups
             '((:auto-property "PROJ_NAME")
               (:discard (:anything t))))))
          (org-ql-block
           '(and
             (or (todo) (done))
             (ancestors (todo "DONE"))
             (not (ancestors (todo "CANCELED"))))
           ((org-ql-block-header "Completed Projects")
            (org-super-agenda-groups
             '((:auto-property "PROJ_NAME")
               (:discard (:anything t))))))
          (org-ql-block
           '(and
             (or (todo) (done))
             (ancestors (and (todo "CANCELED") (not (parent (or (todo) (todo "DONE")))))))
           ((org-ql-block-header "Cancelled Projects")
            (org-super-agenda-groups
             '((:auto-property "PROJ_NAME")))))))

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

          (todo "NEXT"
                ((org-agenda-overriding-header "📌 AOF grouping")
                 (org-super-agenda-groups
                  '((:auto-property "AOF" :todo "NEXT")
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

;; custom agenda file management functions

(defvar +org-agenda-files-backup nil
  "Backup of the original `org-agenda-files` before it was overridden.")

(defun +org-agenda-set-to-current-file ()
  "Set `org-agenda-files` to just the current file, backing up the previous value."
  (interactive)
  (when (buffer-file-name)
    (setq +org-agenda-files-backup org-agenda-files)
    (setq org-agenda-files (list (buffer-file-name)))
    (message "org-agenda-files set to current file: %s" (buffer-file-name))))

(defun +org-agenda-restore-backup ()
  "Restore the previous `org-agenda-files` from backup."
  (interactive)
  (if +org-agenda-files-backup
      (progn
        (setq org-agenda-files +org-agenda-files-backup)
        (message "org-agenda-files restored from backup."))
    (message "No backup found for org-agenda-files.")))

(defun +org-agenda-restore-from-custom ()
  "Reset `org-agenda-files` to the value stored in `custom-file`."
  (interactive)
  (when (and custom-file (file-exists-p custom-file))
    (load custom-file)
    (message "org-agenda-files restored: %S" org-agenda-files)
    ;; (message "org-agenda-files restored from custom.el.")
    ))

(map! :leader
      (:prefix ("o a" . "Org Agenda")
       :desc "Set agenda to current file" "c" #'+org-agenda-set-to-current-file
       :desc "Restore agenda from backup" "b" #'+org-agenda-restore-backup
       :desc "Restore agenda from custom.el" "r" #'+org-agenda-restore-from-custom))
