import requests
import json
import os

# Configuration from environment variables
DRIVE_WEBAPP_URL = os.getenv("DRIVE_WEBAPP_URL")

def sync_drive_pipeline():
    if not DRIVE_WEBAPP_URL:
        print("❌ Error: DRIVE_WEBAPP_URL not set.")
        return None
    
    try:
        print(f"Fetching updates from Drive Pipeline...")
        response = requests.get(DRIVE_WEBAPP_URL)
        response.raise_for_status()
        data = response.json()
        
        # Discovery workspace path
        if os.path.exists("/app/workspace"):
            workspace_dir = "/app/workspace"
        else:
            workspace_dir = os.path.join(os.getcwd(), "workspace")
            
        os.makedirs(workspace_dir, exist_ok=True)
        output_path = os.path.join(workspace_dir, "drive_pipeline.json")
        
        with open(output_path, "w") as f:
            json.dump(data, f, indent=2)
            
        print(f"✅ Drive sync complete. Found {len(data) if isinstance(data, list) else 0} items.")
        return data
    except Exception as e:
        print(f"❌ Drive sync failed: {e}")
        return {"error": str(e)}

if __name__ == "__main__":
    sync_drive_pipeline()
