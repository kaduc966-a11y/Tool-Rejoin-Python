# Ka Rejoin Python v2.0

[![Discord](https://img.shields.io/badge/Discord-Join%20Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/2rWZxb3p27)

> Tool Auto Rejoin Roblox phiên bản Python - Chạy trên Termux (Android)

---

## 🚀 Cài đặt nhanh (1 lệnh)

Mở **Termux** và chạy:

```bash
. <(curl -sL https://raw.githubusercontent.com/kaduc966-a11y/Tool-Rejoin-Python/main/setup.sh)
```

Script sẽ tự động:
- ✅ Cài đặt Python & pip
- ✅ Cài đặt các thư viện cần thiết (requests, psutil)
- ✅ Cài đặt Termux packages (tsu, sqlite, wget, grep, procps, termux-api)
- ✅ Tải tool về `~/rejoin-python`
- ✅ Tạo alias `run` để chạy nhanh
- ✅ Setup Termux:Boot (auto-start)

---

## ▶️ Chạy Tool

Sau khi cài đặt, chỉ cần gõ:

```bash
run
```

Hoặc:

```bash
cd ~/rejoin-python
bash run.sh
```

---

## 📋 Yêu cầu

- **Termux** (Android) - [Tải từ F-Droid](https://f-droid.org/repo/com.termux_1022.apk)
- **Termux:Boot** (tùy chọn, để auto-start) - [Tải từ F-Droid](https://f-droid.org/repo/com.termux.boot_1000.apk)
- **Root** (khuyến khích) - Cần để force-stop/launch app Roblox

---

## ⭐ Tính năng

### Core
- 🔄 **Auto Rejoin** — Tự động phát hiện kick/disconnect/crash và rejoin game
- 🍪 **Login via Cookie** — Đăng nhập bằng `.ROBLOSECURITY` cookie
- 📦 **Multi-package** — Hỗ trợ nhiều bản Roblox clone cùng lúc
- 🔍 **Smart Detection** — Kết hợp Logcat + Lua heartbeat + API Presence
- 📊 **Webhook Discord** — Thông báo trạng thái rejoin realtime
- 🛡️ **Whitelist System** — Bảo vệ bằng License Key + HWID

### Mới trong bản Python
- 🐍 **Python Native** — Không cần cài Java/JDK, nhẹ hơn
- ⚡ **Khởi động nhanh** — Không cần JVM startup time
- 📱 **Tối ưu Termux** — Tiết kiệm RAM và pin hơn bản Java
- 🔐 **Mã hóa DH** — Diffie-Hellman Key Exchange bảo mật

---

## 🔧 Cấu hình

File config: `rejoin-config.properties`

| Thuộc tính | Mô tả | Mặc định |
|---|---|---|
| `license_key` | License key của bạn | _(nhập khi chạy)_ |
| `whitelist_server_url` | URL server xác thực | `http://localhost:8080/api/verify` |
| `package_prefixes` | Prefix package Roblox | `roblox,delta` |
| `delay_seconds` | Delay giữa các lần check | `3` |
| `join_method` | Phương thức join | `deeplink_package` |
| `force_stop` | Force stop trước khi rejoin | `true` |

---

## 🔄 Cập nhật

Chạy lại lệnh setup để cập nhật:

```bash
. <(curl -sL https://raw.githubusercontent.com/kaduc966-a11y/Tool-Rejoin-Python/main/setup.sh)
```

---

## 📞 Hỗ trợ

- Discord: [https://discord.gg/2rWZxb3p27](https://discord.gg/2rWZxb3p27)
