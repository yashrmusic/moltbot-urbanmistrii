---
name: instagram-publisher
description: Publish content directly to URBANMISTRII Instagram account.
---

# Instagram Publisher

This skill interfaces with the Meta Graph API to publish images and captions.

## Commands
- `/post [image_url] [caption]` - Upload and publish a post.
- `/draft [image_url] [caption]` - Create a draft for approval (saved in workspace).

## Config
- Uses `IG_USER_ID` and `IG_ACCESS_TOKEN` from environment variables.
