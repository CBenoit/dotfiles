;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
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

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
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

(modify-syntax-entry ?_ "w")

(setq default-frame-alist '((font . "Source Code Pro-12")))

(setq fancy-splash-image "~/.config/doom/misc/splash-deus-ex.png")

(setq scroll-margin 3)

(setq rustic-lsp-server 'rust-analyzer
      lsp-rust-server 'rust-analyzer)

(setq +evil-repeat-keys (cons "," ";"))

(setq evil-escape-key-sequence ",,")

(after! evil-snipe
  (evil-snipe-mode +1)
  (evil-snipe-override-mode +1)
  (setq evil-snipe-scope 'visible)
  (setq evil-repeat-keys (cons "n" "N")))

(map! :map evil-snipe-local-mode-map
      :ovnm "s" nil
      :ovnm "S" nil
      :ovnm "j" #'evil-snipe-t
      :ovnm "J" #'evil-snipe-T
      :ovnm "M-j" #'evil-snipe-s
      :ovnm "M-J" #'evil-snipe-S)

(map! :after undo-fu
      :n "U" #'undo-fu-only-redo)

(map! :nv "h" #'evil-change
      :nv "H" #'evil-change-line
      :nv "T" #'evil-join
      :nv "k" #'evil-substitute
      :nv "K" #'evil-change-whole-line
      :nv "l" #'evil-insert-newline-below
      :nv "L" #'evil-insert-newline-above
      :nv "o" #'evil-replace
      :nv "O" #'evil-replace-state ; not really useful for me

      :vnm "M-n" #'better-jumper-jump-backward
      :vnm "M-N" #'better-jumper-jump-forward
      :vnm "C-t" (cmd! (evil-next-line 20))
      :vnm "C-s" (cmd! (evil-previous-line 20))

      :ovnm "c" #'evil-backward-char
      :ovnm "C" #'evil-window-top
      :ovnm "t" #'evil-next-line
      :ovnm "s" #'evil-previous-line
      :ovnm "S" #'+lookup/documentation
      :ovnm "r" #'evil-forward-char
      :ovnm "R" #'evil-window-bottom
      :ovnm "j" #'evil-find-char-to
      :ovnm "J" #'evil-find-char-to-backward)

(map! :g "<dead-grave> <dead-grave>" "`"
      :g "<dead-grave> a" "à"
      :g "<dead-grave> e" "è"
      :g "<dead-grave> i" "ì"
      :g "<dead-grave> u" "ù"
      :g "<dead-grave> o" "ò"
      :g "<dead-circumflex> <dead-circumflex>" "^"
      :g "<dead-circumflex> a" "â"
      :g "<dead-circumflex> e" "ê"
      :g "<dead-circumflex> i" "î"
      :g "<dead-circumflex> u" "û"
      :g "<dead-circumflex> o" "ô")

