# 🏛️ UrbanMistrii Bot Ecosystem - Master Map

This document serves as the high-level map of the entire automation infrastructure.

## 📂 Project Structure

### 1. 🎭 Content Director (`urbanmistrii-content-bot`)
**Path**: `c:\Users\Asus\.gemini\antigravity\scratch\urbanmistrii-content-bot`
**Host**: **Zeabur** (Cloud Container)
**Role**: "Shaktiman" - The Creative Director.
- **Goal**: Autonomous content publishing (Drive -> Caption -> Instagram).
- **Key Files**:
    - `start.sh`: Boot script for Zeabur.
    - `workspace/HEARTBEAT.md`: The automation schedule.
    - `urbanmistrii_drive.py`: Google Drive "Bridge" client.
    - `urbanmistrii_instagram.py`: Instagram API publisher.
- **Current Status**: **ACTIVE (Deployment Phase)**.
- **Next Step**: Connect Google Apps Script URL.

### 2. 📝 Recruitment Manager (`admin-aws-recruiter-urbanmistrii`)
**Path**: `c:\Users\Asus\.gemini\antigravity\scratch\admin-aws-recruiter-urbanmistrii`
**Host**: **Local / AWS EC2** (Dashboard)
**Role**: "Admin" - The HR Manager.
- **Goal**: Hiring automation, Offer generation, LinkedIn management.
- **Key Files**:
    - `app.py`: The FastAPI backend.
    - `static/index.html`: The "UrbanMistrii Admin" Dashboard UI.
    - `offer_engine.py`: PDF Offer Letter generator.
- **Current Status**: **STABLE (V2.0)**.
- **Next Step**: Resume LinkedIn automation cycle.

---

## 🌉 The Integration
The two bots are separate but can talk via WhatsApp (future state).
- **Content Bot** lives in the cloud to run 24/7 for low cost.
- **Admin Bot** lives locally/VPS to manage heavy browser tasks securely.

*Context saved: 2026-02-02*
