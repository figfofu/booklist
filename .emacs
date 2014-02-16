;;; -*-Emacs-Lisp-*-
;;; デバッグ時は以下をコメントアウト
;;; (setq debug-on-error t)

;;;; X-Window 版の場合
(cond ((eq window-system 'x)
        ;DEL キーの設定
       (define-key function-key-map [delete] [8])
       (put 'delete 'ascii-character 8)
      ;(menu-bar-mode 0)  ;メニューバーを消す
       (scroll-bar-mode -1)  ;スクロールバーを消す
       (load "hilit19")  ;face を利用
       ))

;;; DEL と BS を入れ換える
;(load "term/keyswap")

;; for c-mode
(defun my-c-mode-common-hook ()
  (c-set-style "stroustrup"))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
(setq c-indent-level 4)
(setq indent-tabs-mode nil)
(setq next-line-add-newlines nil)

;;; set key [お好きなように]
(global-set-key "\C-x\C-j" 'goto-line)
;(global-set-key "\M-/" 'auto-fill-mode)
(global-set-key "\M-r" 'redraw-display)
(global-set-key "\C-x\C-[" 'repeat-complex-command)

;;; 漢字コードの設定
(set-language-environment "Japanese")
;(setq default-buffer-file-coding-system 'iso-2022-jp)
;(set-terminal-coding-system 'iso-2022-jp)
;(set-terminal-coding-system 'euc-jp)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq buffer-file-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;;; Tweak UTF-8 CJK
(utf-translate-cjk-set-unicode-range
 '((#x00a2 . #x00a3)
   (#x00a7 . #x00a8)
   (#x00ac . #x00ac)
   (#x00b0 . #x00b1)
   (#x00b4 . #x00b4)
   (#x00b6 . #x00b6)
   (#x00d7 . #x00d7)
   (#X00f7 . #x00f7)
   (#x0370 . #x03ff)                    ; Greek and Coptic
   (#x0400 . #x04FF)                    ; Cyrillic
   (#x2000 . #x206F)                    ; General Punctuation
   (#x2100 . #x214F)                    ; Letterlike Symbols
   (#x2190 . #x21FF)                    ; Arrows
   (#x2200 . #x22FF)                    ; Mathematical Operators
   (#x2300 . #x23FF)                    ; Miscellaneous Technical
   (#x2500 . #x257F)                    ; Box Drawing
   (#x25A0 . #x25FF)                    ; Geometric Shapes
   (#x2600 . #x26FF)                    ; Miscellaneous Symbols
   (#x2e80 . #xd7a3) (#xff00 . #xffef)))

;; GIT
; contrib/emacs/{git.el,git-blame.el,vc-git.el} をパスの通ったところにコピー
(require 'git) 
; ログを UTF-8 にして，git に渡す
(add-to-list 'process-coding-system-alist '("git" . utf-8))

;;
;; for MH-E
;;
;(setq mh-ins-buf-prefix "> ")
;(setq mh-progs "/usr/local/bin/")
;(setq mh-lib "/usr/local/lib/mh/")
;(setq mhl-formfile "mhl.noconv")
;
;(load "mime-setup")

;; For MEW (test)
(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)
(setq mew-mail-domain-list '("kasahara.cs.waseda.ac.jp"))
(setq mew-mailbox-type 'mbox)
(setq mew-mbox-command "incm")
(setq mew-mbox-command-arg "-d /var/mail/binh:x:1721:1500:Bui")
(setq mew-demo nil)
(setq mew-draft-mode-hook
      (function
       (lambda ()
         (auto-fill-mode 1)
         (set-fill-column 60))))

;;
;; for Egg
;;
;;; 環境変数 JSERVER が設定されていない場合、oscar120 を server にする
(or (getenv "JSERVER")
    (setq jserver-host-name "razzie04"))
(setq wnn-usr-dic-dir (concat "!" (expand-file-name "~/Wnn6")))


;;
;; フェンスモードのキーバインドの例
;;
;(let (hanchar ch)
;  (setq hanchar
;	'("!" "#" "$" "%" "&" "'" "(" ")" "*" "+" "/"
;	  "0" "1" "2" "3" "4" "5" "6" "7" "8" "9"
;	  ":" ";" "<" "=" ">" "?" "@"))
;  (while (setq ch (car hanchar))
;    (its-defrule ch ch nil nil "roma-kana")
;    (setq hanchar (cdr hanchar))))
(setq use-kuten-for-period nil)
(setq use-touten-for-comma nil)
(setq enable-double-n-syntax t)



;;
;; for text-mode
;;
;; text-mode では、自動的に auto-fill-mode にする
;(setq text-mode-hook
;      '(lambda ()
;	 (auto-fill-mode 1)))
;; auto-fill-mode では、各行を 70 文字以内に詰める
(set-default 'fill-column 60)

(defvar aix
  (equal system-type 'aix))

(cond
  (aix
   (set-language-environment "Japanese")
   (setq load-path
   (cons "/usr/local/share/emacs/site-lisp/anthy/" load-path))
   (load-file "/usr/local/share/emacs/site-lisp/anthy/leim-list.el")
   (load-library "anthy")
   (setq default-input-method "japanese-anthy")
  )
)

(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)
(setq wl-prefetch-confirm nil)
(put 'upcase-region 'disabled nil)
