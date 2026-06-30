# Ứng dụng quản lý công việc

Ứng dụng quản lý công việc là một hệ thống web được xây dựng bằng **Python/Django** và **MySQL**, giúp người dùng quản lý công việc cá nhân hoặc công việc nhóm một cách khoa học, trực quan và dễ sử dụng.

Hệ thống hỗ trợ tạo công việc, phân loại theo danh mục và nhãn, đặt độ ưu tiên, hạn hoàn thành, theo dõi tiến độ, xem công việc theo danh sách, bảng Kanban hoặc lịch. Ngoài ra, hệ thống còn có bình luận, đính kèm tệp, nhắc nhở qua email, thùng rác, xuất dữ liệu và phân hệ quản trị dành cho quản trị viên.

---

## 1. Giới thiệu đề tài

Trong học tập và làm việc, mỗi người thường phải xử lý nhiều công việc khác nhau như bài tập, dự án, lịch cá nhân hoặc công việc nhóm. Nếu chỉ ghi nhớ bằng trí nhớ hoặc ghi chép thủ công, người dùng dễ quên việc, trễ hạn và khó theo dõi tiến độ tổng thể.

Vì vậy, đề tài **“Ứng dụng quản lý công việc”** được xây dựng nhằm cung cấp một công cụ quản lý công việc trực tuyến, giao diện tiếng Việt, dễ sử dụng và phù hợp với nhu cầu học tập, làm việc nhóm cũng như quản lý cá nhân.

---

## 2. Chức năng chính

### 2.1. Chức năng dành cho người dùng

- Đăng ký tài khoản.
- Đăng nhập, đăng xuất.
- Quản lý hồ sơ cá nhân.
- Đổi mật khẩu.
- Thêm, sửa, xóa và xem chi tiết công việc.
- Quản lý công việc theo:
  - Danh mục.
  - Nhãn.
  - Trạng thái.
  - Độ ưu tiên.
  - Hạn hoàn thành.
- Đánh dấu công việc quan trọng.
- Giao việc cho người dùng khác.
- Thêm công việc con và theo dõi tiến độ.
- Bình luận trong từng công việc.
- Đính kèm tệp cho công việc.
- Gửi nhắc nhở công việc qua email.
- Tìm kiếm, lọc, sắp xếp và phân trang danh sách công việc.
- Xem công việc theo 3 chế độ:
  - Danh sách.
  - Bảng Kanban kéo-thả.
  - Lịch theo tháng.
- Quản lý thùng rác:
  - Khôi phục công việc đã xóa.
  - Xóa vĩnh viễn.
  - Dọn sạch thùng rác.
- Xuất dữ liệu ra:
  - CSV.
  - Excel.
  - Trang in.

### 2.2. Chức năng dành cho quản trị viên

- Xem dashboard thống kê toàn hệ thống.
- Quản lý người dùng.
- Tìm kiếm người dùng.
- Khóa hoặc mở khóa tài khoản.
- Cấp hoặc thu hồi quyền quản trị.
- Xóa tài khoản người dùng.
- Xem và quản lý toàn bộ công việc trong hệ thống.
- Lọc công việc theo người tạo, trạng thái.
- Xóa công việc khi cần quản trị dữ liệu.

---

## 3. Công nghệ sử dụng

| Thành phần | Công nghệ |
|---|---|
| Ngôn ngữ lập trình | Python |
| Framework backend | Django |
| Cơ sở dữ liệu | MySQL |
| Kết nối MySQL | PyMySQL |
| Giao diện | HTML, CSS, Bootstrap 5 |
| Tương tác giao diện | JavaScript |
| Biểu đồ thống kê | Chart.js |
| Xuất Excel | openpyxl |
| Xử lý ảnh đại diện | Pillow |
| Biến môi trường | python-dotenv |
| Kiểm thử tự động | Playwright |
| Quản lý mã nguồn | Git, GitHub |

---

## 4. Kiến trúc hệ thống

Hệ thống được xây dựng theo mô hình **MVT** của Django:

```text
Model - View - Template
```

Trong đó:

- **Model**: định nghĩa cấu trúc dữ liệu và thao tác với cơ sở dữ liệu thông qua Django ORM.
- **View**: xử lý logic nghiệp vụ, nhận request và trả về response.
- **Template**: hiển thị dữ liệu ra giao diện HTML.
- **URL**: định tuyến request tới view tương ứng.

Luồng hoạt động cơ bản:

```text
Người dùng thao tác trên trình duyệt
        ↓
URL định tuyến request
        ↓
View xử lý nghiệp vụ
        ↓
Model truy vấn hoặc lưu dữ liệu vào MySQL
        ↓
Template hiển thị kết quả
        ↓
Trình duyệt hiển thị giao diện cho người dùng
```

