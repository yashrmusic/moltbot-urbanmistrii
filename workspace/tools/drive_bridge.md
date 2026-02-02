# 🌉 The Google Drive Bridge

## ❓ Why use Apps Script with Zeabur?
Your bot lives on **Zeabur**, but your files live in **Google Drive**. Connecting them directly is hard because:
1.  **Complexity**: Google's official API requires OAuth2, consent screens, and token refreshes.
2.  **Permissions**: Sharing folders with "Service Accounts" is annoying.

## 🛠️ The Solution: Apps Script as a "Bridge"
We use a small script (`UrbanMistriiDrive.js`) that lives *inside* your Google account. It acts as a friendly "Waiter" for your bot.

1.  **Google Drive**: Holds your architectural images.
2.  **Apps Script (The Bridge)**: 
    - Has native access to your Drive (no passwords needed).
    - Checks the folder for new files.
    - Publishes a simple list at a **Web App URL**.
3.  **Zeabur (The Bot)**: 
    - Simply visits that URL (like opening a webpage) to see what's new.
    - Downloads the images and writes captions.

## 🚀 How to set it up
1.  Go to [script.google.com](https://script.google.com/home).
2.  Create a new project and paste the code from `UrbanMistriiDrive.js`.
3.  Click **Deploy** -> **New Deployment**.
4.  Select type: **Web App**.
5.  **Who has access**: Set to **"Anyone"** (This allows the Zeabur bot to see it without logging in).
6.  Copy the **Web App URL** (starts with `https://script.google.com/macros/s/...`).
7.  Paste this URL into Zeabur's Environment Variables as `DRIVE_WEBAPP_URL`.
