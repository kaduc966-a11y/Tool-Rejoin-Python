#!/bin/bash
# ================================================
# Ka Rejoin Python v2.0 - Auto Setup Script
# Chay trong Termux: . <(curl -sL https://raw.githubusercontent.com/kaduc966-a11y/Tool-Rejoin-Python/main/setup.sh)
# ================================================

REPO="https://raw.githubusercontent.com/kaduc966-a11y/Tool-Rejoin-Python/main"
HOME_DIR="/data/data/com.termux/files/home"
TOOL_DIR="$HOME_DIR/rejoin-python"
TERMUX_BOOT_APK="https://f-droid.org/repo/com.termux.boot_1000.apk"

echo "╔═══════════════════════════════════════╗"
echo "║   Ka Rejoin Python v2.0 - Auto Setup  ║"
echo "╚═══════════════════════════════════════╝"
echo ""

# 0. Kiem tra dang chay trong Termux
if [ -z "$TERMUX_VERSION" ] && [ ! -d "/data/data/com.termux" ]; then
    echo "[!] Ban phai chay script nay trong TERMUX!"
    echo "[!] Tai Termux tai: https://f-droid.org/repo/com.termux_1022.apk"
    exit 1
fi

# 1. Setup Termux storage (cho phep truy cap /sdcard)
echo "[1/7] Setup Termux storage..."
if [ -e "$HOME_DIR/storage" ]; then
    rm -rf "$HOME_DIR/storage"
fi
termux-setup-storage 2>/dev/null
sleep 2

# 2. Dam bao curl co san
echo "[2/7] Kiem tra curl..."
if ! command -v curl >/dev/null 2>&1; then
    echo "  -> Cai dat curl..."
    yes | pkg install curl -y
fi

# 3. Update & install dependencies
echo "[3/7] Update packages..."
yes | pkg update -y 2>/dev/null
yes | pkg upgrade -y 2>/dev/null

# 4. Install Python
echo "[4/7] Cai dat Python..."
if ! command -v python >/dev/null 2>&1; then
    echo "  -> Installing Python..."
    yes | pkg install python -y
else
    echo "  -> Python da co san: $(python --version 2>&1)"
fi

# 5. Install pip dependencies
echo "[5/7] Cai dat thu vien Python..."
pip install --upgrade pip 2>/dev/null

# Cai dat cac thu vien can thiet
pip install requests 2>/dev/null || echo "  [WARN] Khong cai duoc requests, tool se dung urllib"
pip install psutil 2>/dev/null || echo "  [WARN] Khong cai duoc psutil"

# Cai cac package Termux can thiet
echo "[5.5/7] Cai dat Termux packages..."
yes | pkg install -y tsu 2>/dev/null || true
yes | pkg install -y root-repo 2>/dev/null || true
yes | pkg install -y sqlite 2>/dev/null || true
yes | pkg install -y wget 2>/dev/null || true
yes | pkg install -y grep 2>/dev/null || true
yes | pkg install -y procps 2>/dev/null || true
yes | pkg install -y termux-api 2>/dev/null || true

# 6. Download tool files
echo "[6/7] Tai tool Rejoin Python..."
mkdir -p "$TOOL_DIR"

# Download main.py (obfuscated)
curl -sL "$REPO/main.py" -o "$TOOL_DIR/main.py"
if [ $? -ne 0 ] || [ ! -s "$TOOL_DIR/main.py" ]; then
    echo "[ERROR] Khong the tai main.py!"
    exit 1
fi
echo "  -> Da tai main.py ($(wc -c < "$TOOL_DIR/main.py") bytes)"

# Download run.sh
curl -sL "$REPO/run.sh" -o "$TOOL_DIR/run.sh"
chmod +x "$TOOL_DIR/run.sh"
echo "  -> Da tai run.sh"

# Config se duoc tao tu dong khi chay tool lan dau

# 7. Tao alias 'run' va shortcut
echo "[7/7] Tao shortcut..."

# Tao alias trong bashrc
ALIAS_LINE="alias run='cd $TOOL_DIR && bash run.sh'"
if ! grep -qF "alias run=" "$HOME_DIR/.bashrc" 2>/dev/null; then
    echo "" >> "$HOME_DIR/.bashrc"
    echo "# Ka Rejoin Python" >> "$HOME_DIR/.bashrc"
    echo "$ALIAS_LINE" >> "$HOME_DIR/.bashrc"
    echo "  -> Da them alias 'run' vao .bashrc"
else
    # Update alias neu da ton tai
    sed -i "s|alias run=.*|$ALIAS_LINE|g" "$HOME_DIR/.bashrc"
    echo "  -> Da cap nhat alias 'run'"
fi

# Source bashrc
source "$HOME_DIR/.bashrc" 2>/dev/null

# Setup Termux:Boot (auto-start khi khoi dong)
echo ""
echo "[*] Setup Termux:Boot..."
BOOT_DIR="$HOME_DIR/.termux/boot"
mkdir -p "$BOOT_DIR"
curl -sL "$REPO/boot_rejoin.sh" -o "$BOOT_DIR/boot_rejoin.sh"
chmod +x "$BOOT_DIR/boot_rejoin.sh"
echo "  -> Da cai boot script"

# Kiem tra Termux:Boot app
if ! command -v termux-boot 2>/dev/null && [ ! -d "/data/data/com.termux.boot" ]; then
    echo ""
    echo "  [!] Chua cai Termux:Boot!"
    echo "  [!] Tai tai: $TERMUX_BOOT_APK"
    echo "  [!] Hoac: pkg install termux-boot"
fi

echo ""
echo "╔═══════════════════════════════════════╗"
echo "║         SETUP HOAN TAT!               ║"
echo "╠═══════════════════════════════════════╣"
echo "║  Chay tool:     run                   ║"
echo "║  Hoac:          cd ~/rejoin-python    ║"
echo "║                 bash run.sh           ║"
echo "║                                       ║"
echo "║  Cap nhat tool:                       ║"
echo "║  . <(curl -sL $REPO/setup.sh)         ║"
echo "╚═══════════════════════════════════════╝"
echo ""
echo "[OK] Python: $(python --version 2>&1)"
echo "[OK] Tool dir: $TOOL_DIR"
echo "[OK] Gõ 'run' de khoi dong tool!"
echo ""
