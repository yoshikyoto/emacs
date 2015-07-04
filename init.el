;; How to change key-bind
;; (define-key global-map (kbd "C-x C-y") 'foo)
;; (global-set-key (kbd "C-z") 'undo)

;; 行番号が表示されるが、少し見づらいので切ってある
;; (global-linum-mode t)

;; 色はここが参考になる
;; http://xay-lab.nautilus.xyz/2010/09/emacs.html

;; high-light selected line
;; (global-hl-line-mode t)
;; (custom-set-faces '(hl-line ((t (:background "dark slate gray")))))
;; (setq hl-line-face 'underline) ; 下線


;; 見た目の設定とか
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ディレクトリ閲覧中にファイル編集とかできる wdired モード
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)


;; setting for transient mark mode
;; マークの範囲に色をつける
(setq transient-mark-mode t)

;; デフォルトのタブ幅を4に設定
(setq default-tab-width 4)

;; 矩形選択
(cua-mode t)
(setq cua-enable-cua-keys nil) ; 不要なキーバインドは使わない
;; C-x Space に矩形選択のキーバインドを
(define-key global-map (kbd "C-x SPC") 'cua-set-rectangle-mark)


;; change key-bind C-z for undo, susoend for C-t
(define-key global-map (kbd "C-z") 'undo)
(define-key global-map (kbd "C-t") 'suspend-frame)

;; M-x, M-p で 5行移動できるように設定
(define-key global-map (kbd "M-n") (kbd "C-u 5 C-n"))
(define-key global-map (kbd "M-p") (kbd "C-u 5 C-p"))

;; C-h はもともとヘルプ関係のコマンドだが、これに C-x o の other-window をバインド
(define-key global-map (kbd "C-h") 'other-window)



;; segtting for plugins
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; setting for auto-install
;; (add-to-list 'load-path "~/.emacs.d/auto-install/")
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/auto-install/"))
;; (require 'auto-install)
;; (auto-install-update-emacswiki-package-name t)
;; (auto-install-compatibility-setup)
;; (setq ediff-window-setup-function 'ediff-setup-windows-plain)


;; package.el
;; 
;; download via auto-install
;; M-x auto-install-from-url RET
;; http://repo.or.cz/w/emacs.git/blob_plain/HEAD:/lisp/emacs-lisp/package.el
(require 'package)


;; atuo-complete
(add-to-list 'load-path "~/.emacs.d/popup-el")
(add-to-list 'load-path "~/.emacs.d/auto-complete")
(require 'auto-complete-config)
(ac-config-default)


(add-to-list 'load-path "~/.emacs.d/redo")
(require 'redo+)
(define-key global-map (kbd "C-M-z") 'redo)
(setq undo-no-redo t)
;; 一応redo回数の上限を設定しておかないと、重くなることがある
(setq undo-limit 600000)
(setq undo-strong-limit 900000)


;; term+
(add-to-list 'load-path "~/.emacs.d/term-plus-el")
(require 'term+)


;; タブは使わずにスペースでインデントする
(setq-default indent-tabs-mode nil)

;; yasnippet
;; mysnippents はオリジナルスニペットを保存する場所
(add-to-list 'load-path "~/.emacs.d/yasnippet")
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/mysnippets"
	"~/.emacs.d/plugins/yasnippet/snippets"
	))
;; yasnippetを使う
(yas-global-mode 1)


;; markdown-mode
(add-to-list 'load-path "~/.emacs.d/markdown-mode")
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))



;; scala-mode2
;; https://github.com/hvesalai/scala-mode2
(add-to-list 'load-path "~/.emacs.d/scala-mode2")
(setq scala-indent:use-javadoc-style t)
(require 'scala-mode2)

;; ensime
;; (add-to-list 'load-path "~/.emacs.d/ensime")
;; (require 'ensime)
;; (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)



;; csharp-mode
(add-to-list 'load-path "~/.emacs.d/csharp-mode")
(require 'csharp-mode)
(add-hook 'csharp-mode-hook
		  '(lambda ()
			 (setq indent-tabs-mode nil)
			 (setq c-basic-offset 4)
			 (c-set-offset 'substatement-open 0)
			 (flycheck-mode 1)
			 (omnisharp-mode)))



;; html-mode
(add-to-list 'auto-mode-alist '("\\.scala.html$" . html-mode))

;; web-mode
(add-to-list 'load-path "~/.emacs.d/web-mode")
(require 'web-mode)
;; 拡張子の設定
(add-to-list 'auto-mode-alist '("\\.phtml$"     . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp$"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x$"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb$"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?$"     . web-mode))
;; インデント関係
(defun web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-html-offset   4)
  (setq web-mode-css-offset    4)
  (setq web-mode-script-offset 4)
  (setq web-mode-php-offset    4)
  (setq web-mode-java-offset   4)
  (setq web-mode-asp-offset    4)
  (setq indent-tabs-mode t)
  (setq tab-width 4))
(add-hook 'web-mode-hook 'web-mode-hook)



;; powerline
;; 見た目を変えるだけ
;; https://github.com/jonathanchu/emacs-powerline
(add-to-list 'load-path "~/.emacs.d/emacs-powerline")
(require 'powerline)
(require 'cl) ; common-lisp
(setq powerline-arrow-shape 'curve) ; これで角が変わるけどターミナルだと意味がない？
(setq powerline-color1 "grey22")
(setq powerline-color2 "grey40")

