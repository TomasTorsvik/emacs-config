;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Tomas Torsvik"
      user-mail-address "tomas.torsvik.work@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
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
(setq doom-font (font-spec :family "Fira Code" :size 14)
      doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;(setq doom-theme 'doom-one)
(setq doom-theme 'modus-vivendi)
;(setq doom-theme 'spacemacs-dark)


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Data/org/")


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

;; Custom global key bindings
(map! :prefix "C-a"
      "C-x" #'clipboard-kill-region
      "C-c" #'clipboard-kill-ring-save
      "C-v" #'clipboard-yank)


;; Switch between windows using meta + arrow keys
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings 'meta))

;; Set both icons and text in toolbar
;;(setq tool-bar-style 'both)
;; Set only icons in toolbar
(setq tool-bar-style 'image)

;; Disable exit cofirmation
(setq confirm-kill-emacs nil)

;; Enable showing word count in modeline.
(setq doom-modeline-enable-word-count t)

;; Add option in magit-log to use decorate without tags
(after! magit
  (transient-append-suffix 'magit-log "-D"
    '("=D" "Exclude tags" "--decorate-refs-exclude=refs/tags/*")))

;; Enable ssh authentication
;; (after! doom-cli-env
;;   (add-to-list 'doom-env-allow "^SSH_"))

;; Make TRAMP recognize customiations from the ~/.ssh/config file
(after! tramp
  :config
  (customize-set-variable 'tramp-use-ssh-controlmaster-options nil))

;; Add file extensions to f90-mode
(setq auto-mode-alist
      (append '(("\\.f90\\'" . f90-mode)
                ("\\.F90\\'" . f90-mode)
                ("\\.f95\\'" . f90-mode)
                ("\\.F95\\'" . f90-mode)
                ("\\.f03\\'" . f90-mode)
                ("\\.F03\\'" . f90-mode)
                ("\\.f08\\'" . f90-mode)
                ("\\.F08\\'" . f90-mode))
              auto-mode-alist))

;; Enable conda environments from mambaforge
(setenv "WORKON_HOME" "/home/tomast/mambaforge/envs")
;; (pyvenv-workon "emacs_env")

;; Add LSP clients
(after! eglot
  :config
  (add-hook 'f90-mode-hook 'eglot-ensure)
  (add-hook 'fortran-mode-hook 'eglot-ensure)
  (set-eglot-client! 'python-mode '("pylsp")))
