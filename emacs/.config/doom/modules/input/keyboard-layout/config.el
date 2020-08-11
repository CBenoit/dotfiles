;;; input/keyboard-layout/config.el -*- lexical-binding: t; -*-

(when! (featurep! +bepo)
  ;; This is how bépo layout is supposed to work out of the box, but
  ;; since Emacs ignores compined keys, I redefined the most used ones.
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
        :g "<dead-circumflex> o" "ô"

        :g "<dead-acute> <dead-acute>" "´"
        :g "<dead-acute> a" "á"
        :g "<dead-acute> e" "é"
        :g "<dead-acute> i" "í"
        :g "<dead-acute> u" "ú"
        :g "<dead-acute> o" "ó")

  (when! (featurep! :editor evil)
    (map!
     (:after evil-snipe
      :map evil-snipe-local-mode-map

      (:when evil-snipe-mode
       ;; do not override `s' and `S'
       :vnmo "s" nil
       :vnmo "S" nil
       ;; map these instead
       :vnmo "è" #'evil-snipe-s ; s
       :vnmo "È" #'evil-snipe-S) ; S

      (:when evil-snipe-override-mode
       :vnmo "j" #'evil-snipe-t ; t
       :vnmo "J" #'evil-snipe-T)) ; T

     (:after evil
      ;; direct mapping for dead keys in `visual', `normal', `movement' and `operator' modes

      :vnmo "<dead-grave>" "`"
      :vnmo "<dead-circumflex>" "^"
      :vnmo "<dead-acute>" "´"

      ;; `<>' <-> `«»' rotation

      :vnmo ">" nil
      :vnmo "»" #'evil-shift-right
      :vnmo "<" nil
      :vnmo "«" #'evil-shift-left

      ;; `é' <-> `w' rotation (`b' is on the left on `é' layout-wise)

      :vnmo "é" #'evil-forward-word-begin
      :vnmo "w" nil
      :vnmo "É" #'evil-forward-WORD-begin
      :vnmo "W" nil

      ;; main `hjkl' <-> `ctrn' rotation

      :vnmo "c" #'evil-backward-char ; t
      :vnmo "C" #'evil-window-top ; T
      :vn "h" #'evil-change ; c
      :mo "h" nil
      :vn "H" #'evil-change-line ; C
      :mo "H" nil

      :vnmo "t" #'evil-next-line ; j
      :vn "T" #'evil-join ; J
      :mo "T" nil ; J
      :vnmo "j" #'evil-find-char-to ; t
      :vnmo "J" #'evil-find-char-to-backward ; T

      :vnmo "s" #'evil-previous-line ; k FIXME: overridden by surround(?) in operator mode
      :vnmo "S" #'+lookup/documentation ; K
      :vn "k" #'evil-substitute ; s
      :mo "k" nil
      :vn "K" #'evil-change-whole-line ; S
      :mo "K" nil

      :vnmo "r" #'evil-forward-char ; l
      :vnmo "R" #'evil-window-bottom ; L
      :vn "l" #'evil-replace ; r
      :mo "l" nil
      :vn "L" #'evil-replace-state ; R
      :mo "L" nil)

     (:after evil-magit
      :map magit-mode-map

      ;; `ctrn' mapping

      :vnmo "c" #'evil-backward-char ; t FIXME: commit shortcut
      :vnmo "C" #'evil-window-top ; T FIXME: clone shortcut
      :vnmo "t" #'evil-next-visual-line ; j FIXME: tag shortcut
      :vnmo "s" #'evil-previous-visual-line ; k FIXME: stage shortcut
      :vnmo "r" #'evil-forward-char ; l FIXME: rebase shortcut
      :vnmo "R" #'evil-window-bottom ; L FIXME: rename shortcut
      ))

    (after! evil
      ;; it is more convenient to invert ";" and "," as repeat keys
      ;; TODO: make `evil-snipe' repeat work using these too.
      (setq +evil-repeat-keys (cons "," ";")))))
