# Email Management Tool - URBANMISTRII

## Objective
Monitor and manage `mail@urbanmistrii.com` and `hr@urbanmistrii.com` with brand-specific intelligence.

## Instructions
1. **Context Awareness**: 
   - `mail@urbanmistrii.com`: General inquiries, design collaborations, and press. Tone should be architectural and visionary.
   - `hr@urbanmistrii.com`: Job applications, internships, and internal team coordination. Tone should be professional, welcoming, and organized.

2. **Action Logic**:
   - **Inbound**: Check for new emails every 15 minutes.
   - **Categorize**: Group by "High Priority" (Client Inquiry), "Recruitment" (HR), and "Updates".
   - **Drafting**: Auto-draft replies using the URBANMISTRII "Soul" profile. Save as drafts instead of auto-sending unless explicitly told "Go full beast mode on email."
   - **Notification**: Summarize critical emails and send them to the USER via WhatsApp.

3. **Security**:
   - Do not share sensitive architectural drawings or personal data via WhatsApp summaries.
   - Keep summaries high-level (e.g., "Received an inquiry from [Name] regarding a residential project in [Location]").

4. **Integration**:
   - Use IMAP/SMTP skills or Google Apps Script (GAS) via `clasp` to interface with the mailboxes.
