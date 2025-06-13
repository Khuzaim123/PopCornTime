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
| Home Screen     | Watchlist       | Search          |
|-----------------|-----------------|-----------------|
| ![Home](https://github.com/user-attachments/assets/bc5280c8-cc1a-424c-85ee-1da1f828a08e)| ![Watchlist](https://github.com/user-attachments/assets/a7564abd-f35f-468b-8440-88b16ba5bbd1)| ![Search](https://github.com/user-attachments/assets/424dfd6b-5716-4d58-9673-8a38991b3787)|

| Movie Detail    | Login           | Signup          |
|-----------------|-----------------|-----------------|
| ![Movie Detail]![image](https://github.com/user-attachments/assets/3562ee09-c50f-4d82-a01a-6c31d8a30593)| ![Login]![image](https://github.com/user-attachments/assets/fadbef4f-403a-4a9b-9db1-bc07f1685b43)| ![Signup]![image](https://github.com/user-attachments/assets/c6c8d2dd-7a1f-4a19-811a-189ba42c022d)|

| Forget          | Actor Detail    | Profile         |
|-----------------|-----------------|-----------------|
| ![Forget](https://github.com/user-attachments/assets/2e9c24ee-260f-4d98-bd10-ddca1940a8c5)| ![Actor Detail](https://github.com/user-attachments/assets/ac5aa4f0-69d8-4695-b57b-cb3a3153f1c5)| ![Profile](https://github.com/user-attachments/assets/58fa7ea1-2180-4ad3-9db8-7806872973d2)|

| Terms of Services | Setting  | Help and Support |
|-------------------|-----------------|------------------|
| ![Terms of Services](https://github.com/user-attachments/assets/3b1cbbb9-7d96-4a97-a5c6-3d2149561e2f)| ![Setting](https://github.com/user-attachments/assets/1b22b762-7216-4394-b08f-ebb20521ba46)| ![Help and Support](https://github.com/user-attachments/assets/7542df6c-0074-4ad6-adc8-77275127c41f)|

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


