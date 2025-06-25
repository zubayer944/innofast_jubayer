# GitHub Repository Browser

A Flutter application that allows users to browse GitHub repositories and view repository details.

## Project Structure

The project follows a clean architecture pattern with the following structure:

```
lib/
├── app/
│   ├── bindings/        # Dependency injection bindings
│   ├── config/          # Configuration files
│   ├── controllers/     # GetX controllers
│   ├── core/           # Core utilities and common widgets
│   ├── data/           # Data layer (repositories, models)
│   ├── domain/         # Domain layer (entities, use cases)
│   └── presentation/   # Presentation layer (screens, widgets)
└── main.dart           # Application entry point
```

## Architecture Principles (SOLID)

### Single Responsibility Principle (SRP)
- Each class has a single responsibility
- Controllers handle UI logic
- Repositories handle data operations
- Use cases encapsulate business logic

### Open/Closed Principle (OCP)
- Business logic is encapsulated in use cases
- New features can be added by extending existing classes
- Data layer is abstracted for easy replacement

### Liskov Substitution Principle (LSP)
- Interfaces are properly defined in the domain layer
- Concrete implementations can be substituted without affecting functionality
- Repository interfaces are implemented by concrete classes

### Interface Segregation Principle (ISP)
- Interfaces are kept small and focused
- Domain entities have clear interfaces
- Repositories have specific methods for their operations

### Dependency Inversion Principle (DIP)
- High-level modules depend on abstractions, not concrete implementations
- GetX for dependency injection
- Repository pattern for data access

## Dependencies

### Core Dependencies
- `flutter`: ^3.10.0
- `get`: ^4.6.5 - State management and dependency injection
- `dio`: ^4.0.0 - HTTP client for network operations
- `url_launcher`: ^6.2.0 - Open URLs in browser
- `dartz`: ^0.10.0 - Functional programming and error handling

### Development Dependencies
- `flutter_test`: ^3.10.0
- `flutter_lints`: ^2.0.0

## Getting Started

### Prerequisites
- Flutter SDK installed
- Git installed
- Android Studio or VS Code with Flutter plugin

### Installation

Note: The latest code is in the `master` branch.

1. Clone the repository:
```bash
git clone [repository-url]
cd jubayer_innofast
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Features

- View GitHub user profile
- Browse repositories with pagination
- View detailed repository information
- Open repositories in browser
- Clean and modern UI
- Error handling and loading states

## Code Organization

### Presentation Layer
- Screens: `lib/app/presentation/screens/`
  - `profile_screen.dart`: User profile view
  - `repository_list_screen.dart`: Repository list view
  - `repository_detail_screen.dart`: Repository detail view
- Widgets: `lib/app/core/utils/widgets.dart`

### Domain Layer
- Entities: `lib/app/domain/entities/`
  - `profile.dart`: User profile data model
  - `repository.dart`: Repository data model
- Repositories: `lib/app/domain/repositories/`
  - `repository_repository.dart`: Repository interface

### Data Layer
- Repositories: `lib/app/data/repositories/`
  - `repository_repository_impl.dart`: Repository implementation
- Models: `lib/app/data/models/`
  - Data transfer objects

## Best Practices

- State management using GetX
- Clean architecture principles
- SOLID design principles
- Proper error handling
- Loading states for async operations
- Responsive UI design
- Code separation and modularity

## Network Handling

The project implements robust network handling with the following features:

### Error Handling
- Comprehensive error handling for network failures
- User-friendly error messages
- Retry mechanisms for failed requests
- Graceful degradation when network is unavailable

### Loading States
- Loading indicators during network operations
- Loading states for pagination
- Loading states for repository details
- Loading states for browser operations

### Data Fetching
- Efficient pagination implementation
- Caching of repository data
- Proper rate limiting handling
- Background data fetching

### Browser Integration
- Safe URL handling using `url_launcher`
- Loading states during browser operations
- Error handling for browser operations
- Proper cleanup of loading states

### Network States
- Detection of network availability
- Offline mode handling
- Retry mechanisms for network operations
- Loading states during network state changes

### Security
- HTTPS for all network requests
- Proper URL validation
- Secure data handling
- Rate limiting protection

The network handling is implemented using:
- `dio` for API calls and network operations
- `dartz` for functional error handling
- Custom repository implementations
- GetX for state management
- Clean architecture principles for separation of concerns

### Error Handling with Dartz
- Functional error handling using Either type
- Clear separation of success and failure cases
- Type-safe error handling
- Monadic operations for error propagation
- Custom failure types for different error scenarios
- Clean error handling in repository layer
- Proper error mapping from network errors to domain errors

### Dio Features
- Efficient HTTP client implementation
- Request/response interceptors
- Automatic request/response transformation
- Cancellation of requests
- Timeout handling
- Retry policy implementation
- Request/response caching
- Custom headers and authentication
- File upload/download support
- WebSocket support
- Rich error handling

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)


## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

- GitHub: [zubayer944](https://github.com/zubayer944)
- Email: zubayer944@gmail.com
- LinkedIn: [LinkedIn Profile](https://www.linkedin.com/in/zubayer944)

Feel free to reach out if you have any questions or need assistance with the project!
