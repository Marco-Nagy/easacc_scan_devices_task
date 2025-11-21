# 📱 EASACC Scan Devices Task
A Flutter mobile application that scans nearby Wi-Fi Direct & Bluetooth devices, with integrated Google & Facebook authentication, following Clean Architecture and MVVM.

---

## 🎥 Demo (GIF)

![App Demo](https://github.com/user-attachments/assets/fa4da43b-f1d2-4e70-a81e-9deaa974743f)

---

## 🏗 Project Structure

```
lib/
│
├── core/
│   ├── errors/
│   ├── network/
│   ├── utils/
│   ├── extensions/
│   └── widgets/
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── scan_devices/
│       ├── data/
│       │   ├── models/
│       │   ├── datasource/
│       │   └── repositories/
│       │
│       ├── domain/
│       │   ├── entities/
│       │   ├── usecases/
│       │   └── repositories/
│       │
│       └── presentation/
│           ├── view/
│           ├── widget/
│           ├── controller/
│           └── state/
│
└── main.dart
```

---

## ⚙️ Used Technologies

### **Framework**
- Flutter (Dart)

### **Architecture & Patterns**
- Clean Architecture
- MVVM
- Repository Pattern
- UseCase Pattern
- Dependency Injection (get_it)
- Bloc / Cubit for state management

### **Features / Integrations**
- Google Sign-In (Firebase Auth)
- Facebook Login
- Wi-Fi Direct scanning
- Bluetooth scanning
- Unified device model
- Custom dropdown with deduplication

---

## 🧠 Architecture Breakdown

### **1. Clean Architecture Layers**
#### **Domain Layer**
- Business logic
- Entities
- UseCases
- Repository contracts

#### **Data Layer**
- Models
- Data sources (Wi-Fi, Bluetooth, Firebase)
- Repository implementation

#### **Presentation Layer**
- UI Screens
- Widgets
- ViewModels (Cubit)
- State classes

---

## 🚀 Features

### 🔍 Device Scanning
- Wi-Fi Direct detection
- Bluetooth devices detection
- Mapped into a unified `NetworkDevice` model

### 📡 Device Selection
- Custom dropdown
- Ensures unique items
- Smooth UX

### 🔐 Authentication
- Google Sign-in
- Facebook login
- Firebase Auth integration
- Handles login success/error states
- Auto-navigation after login

### 🧩 Robust Structure
- Highly scalable
- Testable logic
- Easy to extend with new modules

---

## 🛠 How to Run

1. Install dependencies:
```bash
flutter pub get
```

2. Run the project:
```bash
flutter run
```

3. Add required platform configs:

### **Android:**
- Add `google-services.json` in `android/app/`
- Add to `android/app/src/main/res/values/strings.xml`:
```xml
<string name="facebook_app_id">YOUR_FACEBOOK_APP_ID</string>
<string name="facebook_client_token">YOUR_FACEBOOK_CLIENT_TOKEN</string>
```

- Make sure debug and release SHA keys are added to Firebase.



---

## 👤 Developer

**Marco Nagy**  
Flutter Developer  
📩 marconbishay@gmail.com 
📱 +20 122 040 7005
LinkedIn | https://www.linkedin.com/in/marco-nagy/
GitHub | https://github.com/Marco-Nagy

---
