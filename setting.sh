# dafault shellのチェック
echo $SHELL

# 行と列を10x10にする
defaults write com.apple.dock springboard-columns -int 10;defaults write com.apple.dock springboard-rows -int 10;defaults write com.apple.dock ResetLaunchPad -bool TRUE
killall Dock

# .DS_Store を作成しないように
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE
killall Finder

# 隠しファイルを表示
defaults write com.apple.finder AppleShowAllFiles -bool TRUE
killall Finder

# zshの設定ファイルを用意
touch "$HOME/.zprofile"
touch "$HOME/.zshrc"

## brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

## .zshrcの設定
# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zsh_history
# メモリに保存される履歴の件数
export HISTSIZE=1000
# 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000
# 重複を記録しない
setopt hist_ignore_dups
# 開始と終了を記録
setopt EXTENDED_HISTORY
# historyを共有
setopt share_history
# 余分な空白は詰めて記録
setopt hist_reduce_blanks
# historyコマンドは履歴に登録しない
setopt hist_no_store
# 補完時にヒストリを自動的に展開
setopt hist_expand

#pathを通しておく
typeset -U path PATH
path=(
  /opt/homebrew/bin(N-/)
  /opt/homebrew/sbin(N-/)
  /usr/bin
  /usr/sbin
  /bin
  /sbin
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  /Library/Apple/usr/bin
)

# 反映
source ~/.zshrc

# warp
brew install --cask warp

# Google日本語入力
brew install --cask google-japanese-ime

# vscode
brew install --cask visual-studio-code

# raycast
brew install --cask raycast

## Gitの設定
git config --global user.name "<ユーザー名>"
git config --global user.email "<メールアドレス>"

## AWS
brew install awscli
aws --version

## Terraform
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
terraform --version

## GCP
# https://cloud.google.com/sdk/docs/install?hl=ja　参照
./google-cloud-sdk/install.sh
gcloud components update
gcloud --version

## pyenv virtual-env
brew install pyenv
brew install pyenv-virtualenv

code ~/.zshrc

# .zshrc内に以下を記載
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# pythonインストール
pyenv install 3.11
pyenv global 3.11

# venvの作成
pyenv virtualenv 3.11.11 venv

# activate
pyenv activate venv

# deactivate
pyenv deactivate

# おまけ 起動音を消す
# https://support.apple.com/ja-jp/102230
# 初期設定
# https://zenn.dev/gahuto/articles/tkt-mac-preferences-2025