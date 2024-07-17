# Weather App

This Flutter application provides weather information using the OpenWeather API and supports local storage with `sqflite` for persistence.

## Demo
https://github.com/user-attachments/assets/bdbd3b76-ecd1-4590-81ab-cbeff7a1b4d6


## Features

- Display current weather conditions and forecasts.
- View current weather data based on the user's current location.
- View a list of cities and save or delete them to see their weather data.
- Local storage to cache saved cities.
- Support for two flavor environments:
  - **Mock**: Uses fake API classes for testing.
  - **QA**: Uses real API implementations for production.

### Prerequisites

- Flutter SDK installed ([Get Flutter](https://flutter.dev/docs/get-started/install))
- OpenWeather API key ([Sign up for API key](https://home.openweathermap.org/users/sign_up))

### Running the App

#### QA Environment

To run the app with real API implementations:

```bash
flutter run --flavor qa -t lib/main/main.qa.dart
