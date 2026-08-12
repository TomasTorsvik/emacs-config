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
(setq doom-font (font-spec :family "Fira Code" :size 14)
      doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)
;;(setq doom-theme 'doom-rouge)
;;(setq doom-theme 'spacemacs-dark)
(setq doom-theme 'modus-vivendi)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/share/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
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

;; Disable exit confirmation
(setq confirm-kill-emacs nil)

;; Enable showing word count in modeline
(setq doom-modeline-enable-word-count t)

;; Add option in magit-log to use decorate without tags
(with-eval-after-load 'magit
  (transient-append-suffix 'magit-log "-D"
    '("=D" "Exclude tags" "--decorate-refs-exclude=refs/tags/*")))

;; Enable ssh authentication
;; (with-eval-after-load 'doom-cli-env
;;   (add-to-list 'doom-env-allow "^SSH_"))

;; Add hook to system ssh agent
;; (keychain-refresh-environment)
;; (require 'exec-path-from-shell)
;; (exec-path-from-shell-copy-env "SSH_AGENT_PID")
;; (exec-path-from-shell-copy-env "SSH_AUTH_SOCK")

;; Make TRAMP recognize customizations from the ~/.ssh/config file
(with-eval-after-load 'tramp
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

;; Add support for NCL files
(setq auto-mode-alist (cons '("\.ncl$" . ncl-mode) auto-mode-alist))
(autoload 'ncl-mode "~/.config/doom/emacs-packages/ncl.el")

;; Enable conda environments from mambaforge
(setenv "WORKON_HOME" "~/miniforge3/envs")
;; (pyvenv-workon "emacs_env")

;; Prevent echo area from covering which-key popup (enable if echo area error returns)
;(defadvice! fix-which-key--show-popup (fn act-popup-dim)
;  :around #'which-key--show-popup
;  (let ((height (car act-popup-dim))
;        (width  (cdr act-popup-dim)))
;    (funcall fn (cons (+ height 1) width))))

;; Add LSP clients
(with-eval-after-load 'eglot
  :config
  (add-hook 'f90-mode-hook 'eglot-ensure)
  (add-hook 'fortran-mode-hook 'eglot-ensure)
  (add-hook 'python-mode-hook 'eglot-ensure)
  (set-eglot-client! 'python-mode '("pylsp")))

;; Include support for aidermacs
(after! aidermacs
  ;;:bind (("C-c a" . aidermacs-transient-menu))
  (map! :map aidermacs-minor-mode-map "C-c a" #'aidermacs-transient-menu)
  :config
  ; Set API_KEY in .bashrc, that will automatically picked up by aider or in elisp
  ;(setenv "ANTHROPIC_API_KEY" "sk-...")
  ; defun my-get-openrouter-api-key yourself elsewhere for security reasons
  ;(setenv "OPENROUTER_API_KEY" (my-get-openrouter-api-key))
  :custom
  ; See the Configuration section below
  (aidermacs-default-chat-mode 'architect)
  (aidermacs-default-model "ollama_chat/mistral"))

;; Include support for ellama
(after! ellama
  ;;:ensure t
  ;;:bind ("C-c e" . ellama)
  (map! :map ellama-command-map "C-c e" #'ellama)
  ;; send last message in chat buffer with C-c C-c
  :hook (org-ctrl-c-ctrl-c-final . ellama-chat-send-last-message)
  :init (setopt ellama-auto-scroll t)
  :config
  ;; show ellama context in header line in all buffers
  (ellama-context-header-line-global-mode +1)
  ;; show ellama session id in header line in all buffers
  (ellama-session-header-line-global-mode +1))

;; Add key bindings (check if compatible before using)
;(map! :leader
;      :desc "vterm" "v" #'vterm
;      (:prefix-map ("l" . "llm")
;       :desc "aidermacs" "a" #'aidermacs-transient-menu
;       :desc "ellama" "e" #'ellama))
