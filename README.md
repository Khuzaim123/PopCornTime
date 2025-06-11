# PopCornTime 🍿

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-%23039BE5.svg?style=for-the-badge&logo=Firebase&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=Dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-blue.svg)

**PopCornTime** is a Flutter-based mobile app that lets movie enthusiasts browse, search, and save their favorite movies using the TMDB API and Firebase for authentication and data storage. Whether you're a movie buff exploring trailers or managing a watchlist, PopCornTime offers a seamless experience.

## Table of Contents
- [Features](#features)
- [Screenshots](#screenshots)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Roadmap](#roadmap)
- [Known Issues](#known-issues)
- [Changelog](#changelog)
- [FAQ](#faq)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Features
- **Search Movies or Actors**: Quickly find movies or actor profiles using the TMDB API.
- **Watch Movie Trailers**: Stream trailers directly with YouTube integration.
- **View Movie Details**: Access detailed movie info, including cast and synopsis.
- **Watchlist**: Save and manage watched movies stored in Firestore.
- **Rating Feature**: Rate movies and view community ratings.
- **Firebase Authentication**: Login/signup with email, social providers, or anonymously.
- **Actor Details**: Explore comprehensive actor profiles.

## Screenshots
| Home Screen | Movie Details | Watchlist |
|-------------|---------------|-----------|
| ![Home](screenshots/home.png) | ![Details](screenshots/details.png) | ![Watchlist](screenshots/watchlist.png) |

## Getting Started

### Prerequisites
- **Flutter SDK**: Version 3.7.0 or higher
- **Dart**: Version 3.7.0 or higher
- **Firebase CLI**: For Firebase setup
- **API Key**: Obtain a TMDB API key from [themoviedb.org](https://www.themoviedb.org/)
- **IDE**: Android Studio, VS Code, or similar
- Android/iOS emulator or physical device

### Installation
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/Khuzaim123/PopCornTime.git
   cd PopCornTime
2. **Install Dependencies**
   ```bash
   flutter pub get

3. **Set Up Firebase:**
- Create a Firebase project in the Firebase Console.
- Add your Android/iOS app and download google-services.json (Android)
- Place the files in android/app/ and ios/Runner/ respectively.
- Enable Authentication and Firestore in the Firebase Console.
- Configure Firebase:
  ```bash
    dart pub global activate flutterfire_cli
    flutterfire configure

4. **Configure TMDB API Key**
- Paste the api key into the Services/tmdb_services.dart

5. **Generate Assets:**
Run the command in terminal
   ```bash
   flutter pub run flutter_launcher_icons
    flutter pub run flutter_native_splash:create
6. **Run App**
   ```bash
   flutter run

### Lisence 
This project is licensed under the MIT License. See the LICENSE file for details.

### Usage
## Usage
1. **Sign In**: Use email/password, social login, or anonymous mode via Firebase Authentication.
2. **Search**: Enter movie or actor names in the search bar to explore content.
3. **View Details**: Tap a movie or actor to see detailed info and trailers.
4. **Add to Watchlist**: Save movies to your Firestore-backed watchlist.
5. **Rate Movies**: Rate films using the interactive rating bar.

### Project Structure

PopCornTime/
├── lib/
│   ├── core/                # Core utilities (routes, theme)
│   ├── features/            # Feature-specific screens (auth, home, movie details)
│   ├── models/              # Data models (movie, actor, user)
│   ├── services/            # API and Firebase services (auth, tmdb, watchlist)
│   ├── widgets/             # Reusable UI components (nav bar, movie card)
├── assets/                  # Images, icons, animations
├── pubspec.yaml             # Project configuration and dependencies

### FAQ
How do I get a TMDB API key? Visit themoviedb.org and sign up for a free account.
Can I use the app offline? Partial support via cached data; full offline mode is in development.
How do I report a bug? Open an issue on the GitHub repository.


