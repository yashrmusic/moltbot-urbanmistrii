import requests
import sys
import json
import time

# Placeholder Config - Will be replaced by Environment Variables in production
IG_USER_ID = "YOUR_IG_USER_ID"
ACCESS_TOKEN = "YOUR_LongLived_ACCESS_TOKEN"

BASE_URL = "https://graph.facebook.com/v21.0"

def upload_image(image_url, caption):
    """Step 1: Upload the image to Instagram's staging container."""
    url = f"{BASE_URL}/{IG_USER_ID}/media"
    payload = {
        "image_url": image_url,
        "caption": caption,
        "access_token": ACCESS_TOKEN
    }
    
    print(f"Uploading image: {image_url}...")
    response = requests.post(url, data=payload)
    result = response.json()
    
    if "id" in result:
        return result["id"]
    else:
        print(f"Error uploading: {result}")
        return None

def publish_container(creation_id):
    """Step 2: Publish the staged container."""
    url = f"{BASE_URL}/{IG_USER_ID}/media_publish"
    payload = {
        "creation_id": creation_id,
        "access_token": ACCESS_TOKEN
    }
    
    print(f"Publishing container {creation_id}...")
    response = requests.post(url, data=payload)
    result = response.json()
    
    if "id" in result:
        return result["id"]
    else:
        print(f"Error publishing: {result}")
        return None

def post_to_instagram(image_url, caption):
    # 1. Create Container
    creation_id = upload_image(image_url, caption)
    if not creation_id:
        return {"status": "error", "message": "Failed to upload image container"}
    
    # Wait for processing (important!)
    time.sleep(5)
    
    # 2. Publish
    publish_id = publish_container(creation_id)
    if publish_id:
        return {"status": "success", "post_id": publish_id, "url": f"https://instagram.com/p/{publish_id}"}
    else:
        return {"status": "error", "message": "Failed to publish container"}

if __name__ == "__main__":
    # CLI Usage: python urbanmistrii_instagram.py <image_url> <caption>
    if len(sys.argv) < 3:
        print("Usage: python urbanmistrii_instagram.py <image_url> <caption>")
        sys.exit(1)
        
    img_url = sys.argv[1]
    cap_text = sys.argv[2]
    
    result = post_to_instagram(img_url, cap_text)
    print(json.dumps(result, indent=2))