---

## 5. Cấu trúc thư mục dự án

```text
ung-dung-quan-ly-cong-viec/
│
├── accounts/
│   ├── models.py
│   ├── forms.py
│   ├── views.py
│   ├── urls.py
│   └── admin.py
│
├── tasks/
│   ├── models.py
│   ├── forms.py
│   ├── views.py
│   ├── urls.py
│   ├── admin.py
│   ├── context_processors.py
│   └── management/
│       └── commands/
│           └── seed_data.py
│
├── taskmanager/
│   ├── settings.py
│   ├── urls.py
│   ├── asgi.py
│   └── wsgi.py
│
├── templates/
│   ├── base.html
│   ├── base_auth.html
│   ├── accounts/
│   └── tasks/
│
├── static/
│   └── css/
│       └── style.css
│
├── manage.py
├── cai-dat.sh
├── cai-dat.bat
├── cai-dat.ps1
├── taikhoan.txt
├── e2e_test.py
├── e2e_test_actions.py
├── e2e_test_extra.py
├── e2e_test_features.py
├── requirements.txt
└── README.md
```

### Vai trò các thư mục chính

| Thư mục/File | Vai trò |
|---|---|
| `taskmanager/` | Cấu hình chính của project Django |
| `accounts/` | Xử lý tài khoản, đăng ký, đăng nhập, hồ sơ |
| `tasks/` | Xử lý toàn bộ nghiệp vụ quản lý công việc |
| `templates/` | Chứa các file giao diện HTML |
| `static/` | Chứa CSS và tài nguyên tĩnh |
| `manage.py` | File quản lý project Django |
| `seed_data.py` | Lệnh tạo dữ liệu mẫu |
| `cai-dat.sh` | Script cài đặt tự động bằng Git Bash |
| `cai-dat.bat` | Script cài đặt nhanh trên Windows |
| `cai-dat.ps1` | Script cài đặt bằng PowerShell |
| `taikhoan.txt` | Danh sách tài khoản mẫu |
| `e2e_test*.py` | Các file kiểm thử tự động |

---

## 6. Thiết kế cơ sở dữ liệu

Hệ thống gồm các bảng chính:

| Bảng | Vai trò |
|---|---|
| `User` | Tài khoản người dùng của Django |
| `Profile` | Hồ sơ mở rộng của người dùng |
| `Category` | Danh mục công việc |
| `Tag` | Nhãn gắn cho công việc |
| `Task` | Công việc chính |
| `SubTask` | Công việc con/checklist |
| `Comment` | Bình luận trong công việc |
| `Attachment` | Tệp đính kèm |

Các quan hệ chính:

- Một người dùng có một hồ sơ cá nhân.
- Một người dùng có nhiều danh mục, nhãn và công việc.
- Một công việc thuộc về một danh mục.
- Một công việc có thể có nhiều nhãn.
- Một công việc có nhiều công việc con.
- Một công việc có nhiều bình luận.
- Một công việc có nhiều tệp đính kèm.
- Một công việc có thể được giao cho một người dùng khác.

---

## 7. Cài đặt môi trường

### 7.1. Yêu cầu

Trước khi cài đặt, máy cần có:

- Python 3.10 trở lên  
  Tải tại: https://www.python.org/downloads/
- MySQL 8.0 đang chạy.
- Tài khoản MySQL: `root`
- Mật khẩu MySQL: `root`
- Git để clone mã nguồn.
- Visual Studio Code hoặc trình soạn thảo tương đương.

---

## 8. Clone mã nguồn

Mở Git Bash hoặc Terminal và chạy:

```bash
git clone https://github.com/NguyenTrungHa/ung-dung-quan-ly-cong-viec.git
```

Di chuyển vào thư mục dự án:

```bash
cd ung-dung-quan-ly-cong-viec
```

---

## 9. Cách 1: Cài tự động

Đây là cách khuyên dùng.

Sau khi clone mã nguồn về, mở thư mục dự án bằng VS Code hoặc Git Bash.

### Dùng Git Bash

Chạy lệnh:

```bash
bash cai-dat.sh
```

### Dùng Windows

Bấm đúp vào file:

```text
cai-dat.bat
```

Script tự động sẽ thực hiện:

- Tạo môi trường ảo.
- Cài đặt các thư viện cần thiết.
- Sinh file `.env`.
- Tạo cơ sở dữ liệu MySQL.
- Chạy migration.
- Tạo dữ liệu mẫu.
- Khởi động ứng dụng.

Sau khi chạy xong, mở trình duyệt tại:

```text
http://127.0.0.1:8000
```

---

## 10. Cách 2: Cài thủ công

### Bước 1: Tạo môi trường ảo

