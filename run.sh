#!/data/data/com.termux/files/usr/bin/bash
clear

# Bat su kien Ctrl + C (SIGINT) de tu dong kill python process
trap 'echo "Dang tat tool va don dep..."; pkill -f "python.*main.py" 2>/dev/null; exit' INT TERM

echo "╔═══════════════════════════════════════╗"
echo "║   Ka Rejoin Python v2.0               ║"
echo "║   Dang khoi dong...                   ║"
echo "╚═══════════════════════════════════════╝"
echo ""

# Xac dinh thu muc tool
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MAIN_PY="$SCRIPT_DIR/main.py"

# Kiem tra file main.py
if [ ! -f "$MAIN_PY" ]; then
    echo "[ERROR] Khong tim thay main.py!"
    echo "[ERROR] Hay chay lai setup:"
    echo "  . <(curl -sL https://raw.githubusercontent.com/kaduc966-a11y/Tool-Rejoin-Python/main/setup.sh)"
    exit 1
fi

# Kiem tra Python
if ! command -v python >/dev/null 2>&1; then
    echo "[ERROR] Python chua duoc cai dat!"
    echo "[*] Dang cai Python..."
    yes | pkg install python -y
fi

# Kiem tra va cai thu vien neu thieu
python -c "import requests" 2>/dev/null || pip install requests 2>/dev/null
python -c "import psutil" 2>/dev/null || pip install psutil 2>/dev/null

echo "[OK] Python: $(python --version 2>&1)"
echo "[*] Dang chay Ka Rejoin..."
echo ""

# Duong dan Python day du (Termux)
PYTHON_BIN="$(command -v python)"

# Chay tool voi quyen root (su) neu co
if command -v su >/dev/null 2>&1; then
    su -c "export PATH=/data/data/com.termux/files/usr/bin:\$PATH && cd '$SCRIPT_DIR' && '$PYTHON_BIN' '$MAIN_PY'"
else
    cd "$SCRIPT_DIR" && python "$MAIN_PY"
fi
