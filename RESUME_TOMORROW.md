# 🏛️ Molt-Mistrii Resume Guide: AWS Activation Phase

## 📍 Current Infrastructure
- **Cloud Provider**: AWS EC2 (t2.micro)
- **Public IP**: `54.174.12.251`
- **User**: `ec2-user`
- **Key**: `moltbot-key.pem`
- **Status**: Bot code is installed at `~/moltbot-urbanmistrii`, but currently hitting Disk/Dependency limits.

## 🛠️ Step 1: Disk Space (AWS Console)
1. Go to AWS Console -> EC2 -> Volumes.
2. Modify the volume from **8 GiB** to **30 GiB**.
3. In the EC2 Terminal, run:
   ```bash
   sudo xfs_growfs -d /
   ```

## 🛠️ Step 2: Browser Dependencies
The bot needs these libraries to launch WhatsApp (Chromium):
```bash
sudo yum install -y alsa-lib at-spi2-atk at-spi2-core atk cairo cups-libs dbus-libs expat gdk-pixbuf2 glib2 gtk3 libX11 libXcomposite libXcursor libXdamage libXext libXfixes libXi libXrandr libXrender libXtst libdrm libuuid pango xorg-x11-server-utils libgbm libasound
```

## 🛠️ Step 3: Link WhatsApp
1. Start/Restart the bot:
   ```bash
   pm2 delete moltbot
   export NODE_OPTIONS="--max-old-space-size=1024"
   cd ~/moltbot-urbanmistrii
   pm2 start npm --name "moltbot" -- start --update-env
   ```
2. View Log for QR Code:
   ```bash
   pm2 logs moltbot --raw
   ```
3. **Scan the QR code with WhatsApp.**

## 🛠️ Step 4: Skills Check
- **Email**: Test `mail@` and `hr@` oversight.
- **Instagram**: Provide `IG_USER_ID` and `ACCESS_TOKEN` to test the publisher.

Rest well, Content Director. Tomorrow, URBANMISTRII goes fully autonomous. 🏛️🌩️