```bash
python -m venv venv
```

### Bước 2: Kích hoạt môi trường ảo

Dùng Git Bash:

```bash
source venv/Scripts/activate
```

Dùng PowerShell:

```powershell
venv\Scripts\Activate.ps1
```

Dùng CMD:

```cmd
venv\Scripts\activate
```

---

### Bước 3: Cài đặt thư viện

```bash
pip install -r requirements.txt
```

Trường hợp chưa có file `requirements.txt`, có thể cài trực tiếp:

```bash
pip install Django PyMySQL python-dotenv Pillow openpyxl playwright
```

---

### Bước 4: Tạo file `.env`

Tạo file `.env` trong thư mục gốc của dự án với nội dung mẫu:

```env
SECRET_KEY=your-secret-key
DEBUG=True
DB_NAME=qlcongviec
DB_USER=root
DB_PASSWORD=root
DB_HOST=127.0.0.1
DB_PORT=3306
```

Lưu ý: Khi triển khai thực tế, không nên để lộ `SECRET_KEY` và thông tin cơ sở dữ liệu.

---

### Bước 5: Tạo cơ sở dữ liệu MySQL

Đăng nhập vào MySQL:

```bash
mysql -u root -p
```

Nhập mật khẩu:

```text
root
```

Tạo database:

```sql
CREATE DATABASE IF NOT EXISTS qlcongviec
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;
```

Thoát MySQL:

```sql
EXIT;
```

---

### Bước 6: Chạy migration

```bash
python manage.py migrate
```

---

### Bước 7: Tạo dữ liệu mẫu

```bash
python manage.py seed_data --fresh
```

---

### Bước 8: Chạy server

```bash
python manage.py runserver
```

Mở trình duyệt tại:

```text
http://127.0.0.1:8000
```

---

## 11. Cách chạy ứng dụng các lần sau

Mở thư mục dự án, sau đó kích hoạt môi trường ảo:

```bash
source venv/Scripts/activate
```

Chạy server Django:

```bash
python manage.py runserver
```

Truy cập ứng dụng tại:

```text
http://127.0.0.1:8000
```

Để dừng server:

```text
Ctrl + C
```

---

## 12. Chạy nhanh không cần kích hoạt môi trường ảo

Có thể chạy trực tiếp bằng Python trong thư mục `venv`:

```bash
venv/Scripts/python.exe manage.py runserver
```

---

## 13. Tài khoản mẫu

Sau khi chạy lệnh:

```bash
python manage.py seed_data --fresh
```

Hệ thống sẽ tạo dữ liệu mẫu và các tài khoản thử nghiệm.

### 13.1. Tài khoản quản trị

| Tên đăng nhập | Mật khẩu | Vai trò |
|---|---|---|
| `admin` | `admin123` | Quản trị viên |

Quản trị viên có thể truy cập:

```text
http://127.0.0.1:8000/quan-tri/
```

Hoặc Django Admin:

```text
http://127.0.0.1:8000/admin/
```

---

### 13.2. Tài khoản người dùng

Mật khẩu chung:

```text
user123
```

| STT | Tên đăng nhập | Họ và tên |
|---|---|---|
| 1 | `trungha` | Nguyễn Trung Hà |
| 2 | `lan` | Trần Thị Lan |
| 3 | `minh` | Lê Văn Minh |
| 4 | `hoa` | Phạm Thị Hoa |
| 5 | `nam` | Đỗ Hoàng Nam |
| 6 | `thao` | Vũ Phương Thảo |

Người dùng cũng có thể tự đăng ký tài khoản mới tại:

```text
http://127.0.0.1:8000/tai-khoan/dang-ky/
```

---

## 14. Các đường dẫn chính

| Chức năng | Đường dẫn |
|---|---|
| Trang chủ / Tổng quan | `http://127.0.0.1:8000/` |
| Đăng nhập | `http://127.0.0.1:8000/tai-khoan/dang-nhap/` |
| Đăng ký | `http://127.0.0.1:8000/tai-khoan/dang-ky/` |
| Danh sách công việc | `http://127.0.0.1:8000/cong-viec/` |
| Thêm công việc | `http://127.0.0.1:8000/cong-viec/them/` |
| Bảng Kanban | `http://127.0.0.1:8000/kanban/` |
| Lịch công việc | `http://127.0.0.1:8000/lich/` |
| Thùng rác | `http://127.0.0.1:8000/thung-rac/` |
| Quản trị hệ thống | `http://127.0.0.1:8000/quan-tri/` |
| Django Admin | `http://127.0.0.1:8000/admin/` |

---

## 15. Kiểm thử

Dự án có các file kiểm thử tự động bằng Playwright:

```text
e2e_test.py
e2e_test_actions.py
e2e_test_extra.py
e2e_test_features.py
```

