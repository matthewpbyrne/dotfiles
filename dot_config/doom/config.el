;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; (setq org-directory "~/org/")

(setq org-directory "~/tmp/scratchpad-20241119/gtd-explorations/single-file/")


(setq org-agenda-files (directory-files-recursively
                         ;; "~/tmp/scratchpad-20241119/gtd-explorations/multi-file/
                         "~/tmp/scratchpad-20241119/gtd-explorations/single-file/"
                         "\\.org$"))

(setq org-agenda-custom-commands
      '(("y" "Completed Yesterday"
         agenda ""
         ((org-agenda-span 4)
          (org-agenda-start-day "-1d")
          (org-agenda-entry-types '(:closed))))))

;; (after! org-agenda
;;   (map! :map org-agenda-mode-map
;;         :n "v d" #'org-agenda-day-view
;;         :n "v w" #'org-agenda-week-view
;;         :n "v m" #'org-agenda-month-view))

(setq initial-frame-alist
      '((top . 10)    ;; Y position
        (left . 5)   ;; X position
        (width . 120) ;; Width in characters
        (height . 80))) ;; Height in lines

;; Org Agenda Evil State Management
(defvar org-agenda-evil-state 'emacs
  "The current evil state for org-agenda buffers globally.")

;; (defun org-agenda-toggle-evil-state ()
;;   "Toggle between `evil-normal-state` and `evil-emacs-state` in the current Org Agenda buffer."
;;   (interactive)
;;   (if (evil-normal-state-p)
;;       (progn
;;         (setq org-agenda-evil-state 'emacs)
;;         (evil-emacs-state))
;;     (progn
;;       (setq org-agenda-evil-state 'normal)
;;       (evil-normal-state)))
;;   (message "Evil state toggled to: %s" org-agenda-evil-state))

(defun org-agenda-set-initial-evil-state ()
  "Set the initial evil state for the Org Agenda buffer based on the global state."
  ;; (evil-set-initial-state 'org-agenda-mode org-agenda-evil-state)
  (evil-change-state org-agenda-evil-state)
  (message "Org-agenda loaded with state: %s" org-agenda-evil-state))

;; (after! org-agenda
;;   (map! :map org-agenda-mode-map
;;         "C-c t" #'org-agenda-toggle-evil-state))

(add-hook 'org-agenda-mode-hook #'org-agenda-set-initial-evil-state)


;; ;; Org Agenda Evil State Management
;; (defvar org-agenda-evil-keymap evil-motion-state-map
;;   "The current Evil keymap for org-agenda buffers.")

;; (defun org-agenda-toggle-evil-state ()
;;   "Toggle between `evil-normal-state-map` and `evil-emacs-state-map` for Org Agenda buffers."
;;   (interactive)
;;   (if (eq org-agenda-evil-keymap evil-normal-state-map)
;;       (progn
;;         (setq org-agenda-evil-keymap evil-emacs-state-map)
;;         (evil-emacs-state))
;;     (progn
;;       (setq org-agenda-evil-keymap evil-normal-state-map)
;;       (evil-normal-state)))
;;   (message "Evil keymap toggled to: %s" org-agenda-evil-keymap))

;; (defun org-agenda-set-initial-evil-keymap ()
;;   "Set the initial Evil keymap for Org Agenda buffers."
;;   (evil-set-initial-state 'org-agenda-mode
;;                           (if (eq org-agenda-evil-keymap evil-normal-state-map)
;;                               'normal
;;                             'emacs))
;;   (message "Org-agenda loaded with keymap: %s" org-agenda-evil-keymap))

;; (after! org-agenda
;;   (map! :map org-agenda-mode-map
;;         "C-c t" #'org-agenda-toggle-evil-state))

;; (add-hook 'org-agenda-mode-hook #'org-agenda-set-initial-evil-keymap)

;; ;; Org Agenda Evil State Management
;; (defvar org-agenda-evil-state 'emacs
;;   "The current evil state for org-agenda buffers globally.")

;; (defun org-agenda-refresh-keybindings ()
;;   "Refresh keybindings for org-agenda-mode by syncing with Evil's current state."
;;   (set-keymap-parent org-agenda-mode-map
;;                      (cond ((eq org-agenda-evil-state 'normal) evil-normal-state-map)
;;                            ((eq org-agenda-evil-state 'emacs) evil-emacs-state-map)
;;                            (t evil-motion-state-map))))

;; (defun org-agenda-toggle-evil-state ()
;;   "Toggle between `evil-normal-state` and `evil-emacs-state` in the current Org Agenda buffer."
;;   (interactive)
;;   (if (evil-normal-state-p)
;;       (progn
;;         (setq org-agenda-evil-state 'emacs)
;;         (evil-emacs-state))
;;     (progn
;;       (setq org-agenda-evil-state 'normal)
;;       (evil-normal-state)))
;;   (org-agenda-refresh-keybindings) ;; Sync keybindings with the new state
;;   (message "Evil state toggled to: %s" org-agenda-evil-state))

;; (defun org-agenda-set-initial-evil-state ()
;;   "Set the initial evil state for the Org Agenda buffer based on the global state."
;;   (evil-set-initial-state 'org-agenda-mode org-agenda-evil-state)
;;   (org-agenda-refresh-keybindings) ;; Sync keybindings during mode initialization
;;   (message "Org-agenda loaded with state: %s" org-agenda-evil-state))

;; (after! org-agenda
;;   (map! :map org-agenda-mode-map
;;         "C-c t" #'org-agenda-toggle-evil-state))

;; (add-hook 'org-agenda-mode-hook #'org-agenda-set-initial-evil-state)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
