# Email Commands Skill

## commands

### `check_email`
Runs the `urbanmistrii_mail.py` script to fetch the latest unread emails from `mail@urbanmistrii.com` and `hr@urbanmistrii.com`.

**Handler**: 
```powershell
python C:/app/urbanmistrii_mail.py
```
*(Path adjusted for Docker/Railway deployment)*

### `reply_email`
Sends a reply from a specific mailbox.
**Arguments**: `to`, `subject`, `body`, `from_account`.

---

## Instructions for Agent
- Always run `check_email` if the user asks "any new emails?" or "check hr mailbox".
- Read `workspace/email_inbox.json` to see the results of the check.
- Provide a summary of senders and subjects.
