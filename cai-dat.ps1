# ============================================================
#   CAI DAT TU DONG - UNG DUNG QUAN LY CONG VIEC
#   Dat file nay (cung cai-dat.bat) trong thu muc du an
#   da clone ve, roi bam dup vao cai-dat.bat.
# ============================================================
$ErrorActionPreference = 'Stop'
try { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8 } catch {}
$env:PYTHONUTF8 = '1'
$env:PYTHONIOENCODING = 'utf-8'

$DB_NAME = 'qlcongviec'
$DB_USER = 'root'
$DB_PASS = 'root'

function Buoc($m) { Write-Host "`n==> $m" -ForegroundColor Cyan }
function OK($m)   { Write-Host "    [OK] $m" -ForegroundColor Green }
function Loi($m)  { Write-Host "    [LOI] $m" -ForegroundColor Red }

Write-Host "============================================================" -ForegroundColor Yellow
Write-Host "   CAI DAT UNG DUNG QUAN LY CONG VIEC" -ForegroundColor Yellow
Write-Host "============================================================" -ForegroundColor Yellow

$PROJ = $PSScriptRoot
Set-Location $PROJ

# --- 0. Kiem tra dang o trong thu muc du an ---
if (-not (Test-Path (Join-Path $PROJ 'manage.py'))) {
    Loi 'Khong tim thay manage.py. Hay dat cai-dat.bat va cai-dat.ps1 trong thu muc du an da clone ve.'
    exit 1
}

# --- 1. Kiem tra Python ---
Buoc 'Kiem tra Python'
$PY = $null
foreach ($c in @('py', 'python')) {
    try { & $c --version *> $null; if ($LASTEXITCODE -eq 0) { $PY = $c; break } } catch {}
}
if (-not $PY) { Loi 'Chua cai Python. Tai tai https://www.python.org/downloads/ roi chay lai.'; exit 1 }
OK "Da co Python ($PY)"

# --- 2. Tao moi truong ao ---
Buoc 'Tao moi truong ao (venv)'
if (-not (Test-Path 'venv')) { & $PY -m venv venv }
$VPY = Join-Path $PROJ 'venv\Scripts\python.exe'
OK 'San sang moi truong ao'

# --- 3. Cai thu vien ---
Buoc 'Cai dat thu vien'
$req = @('Django==5.1.4', 'PyMySQL==1.2.0', 'python-dotenv', 'Pillow', 'openpyxl')
$req | Set-Content -Encoding utf8 (Join-Path $PROJ 'requirements.txt')
& $VPY -m pip install --upgrade pip -q
& $VPY -m pip install -r requirements.txt -q
OK 'Da cai xong thu vien'

# --- 4. Tao file .env ---
Buoc 'Tao file cau hinh .env'
if (-not (Test-Path '.env')) {
    $envLines = @(
        'SECRET_KEY=django-insecure-3_i_t@g90u%2g6-$kgli+36@)&fs6k%7#l@=&ouh0p1zcgvo1b'
        'DEBUG=True'
        "DB_NAME=$DB_NAME"
        "DB_USER=$DB_USER"
        "DB_PASSWORD=$DB_PASS"
        'DB_HOST=127.0.0.1'
        'DB_PORT=3306'
    )
    $envLines | Set-Content -Encoding utf8 '.env'
    OK 'Da tao .env'
} else { OK 'Da co .env, giu nguyen' }

# --- 5. Tao co so du lieu ---
Buoc 'Tao co so du lieu MySQL'
$dbpy = @(
    'import pymysql, sys'
    'try:'
    "    c = pymysql.connect(host='127.0.0.1', user='$DB_USER', password='$DB_PASS', port=3306)"
    "    c.cursor().execute('CREATE DATABASE IF NOT EXISTS $DB_NAME CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci')"
    "    c.close(); print('DB_OK')"
    'except Exception as e:'
    "    print('DB_FAIL:', e); sys.exit(1)"
)
$dbpy | Set-Content -Encoding utf8 (Join-Path $PROJ '_create_db.py')
& $VPY '_create_db.py'
$dbCode = $LASTEXITCODE
Remove-Item '_create_db.py' -ErrorAction SilentlyContinue
if ($dbCode -ne 0) {
    Loi "Khong ket noi duoc MySQL (can MySQL dang chay, tai khoan $DB_USER/$DB_PASS). Sua lai trong file .env neu khac."
    exit 1
}
OK "Da tao database '$DB_NAME'"

# --- 6. Tao bang + du lieu mau ---
Buoc 'Tao bang va du lieu mau'
& $VPY manage.py migrate
& $VPY manage.py seed_data --fresh
OK 'Da tao bang va du lieu mau'

# --- 7. Chay server ---
Write-Host "`n============================================================" -ForegroundColor Green
Write-Host "   CAI DAT HOAN TAT! Dang khoi dong ung dung..." -ForegroundColor Green
Write-Host "   Truy cap : http://127.0.0.1:8000" -ForegroundColor Green
Write-Host "   Quan tri : admin / admin123" -ForegroundColor Green
Write-Host "   Nguoi dung: trungha / user123" -ForegroundColor Green
Write-Host "   (Nhan Ctrl+C de dung server)" -ForegroundColor Green
Write-Host "============================================================`n" -ForegroundColor Green
Start-Process 'http://127.0.0.1:8000'
& $VPY manage.py runserver
