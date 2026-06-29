#!/usr/bin/env bash
# ============================================================
#   CAI DAT TU DONG - UNG DUNG QUAN LY CONG VIEC (Git Bash)
#   Chay:  bash cai-dat.sh
# ============================================================
set -e
cd "$(dirname "$0")"

DB_NAME="qlcongviec"
DB_USER="root"
DB_PASS="root"

echo "============================================================"
echo "   CAI DAT UNG DUNG QUAN LY CONG VIEC"
echo "============================================================"

# --- 0. Kiem tra dang o thu muc du an ---
if [ ! -f manage.py ]; then
  echo "[LOI] Khong thay manage.py. Hay dat cai-dat.sh trong thu muc du an da clone ve."
  exit 1
fi

# --- 1. Kiem tra Python ---
echo ""
echo "==> Kiem tra Python"
if command -v py >/dev/null 2>&1; then PY="py";
elif command -v python >/dev/null 2>&1; then PY="python";
else echo "[LOI] Chua cai Python. Tai tai https://www.python.org/downloads/"; exit 1; fi
echo "    [OK] Da co Python ($PY)"

# --- 2. Tao moi truong ao ---
echo ""
echo "==> Tao moi truong ao (venv)"
[ -d venv ] || "$PY" -m venv venv
VPY="venv/Scripts/python.exe"
echo "    [OK] San sang moi truong ao"

# --- 3. Cai thu vien ---
echo ""
echo "==> Cai dat thu vien"
printf "Django==5.1.4\nPyMySQL==1.2.0\npython-dotenv\nPillow\nopenpyxl\n" > requirements.txt
"$VPY" -m pip install --upgrade pip -q
"$VPY" -m pip install -r requirements.txt -q
echo "    [OK] Da cai xong thu vien"

# --- 4. Tao file .env ---
echo ""
echo "==> Tao file cau hinh .env"
if [ ! -f .env ]; then
cat > .env <<'EOF'
SECRET_KEY=django-insecure-3_i_t@g90u%2g6-$kgli+36@)&fs6k%7#l@=&ouh0p1zcgvo1b
DEBUG=True
DB_NAME=qlcongviec
DB_USER=root
DB_PASSWORD=root
DB_HOST=127.0.0.1
DB_PORT=3306
EOF
  echo "    [OK] Da tao .env"
else
  echo "    [OK] Da co .env, giu nguyen"
fi

# --- 5. Tao co so du lieu ---
echo ""
echo "==> Tao co so du lieu MySQL"
"$VPY" -c "import pymysql,sys
try:
    c=pymysql.connect(host='127.0.0.1',user='$DB_USER',password='$DB_PASS',port=3306)
    c.cursor().execute('CREATE DATABASE IF NOT EXISTS $DB_NAME CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci')
    c.close(); print('    [OK] Da tao database $DB_NAME')
except Exception as e:
    print('[LOI] Khong ket noi duoc MySQL:',e); sys.exit(1)"

# --- 6. Tao bang + du lieu mau ---
echo ""
echo "==> Tao bang va du lieu mau"
export PYTHONUTF8=1
export PYTHONIOENCODING=utf-8
"$VPY" manage.py migrate
"$VPY" manage.py seed_data --fresh
echo "    [OK] Da tao bang va du lieu mau"

# --- 7. Chay server ---
echo ""
echo "============================================================"
echo "   CAI DAT HOAN TAT! Dang khoi dong ung dung..."
echo "   Truy cap : http://127.0.0.1:8000"
echo "   Quan tri : admin / admin123"
echo "   Nguoi dung: trungha / user123"
echo "   (Nhan Ctrl+C de dung server)"
echo "============================================================"
"$VPY" manage.py runserver
