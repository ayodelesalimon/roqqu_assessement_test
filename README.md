# Assessment, Mobile Developer Role-Roqqu

Assessment, Mobile Developer Role-Roqqu


## Video Demo



## Features

- **Real-time market data** via Binance WebSockets
- **Interactive candlestick charts** with timeframe selection
- **Live orderbook** displaying buy and sell orders
- **Recent trades list** showing market activity
- **Trading form** for executing buy/sell orders
- **Light and dark mode** support with easy theme switching
- **Bottom sheet trading interface** for mobile-friendly interaction

## Project Structure

```
lib/
├── main.dart                        # Application entry point
├── app.dart                         # App configuration with theme support
├── injection_container.dart         # Dependency injection setup
├── blocs/                           # BLoC state management
│   ├── chart/
│   │   ├── chart_bloc.dart          # Chart data management
│   │   ├── chart_event.dart         # Chart interaction events
│   │   └── chart_state.dart         # Chart rendering states
│   ├── market/
│   │   ├── market_bloc.dart         # Market data management
│   │   ├── market_event.dart        # Market events
│   │   └── market_state.dart        # Market states
│   ├── orderbook/
│   │   ├── orderbook_bloc.dart      # Orderbook data management
│   │   ├── orderbook_event.dart     # Orderbook events
│   │   └── orderbook_state.dart     # Orderbook states
│   ├── theme/
│   │   ├── theme_bloc.dart          # Theme management
│   │   ├── theme_event.dart         # Theme toggle events
│   │   └── theme_state.dart         # Light/dark theme states
│   └── trade/
│       ├── trade_bloc.dart          # Trade execution management
│       ├── trade_event.dart         # Trade events
│       └── trade_state.dart         # Trade states
├── config/
│   ├── constants.dart               # API endpoints and app constants
│   └── themes.dart                  # Theme definitions for light/dark mode
├── models/
│   ├── candle_stick_model.dart      # Candlestick data structure
│   ├── orderbook_entry_model.dart   # Orderbook entry model
│   └── trade_model.dart             # Trade data model
├── repositories/
│   ├── binance_repository.dart      # Binance API integration
│   └── trading_repository.dart      # Trading operations logic
├── screens/
│   └── trading_screen.dart          # Main trading interface screen
└── widgets/
    ├── chart_widget.dart            # Candlestick chart visualization
    ├── orderbook_widget.dart        # Orderbook display
    ├── recent_trade_widget.dart     # Recent trades list
    ├── trading_form.dart            # Buy/sell order form
    ├── trading_header.dart          # App header with theme toggle
    ├── trading_tabs.dart            # Tab navigation component
    └── trading_bottom_sheet.dart    # Bottom sheet trading interface
```

## Architecture

This application follows a clean architecture approach with BLoC pattern for state management:

### Presentation Layer
- **Widgets & Screens**: UI components that display data and capture user input
- **BLoCs**: Manage state and handle business logic for each feature
  - Separate BLoCs for chart, orderbook, trades, and theme
  - Each BLoC has corresponding event and state classes

### Domain Layer
- **Repositories**: Abstract the data sources and provide clean APIs to the BLoCs
- **Business Logic**: Implemented within repositories and BLoCs

### Data Layer
- **Models**: Data structures used throughout the app
- **Data Sources**: WebSocket connections to Binance API (implemented in repositories)

## State Management

The app uses the BLoC (Business Logic Component) pattern for state management:

- **Events**: Triggered by user interactions or data updates
- **States**: Represent the UI state at any given time
- **BLoCs**: Process events and emit new states

## Theme Support

The app supports both light and dark themes:

- **Theme BLoC**: Handles theme switching and persistence
- **Theme-aware widgets**: All UI components adapt to the current theme
- **Toggle button**: Located in the app header for easy switching

## Getting Started

### Prerequisites
- Flutter SDK 2.10.0 or higher
- Dart 2.16.0 or higher

### Installation

1. Clone the repository:
```bash
git clone https://github.com/ayodelesalimon/roquu_assessement_test.git
cd roquu_assessement_test
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Dependencies

- **flutter_bloc**: ^8.1.1 - For state management
- **web_socket_channel**: ^2.2.0 - For WebSocket connections
- **equatable**: ^2.0.5 - For value equality
- **get_it**: ^7.2.0 - For dependency injection
- **intl**: ^0.17.0 - For date formatting
- **candlesticks**: ^2.1.0 - For candlestick chart visualization

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.