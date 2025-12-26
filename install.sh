#!/usr/bin/env bash
set -euo pipefail

# ===== Config (you can change these) =====
TOOL_NAME="ebug"                 # git subcommand: git ebug
SRC_SCRIPT="./git-ebug"              # your main bash script in this repo
BIN_DIR="${HOME}/.local/bin"
TARGET="${BIN_DIR}/git-${TOOL_NAME}"  # must be git-xxx for "git xxx"
ENV_NAME=".env.n8n"
ENV_TARGET="${BIN_DIR}/${ENV_NAME}"
ENV_EXAMPLE="./${ENV_NAME}.example"   # optional: .env.n8n.example
# =========================================

say() { printf "%s\n" "$*"; }
die() { say "❌ $*"; exit 1; }

# Ensure we're in repo root (best-effort)
if [[ ! -f "$SRC_SCRIPT" ]]; then
  die "找不到 $SRC_SCRIPT。請在包含 ebug 的目錄執行：./install.sh"
fi

say "[install] 安裝 git 子命令：git ${TOOL_NAME}"
say "[install] 目標位置：${TARGET}"

mkdir -p "$BIN_DIR"
cp "$SRC_SCRIPT" "$TARGET"
chmod +x "$TARGET"

# Create env next to the installed script (same directory)
if [[ -f "$ENV_TARGET" ]]; then
  say "[install] 已存在 ${ENV_TARGET}，略過建立"
else
  if [[ -f "$ENV_EXAMPLE" ]]; then
    cp "$ENV_EXAMPLE" "$ENV_TARGET"
    say "[install] 已從 ${ENV_EXAMPLE} 建立 ${ENV_TARGET}"
  else
    cat >"$ENV_TARGET" <<'EOF'
# ebug / n8n config
# 請填入以下三個值
N8N_URL=
N8N_SECRET=
U_MESSENGER_EMAIL=
EOF
    say "[install] 已建立空白範本 ${ENV_TARGET}"
  fi

  # Lock down permissions (best-effort)
  chmod 600 "$ENV_TARGET" || true
fi

# Check PATH includes ~/.local/bin
case ":${PATH}:" in
  *":${BIN_DIR}:"*)
    say "[install] PATH 已包含 ${BIN_DIR}"
    ;;
  *)
    say "⚠️ 你的 PATH 似乎沒有包含 ${BIN_DIR}"
    say "   你可以把下面這行加到 ~/.bashrc 或 ~/.zshrc："
    say "   export PATH=\"${BIN_DIR}:\$PATH\""
    ;;
esac

say
say "✅ 安裝完成"
say "👉 下一步：編輯設定檔"
say "   ${ENV_TARGET}"
say
say "👉 測試："
say "   git ${TOOL_NAME} --help"
