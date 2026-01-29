/**
 * URBANMISTRII Drive Watcher
 * This script runs in Google Apps Script and interfaces with Moltbot via clasp.
 */

const FOLDER_NAME = 'URBANMISTRII_PIPELINE';

/**
 * Fetches new images from the pipeline folder.
 * Returns an array of file objects {id, name, url, description}.
 */
function getNewImages() {
  const folders = DriveApp.getFoldersByName(FOLDER_NAME);
  if (!folders.hasNext()) {
    return { error: `Folder "${FOLDER_NAME}" not found.` };
  }
  
  const folder = folders.next();
  const files = folder.getFiles();
  const imageList = [];
  
  while (files.hasNext()) {
    const file = files.next();
    // Only process images
    if (file.getMimeType().startsWith('image/')) {
      imageList.push({
        id: file.getId(),
        name: file.getName(),
        url: file.getDownloadUrl(),
        created: file.getDateCreated()
      });
    }
  }
  
  return imageList;
}

/**
 * Example of how Moltbot will call this:
 * clasp run getNewImages
 */
