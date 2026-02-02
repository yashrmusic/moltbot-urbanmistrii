# HEARTBEAT.md

- Every 30 minutes, run the command `python3 /app/urbanmistrii_mail.py`, then read the file `/app/workspace/email_inbox.json`. If there are new unread emails, summarize them and message the user on WhatsApp.
- Every hour, run the command `python3 /app/urbanmistrii_drive.py`. Read `/app/workspace/drive_pipeline.json`. If new projects are detected, analyze the imagery using the Narrative Generator and draft an Instagram caption. Message the user with the draft for approval.
