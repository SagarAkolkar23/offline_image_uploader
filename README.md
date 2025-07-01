# 📷 Offline Image Uploader (Flutter)

A Flutter application that allows users to upload images even without internet connectivity.  
If the device is offline, the app stores selected images in memory and automatically uploads them when the connection is restored. Ideal for remote use cases or unreliable network conditions.

---

## 🚀 Project Overview

This project was developed as part of an internship assignment to demonstrate skills in:

- Media file handling
- Offline-first approach
- State management using Provider
- Flutter UI development
- Integration with mock backend via multipart/form-data

---

## ✨ Features

✅ Select image from gallery  
✅ Handle offline scenarios — stores image in memory  
✅ Auto upload on internet reconnect  
✅ Upload progress & status (Pending, Uploading, Success, Failed)  
✅ Retry upload for failed items  
✅ Local notification on successful upload  
✅ Clean and responsive UI

---

## 📁 Folder Structure

lib/
│
├── main.dart # Entry point
│
├── models/
│ └── upload_image_model.dart # Image model with status enum
│
├── services/
│ └── upload_service.dart # Multipart upload service
│
├── state/
│ └── image_upload_provider.dart # Provider for in-memory image list & upload logic
│
└── screens/
└── home_screen.dart # UI screen with image list and upload UI

---

## 🧰 Tech Stack

| Purpose              | Tool / Package                  |
|----------------------|---------------------------------|
| UI Framework         | Flutter                         |
| State Management     | Provider                        |
| Connectivity         | connectivity_plus               |
| Image Selection      | image_picker                    |
| HTTP Requests        | http                            |
| Notifications        | flutter_local_notifications     |
| Upload Destination   | Webhook.site (or httpbin.org)   |

---

## 📸 Screenshots


- ✅ Image Picker Interface  
- 📤 Upload Status Tracker  
- 🔄 Auto Upload on Internet Reconnect  
- 🔁 Retry Button for Failed Uploads  

```md
![Pick Image](assets/screenshots/Pick_Image.jpg)
![Upload List](assets/screenshots/Upload_Image.jpg)
