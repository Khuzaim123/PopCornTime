# PopCornTime 🍿

![Logo](https://github.com/user-attachments/assets/d9a1f482-d66b-421e-909c-50fe79eff4a8)

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
- [Changelog](#changelog)
- [FAQ](#faq)
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
- Android emulator or physical device

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
- Open lib/Services/tmdb_services.dart and replace the placeholder with your TMDB API key:
    ```dart
    static const String _apiKey = 'Your_Api_Key';    
  

5. **Generate Assets:**
Run the command in terminal
   ```bash
   flutter pub run flutter_launcher_icons
    flutter pub run flutter_native_splash:create
6. **Run App**
   ```bash
   flutter run

### Technologies Used
| Area         | Technology Used                           |
|--------------|--------------------------------------------|
| Frontend     | Flutter 3                                  |
| Backend      | Firebase (Authentication, Firestore)       |
| State Mgmt   | Provider                                    |
| API          | TMDB API, YouTube API (for trailers)       |
| Navigation   | Flutter Navigator                          |
| Animations   | Flutter built-in animations, `animated_do` |
| Fonts        | Google Fonts (Poppins)                     |



### Usage
1. **Sign In**: Use email/password, social login, or anonymous mode via Firebase Authentication.
2. **Search**: Enter movie or actor names in the search bar to explore content.
3. **View Details**: Tap a movie or actor to see detailed info and trailers.
4. **Add to Watchlist**: Save movies to your Firestore-backed watchlist.
5. **Rate Movies**: Rate films using the interactive rating bar.

### Project Structure

![image](https://github.com/user-attachments/assets/6336d7b2-6fa6-487b-91a7-e5f0987d567a)

### RoadMap
- Add offline trailer caching for better accessibility.
- Implement multi-language support for global users.
- Introduce personalized movie recommendations using Firestore data.
- Enhance UI with dark mode and animations.

### ChangeLog:
- v1.0.0 Initial release with movie search, authentication, movie details, and watchlist functionality.
- v1.0.1 Some Bug Fixes
- v1.1.0 Added Actor detail screen , Search actor , Watch movie trailers
- v1.1.1(Upcoming) Going to add Rating Functionality

### FAQ
- How do I get a TMDB API key? Visit themoviedb.org and sign up for a free account.
- Can I use the app offline? Partial support via cached data; full offline mode is in development.
- How do I report a bug? Open an issue on the GitHub repository.

### Licence 
This project is licensed under the MIT License. See the LICENSE file for details.

### Contact: 
- Maintainer: Khuzaim123
- Issues: Report bugs or suggest features on the Issues page.
- Email: khuzaimadnana@gmail.com


