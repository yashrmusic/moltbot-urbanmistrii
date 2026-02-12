# 🚀 Progress Tracker: UrbanMistrii Content Bot

## 🟢 Completed Milestones
- [x] **Core Identity**: Renamed project to `urbanmistrii-content-bot`.
- [x] **AI Upgrade**: Locked all models to `gemini-2.5-flash` (Gemini 1.5 is deprecated).
- [x] **Cloud Prep**: Created `Dockerfile` and `start.sh` optimized for Zeabur and EC2.
- [x] **AWS Deployment**: Expanded disk (30GB), fixed paths, and enabled as systemd service.
- [x] **WhatsApp Link**: Successfully connected WhatsApp (+919312943581).
- [x] **Skill: Narrative**: Created `narrative-engine` for architectural storytelling.
- [x] **Skill: Instagram**: Created `instagram-publisher` for posting.
- [x] **Automation**: Configured `HEARTBEAT.md` for Email (30m) and Drive (1h) checks.
- [x] **Bridge Code**: Created `UrbanMistriiDrive.js` and `urbanmistrii_drive.py` for Drive sync.

## 🟡 In Progress / Next Steps
- [ ] **Bridge Activation**: User needs to deploy the Apps Script and add `DRIVE_WEBAPP_URL` to Zeabur.
- [ ] **Instagram Credentials**: Verify `IG_USER_ID` and `IG_ACCESS_TOKEN` in Zeabur.
- [ ] **First Live Test**:
    1. Drop an image in Drive folder `URBANMISTRII_PIPELINE`.
    2. Wait 1 hour (or manually trigger).
    3. Bot detects image -> Generates caption -> Sends draft to WhatsApp.
    4. User replies "Valid" -> Bot posts to Instagram.

## 🔴 Blockers / Attention Needed
- **Apps Script URL**: We are waiting for the Web App URL from the deployment step.
- **Instagram Token**: Ensure the token is a "Long-Lived" token, otherwise it expires in an hour.

## 🌐 Deployment Status
| Environment | Status | Notes |
|---|---|---|
| **Local** | 🟡 In Progress | Currently testing WhatsApp connection |
| **AWS EC2** | 🟢 ACTIVE | Running as systemd service on 30GB volume. |
| **Zeabur** | 🟢 ACTIVE | Auto-deploying from GitHub. |

---
*Last Updated: 2026-02-02*