Các nhóm chức năng được kiểm thử gồm:

- Đăng nhập đúng/sai.
- Đăng ký tài khoản.
- Thêm công việc.
- Kiểm tra validation tiêu đề và hạn hoàn thành.
- Đổi trạng thái công việc.
- Kéo-thả Kanban.
- Thêm công việc con.
- Bình luận.
- Đính kèm tệp.
- Xóa mềm và khôi phục từ thùng rác.
- Xuất Excel/CSV.
- Đổi mật khẩu.
- Phân quyền quản trị.

### Cài Playwright

```bash
pip install playwright
playwright install
```

### Chạy kiểm thử

```bash
python e2e_test.py
python e2e_test_actions.py
python e2e_test_extra.py
python e2e_test_features.py
```

---

## 16. Một số chức năng nổi bật

### 16.1. Dashboard thống kê

Trang tổng quan hiển thị:

- Tổng số công việc.
- Công việc cần làm.
- Công việc đang làm.
- Công việc hoàn thành.
- Công việc quá hạn.
- Công việc sắp đến hạn.
- Biểu đồ trạng thái.
- Biểu đồ độ ưu tiên.
- Biểu đồ hoàn thành theo ngày.

---

### 16.2. Quản lý công việc

Người dùng có thể tạo và quản lý công việc với các thông tin:

- Tiêu đề.
- Mô tả.
- Danh mục.
- Nhãn.
- Người được giao.
- Độ ưu tiên.
- Trạng thái.
- Hạn hoàn thành.
- Công việc con.
- Bình luận.
- Tệp đính kèm.

---

### 16.3. Bảng Kanban

Bảng Kanban chia công việc thành 3 cột:

```text
Cần làm | Đang làm | Hoàn thành
```

Người dùng có thể kéo-thả thẻ công việc giữa các cột để cập nhật trạng thái.

---

### 16.4. Lịch công việc

Chế độ lịch hiển thị công việc theo hạn hoàn thành, giúp người dùng theo dõi deadline theo từng ngày trong tháng.

---

### 16.5. Thùng rác

Khi xóa công việc, hệ thống sử dụng cơ chế xóa mềm:

- Công việc không bị xóa ngay khỏi cơ sở dữ liệu.
- Công việc được chuyển vào thùng rác.
- Người dùng có thể khôi phục hoặc xóa vĩnh viễn.

---

### 16.6. Phân hệ quản trị

Quản trị viên có thể:

- Xem thống kê toàn hệ thống.
- Quản lý người dùng.
- Khóa/mở khóa tài khoản.
- Cấp/thu hồi quyền quản trị.
- Quản lý toàn bộ công việc.

---

## 17. Ghi chú về email nhắc nhở

Mặc định khi chạy ở môi trường phát triển, email có thể được in ra console hoặc cần cấu hình SMTP tùy theo thiết lập trong file `settings.py`.

Để gửi email thật qua SMTP, cần cấu hình thêm trong file `.env`, ví dụ:

```env
EMAIL_HOST=smtp.example.com
EMAIL_PORT=587
EMAIL_USE_TLS=True
EMAIL_HOST_USER=your_email@example.com
EMAIL_HOST_PASSWORD=your_password
DEFAULT_FROM_EMAIL=Quản lý công việc <your_email@example.com>
```

---

## 18. Lưu ý khi triển khai thực tế

Project hiện được cấu hình phục vụ học tập và demo trên máy cục bộ.

Nếu triển khai lên môi trường thật, cần lưu ý:

- Tắt `DEBUG`.
- Cấu hình `ALLOWED_HOSTS` cụ thể.
- Không để lộ `SECRET_KEY`.
- Dùng biến môi trường cho thông tin nhạy cảm.
- Cấu hình HTTPS.
- Cấu hình SMTP thật cho chức năng gửi email.
- Giới hạn dung lượng và định dạng file upload.
- Sao lưu cơ sở dữ liệu định kỳ.

---

## 19. Hướng phát triển

Trong tương lai, hệ thống có thể được mở rộng theo các hướng:

- Triển khai lên cloud.
- Cấu hình tên miền và HTTPS.
- Phát triển ứng dụng di động hoặc Progressive Web App.
- Thêm thông báo thời gian thực bằng WebSocket.
- Tự động sinh công việc theo chu kỳ lặp lại.
- Tích hợp AI để gợi ý sắp xếp và ưu tiên công việc.
- Bổ sung báo cáo, thống kê hiệu suất làm việc nâng cao.
- Bổ sung phân quyền theo nhóm, phòng ban hoặc workspace.

---


---

Dự án được xây dựng phục vụ mục đích học tập, nghiên cứu và báo cáo học phần.
