;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Additional functions/macros to configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq user-full-name "Benoit Cortier"
      user-mail-address "benoit.cortier@fried-world.eu")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font "Source Code Pro-12")

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function.
(setq doom-theme 'doom-gruvbox)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; includes `_' in emacs word definition
(modify-syntax-entry ?_ "w")

;; misc editor configs
(setq display-line-numbers-type nil
      scroll-margin 3)

;; vim-like bépo mapping for tetris

(map! :map tetris-mode-map
      "t" #'tetris-move-left
      "r" #'tetris-move-right
      "s" #'tetris-move-bottom
      "v" #'tetris-rotate-prev
      "l" #'tetris-rotate-next)

;;;; doom core packages

;;; whitespace

(setq whitespace-line-column 120
      whitespace-style '(face trailing lines-tail empty spaces tabs space-before-tab::tab space-mark tab-mark))

;; enable visualization globally
(global-whitespace-toggle-options '())

;;;; modules

;;; :editor evil

(defun +custom-evil-mc-make-all-cursors-in-paragraph ()
  "Create cursor for all symbols in the current paragraph. See also `:mc/REGEXP' (doom nicety)."
  (interactive)
  (save-restriction
    (cl-destructuring-bind (beg end . _)
        (evil-select-paren "^$" "^$" nil nil 'line 1 t)
      (narrow-to-region beg end)
      (evil-mc-make-all-cursors))))

(map! :after evil-magit
      :map magit-mode-map
      :vnmo "C-j" #'evil-magit-toggle-text-mode
      :vnmo "C-t" (cmd! (evil-next-line 20)))

(map! ;; TODO: nice keys to use later
      :vnmo "k" nil
      :vnmo "K" nil

      ;; movements
      :vnmo "L" #'evil-avy-goto-char-2
      :vnmo "C-t" (cmd! (evil-next-line 20))
      :vnmo "C-s" (cmd! (evil-previous-line 20))
      :vnm "M-n" #'better-jumper-jump-backward
      :vnm "M-N" #'better-jumper-jump-forward

      ;; shell
      :vnmo "!" #'evil-end-of-line
      :vnmo "|" #'evil-shell-command

      ;; cursors
      :vn "+" #'evil-mc-make-and-goto-next-cursor
      :vn "M-+" #'evil-mc-make-cursor-move-next-line
      :vn "-" #'evil-mc-make-and-goto-prev-cursor
      :vn "M--" #'evil-mc-make-cursor-move-prev-line
      :vn "gza" #'+custom-evil-mc-make-all-cursors-in-paragraph

      ;; windows
      :vn "W" #'evil-window-next
      (:prefix "w"
       :vn "+" #'evil-window-increase-height
       :vn "-" #'evil-window-decrease-height
       :vn "=" #'balance-windows
       :vn "»" #'evil-window-increase-width
       :vn "«" #'evil-window-decrease-width
       :vn "|" #'evil-window-set-width
       :vn "_" #'evil-window-set-height
       :vn "w" #'evil-window-next
       :vn "W" #'evil-window-prev
       :vn "t" #'evil-window-down
       :vn "T" #'+evil/window-move-down
       :vn "s" #'evil-window-up
       :vn "S" #'+evil/window-move-up
       :vn "c" #'evil-window-left
       :vn "C" #'+evil/window-move-left
       :vn "r" #'evil-window-right
       :vn "R" #'+evil/window-move-right
       :vn "v" #'evil-window-vsplit
       :vn "h" #'evil-window-split
       :vn "q" #'evil-quit
       :vn "d" #'evil-window-delete
       :vn "m" #'doom/window-maximize-buffer))

;; evil-escape
(setq evil-escape-key-sequence ",,"
      evil-escape-delay 0.2)

;; Switch to the new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)

(after! evil-snipe
  (evil-snipe-mode +1)
  (evil-snipe-override-mode +1)
  (setq evil-snipe-scope 'line)
  (setq evil-snipe-repeat-scope 'whole-line)
  (setq evil-snipe-spillover-scope nil))

;;; :editor undo

(map! :after undo-fu
      :n "U" #'undo-fu-only-redo)

;;; :completion company

;; opt for manual completion.
(setq company-idle-delay nil)

;;; :completion ivy

(setq ivy-sort-max-size 10000) ;; original value was `30000'

;;; :tools magit

(setq magit-repository-directories '(("~/Dev" . 1)))

;;; :tools lsp

(setq rustic-lsp-server 'rust-analyzer
      lsp-rust-server 'rust-analyzer
      lsp-ui-peek-fontify 'always)

;;; :ui doom-dashboard

(setq fancy-splash-image (concat doom-private-dir "misc/splash-deus-ex.png"))
