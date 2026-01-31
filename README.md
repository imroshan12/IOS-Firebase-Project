# 🔐 Firebase methods – SwiftUI

An iOS application built using **SwiftUI** that demonstrates different **Firebase Authentication**
with multiple sign-in methods including Email, Google, and Apple.

---

## ✨ Features

- SwiftUI-based UI
- Firebase Authentication
- Email & Password login
- Google Sign-In
- Sign in with Apple
- Secure authentication flow
- Clean and modular architecture

---

## 🛠 Tech Stack

- SwiftUI
- Firebase Authentication
- Firebase iOS SDK
- Google Sign-In
- Sign in with Apple
- Xcode (latest stable)

---

## 📂 Project Structure

Login Project  
- Login Project  
  - App  
  - Views  
  - ViewModels  
  - Services  
  - Utils  
  - Resources  
- Login Project.xcodeproj  
- .gitignore  
- README.md  

---

## 🔑 Authentication Methods

### Email & Password
- User registration
- User login
- Firebase-managed password security

### Google Sign-In
- OAuth-based authentication
- Integrated with Firebase Auth

### Sign in with Apple
- Secure Apple authentication
- Uses Apple identity token with Firebase

---

## 🚀 Getting Started

### Prerequisites

- macOS
- Xcode (latest version)
- Firebase account
- Apple Developer account (required for Apple Sign-In)

---

## 🔧 Firebase Setup

1. Create a Firebase project in Firebase Console
2. Add an iOS app to the project
3. Download GoogleService-Info.plist
4. Add it to the app target folder in Xcode
5. Enable Authentication providers:
   - Email/Password
   - Google
   - Apple

⚠️ GoogleService-Info.plist is not committed to the repository.

---

## 🔐 Ignored Files

The following files are excluded using `.gitignore`:

- GoogleService-Info.plist
- .env
- Secrets.plist

Create your own local configuration files before running the app.

---

## ▶️ Running the App

1. Open the project in Xcode
2. Select a simulator or physical device
3. Press Cmd + R to build and run

---

## 🧠 Security Notes

- Firebase Security Rules must be configured properly
- Client-side API keys are not secrets
- Never commit Firebase Admin SDK or service account keys
- Authentication is validated server-side by Firebase

---

## 📌 Future Enhancements

- Password reset flow
- Email verification
- User profile screen
- Multi-factor authentication (MFA)
- Improved error handling and alerts

---

## 🤝 Contributing

Pull requests are welcome.  
For major changes, please open an issue first.

---

## 📜 License

This project is licensed under the MIT License.

---

## 👤 Author

Sarvesh Roshan  
iOS / React Native Developer

