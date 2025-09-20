# EHIRCLE BLK Application 📱

[![Flutter Version](https://img.shields.io/badge/Flutter-3.16+-blue.svg)](https://flutter.dev/)
[![Firebase](https://img.shields.io/badge/Firebase-Integrated-orange.svg)](https://firebase.google.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A powerful **mobile inventory management solution** built with Flutter that helps users efficiently track, categorize, and analyze their personal or business inventory with real-time location mapping and cloud-based image storage.

## 🌟 Features

### 📦 Core Inventory Management

- **Add Items**: Create new inventory items with detailed information
- **Update Items**: Modify existing item details seamlessly
- **Search & Filter**: Powerful search functionality across all items
- **Delete Items**: Remove items with confirmation prompts
<!-- - **Bulk Operations**: Select and manage multiple items at once -->

### 🏷️ Category Management

- **Create Categories**: Organize items with custom categories
- **Update Categories**: Rename and modify category details
- **Category Assignment**: Easily assign items to specific categories
- **Category Analytics**: View item distribution across categories
- **Delete Categories**: Remove unused categories safely

### 📊 Analytics Dashboard

- **Item Statistics**: View total items, categories, and trends
- **Visual Charts**: Interactive charts showing inventory distribution
- **Value Analysis**: Track total inventory value
- **Category Breakdown**: Pie charts showing items that categorized and not

### 🗺️ Location Integration

- **Item Location Mapping**: Pin item locations using OpenMapAPI
- **Location Search**: Find items based on geographical location
- **Map View**: Visual representation of inventory locations
- **GPS Tracking**: Auto-detect current location for new items

### 📸 Image Management

- **Cloud Storage**: Secure image storage via Cloudinary
- **Image Optimization**: Automatic image compression and resizing
- **Image Gallery**: Beautiful gallery view for item images

## 🛠️ Technology Stack

| Component          | Technology             | Purpose                                   |
| ------------------ | ---------------------- | ----------------------------------------- | ----------------------- | --- |
| **Frontend**       | Flutter (Dart)         | Cross-platform mobile development         |
| **Backend**        | Firebase               | Authentication, Database, Cloud Functions |
| **Database**       | Firestore              | NoSQL cloud database                      |
| **Authentication** | Firebase Auth          | User management and security              |
| **Image Storage**  | Cloudinary             | Cloud-based image management              |
| **Maps**           | OpenMapAPI             | Location services and mapping             |
| **Analytics**      | Firebase Analytics     | User behavior tracking                    |
| <!--               | **Push Notifications** | FCM                                       | Real-time notifications | --> |

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** (3.16.0 or higher)
- **Dart** (3.2.0 or higher)
- **Android Studio** or **VS Code** with Flutter extensions
- **Git** for version control
- **Node.js** (for Firebase CLI)

### Platform-specific Requirements:

#### Android

- Android SDK (API level 21 or higher)
- Java 8 or higher

#### iOS

- Xcode 12.0 or higher
- iOS 12.0 or higher
- CocoaPods

## 🎯 Key Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter

  # Firebase
  firebase_core: ^2.24.2
  firebase_auth: ^4.15.3
  cloud_firestore: ^4.13.6
  firebase_storage: ^11.5.6

  # UI & Navigation
  cupertino_icons: ^1.0.2
  go_router: ^12.1.3
  flutter_spinkit: ^5.2.0

  # State Management
  provider: ^6.1.1

  # Image Handling
  cloudinary_public: ^0.21.0
  image_picker: ^1.0.4
  cached_network_image: ^3.3.0

  # Maps & Location
  geolocator: ^10.1.0
  permission_handler: ^11.1.0

  # Charts & Analytics
  fl_chart: ^0.66.0

  # Utilities
  intl: ^0.19.0
  shared_preferences: ^2.2.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
```

## 🎮 Usage Guide

### Getting Started

1. **Launch the app** and create an account or sign in
2. **Set up your profile** with basic information
3. **Create categories** for organizing your inventory
4. **Add your first items** with photos and location data

### Adding Items

1. Tap the **"+" button** on the home screen
2. Fill in item details (name, description, quantity, value)
3. **Take or select photos** - automatically uploaded to Cloudinary
4. **Set location** using the map picker or GPS
5. **Assign category** from your existing categories
6. **Save** to add to your inventory

### Managing Categories

1. Go to **Categories** section
2. **Create new categories** with custom names and colors
3. **Edit existing categories** by tapping on them
4. **View category statistics** to see item distribution

### Using the Dashboard

- **Overview cards** show total items, categories, and inventory value
- **Charts section** displays visual analytics
- **Recent activity** shows your latest inventory changes

### Location Features

- **Map view** shows all items with location data
- **Location search** helps find items in specific areas
- **GPS integration** for automatic location detection

## 📱 Platform Support

| Platform | Minimum Version | Status       |
| -------- | --------------- | ------------ |
| Android  | API 21 (5.0)    | ✅ Supported |
| iOS      | 12.0            | 🔄 Future    |
| Web      | -               | 🔄 Future    |
| Desktop  | -               | 🔄 Future    |

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. **Open** a Pull Request

### Development Guidelines

- Follow Flutter/Dart style guidelines
- Write tests for new features
- Update documentation as needed
- Ensure CI/CD passes

## 🐛 Issues & Support

### Reporting Issues

If you encounter any bugs or have feature requests:

1. Check existing [issues](https://github.com/yourusername/ehircle-blk-app/issues)
2. Create a detailed bug report with:
   - Device information
   - Flutter version
   - Steps to reproduce
   - Expected vs actual behavior

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Flutter Team** for the amazing framework
- **Firebase** for backend infrastructure
- **Cloudinary** for image management solutions
- **OpenMapAPI** for mapping services
- **Contributors** who helped improve this project

## 📈 Roadmap

### Version 2.0 (Coming Soon)

- [ ] **Team collaboration features**

### Version 3.0 (Future)

- [ ] **Web application**
- [ ] **Desktop support**
- [ ] **Advanced analytics**
- [ ] **AI-powered suggestions**
- [ ] **Integration with e-commerce platforms**

---

## 📞 Contact

**Project Maintainer**: Faruq Ayomide Ogunkunle
**LinkedIn**: [Faruq LinkedIn](https://www.linkedin.com/in/devfaruq-oa/)

**Project Link**: [GithHub Repo](https://github.com/faruqonaayo/ethircle_blk_app)

---

<div align="center">
  <p>Made with ❤️ using Flutter</p>
  <p>⭐ Star this repo if you find it helpful!</p>
</div>
