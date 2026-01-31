import imaplib
import smtplib
import email
from email.mime.text import MIMEText
import json
import os

# URBANMISTRII Email Configuration
ACCOUNTS = {
    "mail@urbanmistrii.com": os.getenv("EMAIL_PASS_MAIL"),
    "hr@urbanmistrii.com": os.getenv("EMAIL_PASS_HR")
}

IMAP_SERVER = "imap.gmail.com"  # Google Workspace uses standard Gmail servers
SMTP_SERVER = "smtp.gmail.com"

def get_unread_emails(user, password):
    try:
        mail = imaplib.IMAP4_SSL(IMAP_SERVER)
        mail.login(user, password)
        mail.select("inbox")
        
        status, messages = mail.search(None, 'UNSEEN')
        email_ids = messages[0].split()
        
        unread_emails = []
        for e_id in email_ids:
            res, msg = mail.fetch(e_id, "(RFC822)")
            for response in msg:
                if isinstance(response, tuple):
                    msg_obj = email.message_from_bytes(response[1])
                    subject = msg_obj["subject"]
                    sender = msg_obj["from"]
                    date = msg_obj["date"]
                    
                    body = ""
                    if msg_obj.is_multipart():
                        for part in msg_obj.walk():
                            if part.get_content_type() == "text/plain":
                                body = part.get_payload(decode=True).decode()
                                break
                    else:
                        body = msg_obj.get_payload(decode=True).decode()
                    
                    unread_emails.append({
                        "id": e_id.decode(),
                        "sender": sender,
                        "subject": subject,
                        "date": date,
                        "preview": body[:500] + "..." if len(body) > 500 else body
                    })
        
        mail.logout()
        return unread_emails
    except Exception as e:
        return {"error": str(e)}

def send_email(user, password, to, subject, body):
    try:
        msg = MIMEText(body)
        msg['Subject'] = subject
        msg['From'] = user
        msg['To'] = to
        
        with smtplib.SMTP_SSL(SMTP_SERVER, 465) as server:
            server.login(user, password)
            server.send_message(msg)
        return {"status": "success"}
    except Exception as e:
        return {"error": str(e)}

if __name__ == "__main__":
    # Example action: poll all accounts
    results = {}
    for account, pwd in ACCOUNTS.items():
        print(f"Checking {account}...")
        results[account] = get_unread_emails(account, pwd)
    
    # Save results to workspace for Moltbot to read
    # Save results to workspace for Moltbot to read
    workspace_path = os.path.join(os.path.expanduser("~"), "moltbot-urbanmistrii", "workspace", "email_inbox.json")
    with open(workspace_path, "w") as f:
        json.dump(results, f, indent=2)
    
    print(f"Sync complete. Found {sum(len(v) if isinstance(v, list) else 0 for v in results.values())} new emails.")
