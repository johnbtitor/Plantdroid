# Plantdroid Android App

The Plantdroid Android App is designed to interface with the Plantdroid system, allowing you to monitor and manage your plant's environmental conditions directly from your Android device.

## Table of Contents
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
  - [Windows](#windows)
  - [Linux](#linux)
  - [macOS](#macos)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Features
- Real-time monitoring of temperature, humidity, soil moisture, and light intensity.
- Historical data visualization through graphs.
- Notifications for critical conditions.

## Prerequisites
- Flutter installed on your development machine.
- A physical Android device or emulator for testing.
- ESP32 microcontroller running the Plantdroid firmware.

## Installation

### Windows

1. **Install Flutter**:
   - Download and install Flutter from the [official website](https://flutter.dev/docs/get-started/install/windows).

2. **Install Android Studio**:
   - Download and install Android Studio from the [official website](https://developer.android.com/studio).
   - Ensure you have the Android SDK installed. You can install it via Android Studio's SDK Manager.

3. **Set Up Flutter and Android Studio**:
   - Follow the instructions on the Flutter website to set up the Flutter and Android Studio [here](https://flutter.dev/docs/get-started/editor?tab=androidstudio).

4. **Clone the Repository**:
   - Open a terminal (Command Prompt or PowerShell) and run:
     ```sh
     git clone https://github.com/johnbtitor/Plantdroid.git
     cd Plantdroid/AndroidApp
     ```

5. **Install Dependencies**:
   - In the terminal, run:
     ```sh
     flutter pub get
     ```

### Linux

1. **Install Flutter**:
   - Follow the instructions to install Flutter from the [official website](https://flutter.dev/docs/get-started/install/linux).

2. **Install Android Studio**:
   - Download and install Android Studio from the [official website](https://developer.android.com/studio).
   - Ensure you have the Android SDK installed. You can install it via Android Studio's SDK Manager.

3. **Set Up Flutter and Android Studio**:
   - Follow the instructions on the Flutter website to set up the Flutter and Android Studio [here](https://flutter.dev/docs/get-started/editor?tab=androidstudio).

4. **Clone the Repository**:
   - Open a terminal and run:
     ```sh
     git clone https://github.com/johnbtitor/Plantdroid.git
     cd Plantdroid/AndroidApp
     ```

5. **Install Dependencies**:
   - In the terminal, run:
     ```sh
     flutter pub get
     ```

### macOS

1. **Install Flutter**:
   - Follow the instructions to install Flutter from the [official website](https://flutter.dev/docs/get-started/install/macos).

2. **Install Android Studio**:
   - Download and install Android Studio from the [official website](https://developer.android.com/studio).
   - Ensure you have the Android SDK installed. You can install it via Android Studio's SDK Manager.

3. **Set Up Flutter and Android Studio**:
   - Follow the instructions on the Flutter website to set up the Flutter and Android Studio [here](https://flutter.dev/docs/get-started/editor?tab=androidstudio).

4. **Clone the Repository**:
   - Open a terminal and run:
     ```sh
     git clone https://github.com/johnbtitor/Plantdroid.git
     cd Plantdroid/AndroidApp
     ```

5. **Install Dependencies**:
   - In the terminal, run:
     ```sh
     flutter pub get
     ```

## Usage

1. **Run the App**:
   - Connect your Android device or start an emulator.
   - In the terminal, run:
     ```sh
     flutter run
     ```

2. **Monitor Plant Data**:
   - Once the app is running, it will connect to the WebSocket server on the ESP32.
   - You will see real-time data updates for temperature, humidity, and light intensity.

## Contributing

Contributions are welcome! Please fork this repository and submit a pull request with your changes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

