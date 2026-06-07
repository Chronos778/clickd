# Clickd

A private group photo-sharing app for Android, built with **Flutter** and powered by **Supabase**.

Clickd makes it effortless to share photos with the people who matter — your friend group, your family, your travel crew. Take a photo with your normal Android camera and Clickd instantly detects it and asks if you want to share it to a group.

---

## Features

| Feature | Description |
|---|---|
| **Auto-Detect Service** | A native Kotlin Foreground Service with a `ContentObserver` watches for new photos taken with the device camera and prompts you to share them to a Clickd group — no need to open the app first. |
| **Google Sign-In** | One-tap authentication via Google, using Supabase Auth with OAuth ID tokens. |
| **Masonry Feed** | A beautiful staggered grid powered by `flutter_staggered_grid_view` displays all group photos with pre-calculated aspect ratios to avoid layout jank. |
| **Full-Screen Viewer** | Pinch-to-zoom, swipe between photos, save to device, and share to other apps. |
| **Smart Upload Pipeline** | MD5 deduplication → WebP compression (thumbnail + full) → device gallery save → Supabase Storage upload → signed URL generation → database insert. |
| **Automatic Cleanup** | PostgreSQL `pg_cron` triggers automatically clean up Supabase Storage once every member in a group has downloaded a photo. |
| **Push Notifications** | Firebase Cloud Messaging (via Supabase Edge Functions / Postgres webhooks) notifies group members when new photos are shared. |
| **Offline-First Caching** | Hive-based local storage for feed cache, upload queue, and deduplication hashes. |

---

## Tech Stack

| Layer | Technology |
|---|---|
| **Framework** | Flutter (Dart) |
| **State Management** | Riverpod |
| **Routing** | GoRouter |
| **Backend** | Supabase (PostgreSQL + Storage + Auth + Edge Functions) |
| **Authentication** | Google Sign-In → Supabase Auth (OAuth) |
| **Push Notifications** | Firebase Cloud Messaging + `flutter_local_notifications` |
| **Background Work** | Native Kotlin Foreground Service + WorkManager |
| **Local Storage** | Hive |
| **Code Generation** | Freezed + JSON Serializable |
| **Image Handling** | `flutter_image_compress`, `cached_network_image`, `photo_manager` |

---

## Project Structure

```
clickd/
├── android/
│   └── app/src/main/kotlin/com/clickd/clickd/
│       ├── MainActivity.kt              # Flutter ↔ Kotlin method channel bridge
│       └── PhotoDetectionService.kt     # Native foreground service (ContentObserver)
├── lib/
│   ├── main.dart                        # App entry point (Firebase + Supabase init)
│   └── src/
│       ├── core/
│       │   ├── models/                  # Freezed data models (Group, Photo, User)
│       │   ├── router/app_router.dart   # GoRouter configuration with auth guards
│       │   └── theme/app_theme.dart     # Material 3 theme
│       ├── features/
│       │   ├── auth/                    # Google Sign-In + auth state providers
│       │   ├── camera/                  # In-app camera screen
│       │   ├── feed/                    # Library, masonry grid, full-screen viewer
│       │   ├── profile/                 # User profile screen
│       │   └── upload/                  # Gallery picker + group selection sheet
│       └── services/
│           ├── background/              # WorkManager periodic photo detection
│           ├── firebase/                # FCM messaging service
│           ├── local/                   # Hive storage + native service manager
│           └── supabase/                # Upload pipeline + Supabase config
├── pubspec.yaml
└── README.md
```

---

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (≥ 3.11.4)
- Android Studio or VS Code with Flutter plugin
- A physical Android device (camera features require real hardware)
- A [Supabase](https://supabase.com/) project
- A [Firebase](https://console.firebase.google.com/) project (for push notifications)
- Google Cloud Console access (for OAuth client ID)

### 1. Clone the Repository

```bash
git clone https://github.com/Chronos778/clickd.git
cd clickd
```

### 2. Supabase Setup

1. Create a [Supabase](https://supabase.com/) project.
2. Go to the **SQL Editor** and run the database schema to create tables (`groups`, `photos`, `users`), RLS policies, triggers, and `pg_cron` cleanup jobs.
3. Create a storage bucket named **`groups`** with appropriate RLS policies.
4. Copy your **Project URL** and **Anon Key** from **Settings → API**.
5. Create the credentials file:
   ```bash
   cp lib/src/services/supabase/supabase_options_placeholder.dart \
      lib/src/services/supabase/supabase_options.dart
   ```
6. Edit `supabase_options.dart` and paste in your real URL and anon key.

### 3. Firebase Setup

1. Create a Firebase project and add an Android app with package name `com.clickd.clickd`.
2. Download `google-services.json` and place it in `android/app/`.
3. Create the Firebase options file:
   ```bash
   cp lib/src/services/firebase/firebase_options_placeholder.dart \
      lib/src/services/firebase/firebase_options.dart
   ```
4. Edit `firebase_options.dart` with your real Firebase config values.

### 4. Google Sign-In Setup

1. In [Google Cloud Console](https://console.cloud.google.com/), configure an **OAuth consent screen**.
2. Create a **Web Client ID** (required by Supabase for the server-side token exchange).
3. Place the Web Client ID in `lib/src/features/auth/login_screen.dart` (the `webClientId` constant).
4. Add the Supabase callback URL to the authorized redirect URIs:
   ```
   https://<your-project-ref>.supabase.co/auth/v1/callback
   ```

### 5. Install Dependencies & Run

```bash
flutter pub get
flutter run
```

> **Note:** If you modify any Freezed models, regenerate code with:
> ```bash
> dart run build_runner build --delete-conflicting-outputs
> ```

---

## Architecture

The app follows a **feature-first** architecture with clear separation of concerns:

```
Features → Services → Backend
   ↑           ↑
   └── Core ───┘
```

- **Features** contain UI screens and feature-specific Riverpod providers.
- **Services** handle all external integrations (Supabase, Firebase, native platform, local storage).
- **Core** provides shared data models, routing, and theming.

### Native Bridge

The app uses a **MethodChannel** (`com.clickd.clickd/background_service`) to communicate between Flutter and a native Kotlin `Foreground Service`. The service uses a `ContentObserver` to watch `MediaStore.Images` for new photos in real-time — no polling, no battery drain.

---

## Security

- **Supabase RLS**: All database tables are protected with Row Level Security policies — users can only access data from groups they belong to.
- **Signed URLs**: Storage objects use time-limited signed URLs (24h expiry) instead of public access.
- **Secrets Management**: All API keys and credentials are excluded from version control via `.gitignore`. Only placeholder files are committed to the repo.

---

## License

This is a private project. All rights reserved.
