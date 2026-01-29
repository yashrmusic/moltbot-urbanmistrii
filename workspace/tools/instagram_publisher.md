# Instagram Publisher Skill

## commands

### `post_instagram`
Publishes an image and caption to the URBANMISTRII Instagram account using the Graph API.

**Arguments**:
- `image_url` (string): Direct public URL of the image (must be accessible by Facebook servers).
- `caption` (string): The architectural narrative to post.

**Handler Integration**:
Currently configured to run the local Python script:
```powershell
python C:/app/urbanmistrii_instagram.py "{image_url}" "{caption}"
```
*(Note: Paths will adjust based on Docker env)*

## Usage Instructions for Agent
1. **Validation**: Ensure the caption is within 2200 characters and has <30 hashtags.
2. **Quality Check**: Verify the `image_url` is a valid JPEG/PNG.
3. **Execution**: Run the command and report the result (Success/Fail) to the user via WhatsApp.
