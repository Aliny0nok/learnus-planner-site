#!/bin/bash
# LearnUs Planner — one-line installer for macOS.
#   curl -fsSL https://aliny0nok.github.io/learnus-planner-site/install-mac.sh | bash
# Downloads the latest Mac package from GitHub, unpacks it in ~/Downloads and runs its installer.
# (Files downloaded this way are not blocked by Gatekeeper; nothing else on the Mac is changed.)
set -e
REPO="Aliny0nok/learnus-planner-site"
DEST="$HOME/Downloads/LearnUs Planner (installer)"
echo "LearnUs Planner — загружаю последнюю версию…"
URL=$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" \
      | grep -o '"browser_download_url": *"[^"]*LearnUs-Planner-Mac.zip"' | sed 's/.*"\(https[^"]*\)"/\1/')
if [ -z "$URL" ]; then echo "Не нашла файл для Mac на GitHub. Проверьте интернет и попробуйте ещё раз."; exit 1; fi
rm -rf "$DEST"; mkdir -p "$DEST"
curl -fsSL "$URL" -o "$DEST/LearnUs-Planner-Mac.zip"
cd "$DEST"
unzip -q LearnUs-Planner-Mac.zip
xattr -dr com.apple.quarantine "$DEST" 2>/dev/null || true
chmod +x "LearnUs Planner/install.command" "LearnUs Planner/uninstall.command"
echo "Запускаю установщик…"
cd "LearnUs Planner"
bash ./install.command < /dev/tty
