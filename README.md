# 🍳 BiteMe

A Tinder-style recipe discovery app for iOS, built with SwiftUI. Swipe right to save recipes you love, left to skip — then organize your saved recipes into custom "Menus" (think Spotify playlists, but for food).

---

## 📱 Core Concept

- **Swipe right** → save a recipe
- **Swipe left** → discard a recipe
- **Menus** → user-created collections of saved recipes, totally separate from the swipe action itself (you save first, organize later)

Recipe data is sourced from [TheMealDB API](https://www.themealdb.com/api.php).

---

## 🧰 Tech Stack

| Layer | Choice |
|---|---|
| UI Framework | SwiftUI |
| Architecture | MVVM (Model–View–ViewModel) |
| Data Source | TheMealDB API (free tier; production key pending) |
| Local Persistence | *TBD — to be confirmed in-app* |
| Dependencies | None yet — kept dependency-free by default |

> **Note:** This project intentionally avoids third-party packages unless there's a clear, well-justified reason. If you're contributing, please raise any new dependency for discussion first.

---

## 🎨 Design

**Theme:** Warm & cozy, herb-garden inspired.

| Color | Usage |
|---|---|
| Cream | Backgrounds |
| Terracotta | Primary accents / buttons |
| Herb Green | Save / positive actions |
| Mustard | Highlights / tags |
| Dark Coffee Brown | Text / headers |

---

## 🔑 Attribution

This app uses recipe data from **[TheMealDB](https://www.themealdb.com)**. Attribution is required and displayed within the app (see Settings / About screen).

---

## 🚧 Project Status

Early development. Currently building out:
- [ ] Swipe mechanic (save/discard)
- [ ] Recipe detail view
- [ ] Menus (custom collections)
- [ ] Local persistence for saved recipes & menus
- [ ] TheMealDB API integration (free tier)
- [ ] App Store submission readiness (privacy strings, Info.plist keys, Terms of Service)

---

## ⚠️ App Store Submission Notes

Tracking known submission requirements as they come up:

- [ ] Privacy usage strings (Info.plist) for any device features used (e.g. network access disclosures, if applicable)
- [ ] TheMealDB attribution visible somewhere in-app
- [ ] Terms of Service / Privacy Policy link (required if collecting any user data)
- [ ] Production API key from TheMealDB (currently pending via Patreon — free tier in use during development)

---

## 🛠 Setup

```bash
git clone <repo-url>
open BiteMe.xcodeproj
```

Requires Xcode (latest stable recommended) and iOS 17+ target (subject to change as features are finalized).

---

## 📖 Background / Maintainer Notes

This project is being built by a developer who is **not yet fluent in Swift or SwiftUI idioms** (e.g. `@State`, `@Observable`, `@Binding`, view models). Code in this repo favors:

- Simple, readable, idiomatic SwiftUI over clever/advanced patterns
- Explicit structure over abstraction, so the codebase stays maintainable by a single non-expert developer
- Comments explaining *why*, not just *what*, especially around Swift/Apple-specific conventions

If you're reviewing or contributing, please keep PRs simple and well-commented in this spirit.

---

## 📄 License

*TBD*
