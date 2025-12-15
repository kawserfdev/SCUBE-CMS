# 📱 Scube Flutter Assignment

A Flutter application developed as part of the **Flutter Developer recruitment task** for **Scube Technologies Ltd**.
The project follows **clean architecture**, **GetX state management**, and **pixel-perfect UI** implementation based on the provided Figma design.

---

## 🔗 Design References

* **Figma Design:** Provided by Scube Technologies Ltd
* **Figma Prototype:** Navigation and interaction flow followed exactly

---

## 🛠️ Tech Stack

* **Flutter** (Stable, Null Safety)
* **GetX**

  * State Management
  * Navigation
  * Dependency Injection
* **Dart**
* **Material UI**

---

## 🏗️ Project Architecture

The project uses a **feature-based clean architecture** with GetX:

```
lib/
├── core/
│   ├── constants/
│   ├── theme/
│   └── widgets/
├── features/
│   ├── home/
│   │   ├── controller/
│   │   ├── model/
│   │   ├── view/
│   │   └── widget/
├── routes/
├── bindings/
└── main.dart
```

---

## 🎨 UI Implementation

* Pixel-perfect UI matching Figma
* Responsive layouts
* Reusable custom widgets
* Centralized styling and theming

---

## 🚀 Getting Started

### Prerequisites

* Flutter SDK (latest stable)
* Android Studio / VS Code
* Android Emulator or Physical Device

---

### Installation

```bash
git clone <your-github-repo-link>
cd scubecms
flutter pub get
flutter run
```

---

## 🔄 State Management

* **GetX Controllers** handle business logic
* `Obx` widgets used only where reactive updates are required
* Clean separation of UI and logic

---

## 🧭 Navigation

* Implemented using **GetX named routes**
* Navigation flow strictly follows Figma Prototype

---

## 📸 Screenshots

Screenshots of all completed screens are attached separately as:

* PDF / Image files (as required)

---

## 📌 Notes

* Backend APIs were not provided; mock/static data is used where necessary
* The project focuses on **UI accuracy, code quality, and architecture**

---

## 👤 Author

**Kawser Ahmed**
Flutter Developer

---

Thank you for reviewing this assignment.
