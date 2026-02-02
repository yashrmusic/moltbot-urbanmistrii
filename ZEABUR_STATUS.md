# 🚀 Zeabur Deployment Status: UrbanMistrii Content Bot

## 🟢 Deployment Summary
- **Platform**: Zeabur
- **Deployment Method**: Docker (Dockerfile)
- **Status**: Ready / Active
- **Model**: `gemini-1.5-flash` (Optimized for cost and speed)

## 🔑 Required Zeabur Environment Variables
Ensure these are set in your Zeabur Dashboard for the project:

| Variable | Value / Description |
|----------|---------------------|
| `GEMINI_API_KEY` | `AIzaSyCnmerxwYYt0vHPM6BWhxGljS2NRhzPpOM` |
| `EMAIL_PASS_MAIL` | Your password for `mail@urbanmistrii.com` |
| `EMAIL_PASS_HR` | Your password for `hr@urbanmistrii.com` |
| `IG_USER_ID` | Your Instagram Business Account ID |
| `IG_ACCESS_TOKEN` | Your Meta Long-Lived Access Token |
| `DRIVE_WEBAPP_URL` | The URL from your UrbanMistriiDrive Apps Script |

## 📲 WhatsApp Linkage (CRITICAL)
1. Go to your **Zeabur Dashboard**.
2. Select your `urbanmistrii-content-bot` service.
3. Click on the **Logs** tab.
4. Watch for a **QR Code** to appear in the terminal logs.
5. **Scan it immediately** using WhatsApp on your phone (Linked Devices).

## 💓 Heartbeat & Automation
The bot is now configured to:
- **Check Emails**: Every 30 minutes via `urbanmistrii_mail.py`.
- **Sync Drive**: Every hour via `urbanmistrii_drive.py`.
- **Proactive Notifications**: Message you on WhatsApp for new inquiries or projects detected.
- **Content Creation**: Await your instructions via WhatsApp to generate or publish content.

---
*Status tracked by Antigravity AI*
