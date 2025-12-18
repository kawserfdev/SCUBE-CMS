# SCUBE CMS Mobile

A Flutter app showcasing a SCUBE CMS dashboard, built with GetX and a feature-first architecture using reusable UI components.
---

## Features
Authentication flow with a login screen wired via GetX bindings.

Named route navigation managed by AppRoutes/AppPages.

Dashboard home with Summary, Single Line Diagram, and Data tabs.

Source data module with gauges, segmented controls, date filters, and revenue cards.

Centralized theming via core/constants and core/theme.

---

## Tech Stack
- Flutter (stable, null safety)
- GetX (state, navigation, UI)
- Dart + Material widgets

---

## Project Structure
```
lib/
  core/
    constants/   # colors, sizes, assets
    theme/       # light theme
    widgets/     # shared UI components
  features/
    auth/        # login screen + binding
    home/        # dashboard views, controllers, widgets
    sources/     # source data tabs, widgets, controllers
  routes/        # AppRoutes & AppPages
  bindings/      # initial binding
  main.dart      # app entrypoint
```

---

## Getting Started
### Prerequisites
- Flutter SDK (latest stable)
- Android Studio or VS Code
- Android emulator or physical device

### Install & Run
```bash
git clone https://github.com/kawserfdev/SCUBE-CMS.git
cd SCUBE-CMS
flutter pub get
flutter run

```

---

## Author
Kawser Ahmed — Flutter Developer
