# Crypto Trading App

A modern Flutter cryptocurrency trading application with real-time data from Binance WebSockets, featuring charts, orderbooks, recent trades, and a trading interface with light and dark theme support.

## Features

- **Real-time market data** via Binance WebSockets
- **Interactive candlestick charts** with timeframe selection
- **Live orderbook** displaying buy and sell orders
- **Recent trades list** showing market activity
- **Trading form** for executing buy/sell orders
- **Light and dark mode** support with on-the-fly switching
- **Bottom sheet trading interface** for mobile-friendly interaction

## Project Structure

```
lib/
├── main.dart                 # Application entry point
├── app.dart                  # App configuration with theme provider
├── config/
│   ├── constants.dart        # API endpoints and app constants
│   └── theme.dart            # Theme configuration for light/dark mode
├── core/
│   ├── error/                # Error handling utilities
│   └── utils/                # Common utility functions
├── features/
│   ├── theme/                # Theme management feature
│   │   └── bloc/
│   │       ├── theme_bloc.dart     # BLoC for theme management
│   │       ├── theme_event.dart    # Theme events (toggle, initialize)
│   │       └── theme_state.dart    # Theme state (light/dark)
│   └── trading/              # Trading feature
│       ├── data/
│       │   ├── models/
│       │   │   ├── candlestick_model.dart  # Candlestick data model
│       │   │   ├── orderbook_model.dart    # Orderbook data model
│       │   │   └── trade_model.dart        # Trade data model
│       │   ├── repositories/
│       │   │   └── trading_repository.dart # Repository for trading data
│       │   └── datasources/
│       │       └── binance_websocket.dart  # WebSocket connection to Binance
│       └── presentation/
│           ├── bloc/
│           │   ├── chart/                  # Chart data management
│           │   ├── orderbook/              # Orderbook data management
│           │   └── trades/                 # Trades data management
│           ├── pages/
│           │   └── trading_page.dart       # Main trading page
│           └── widgets/
│               ├── chart_widget.dart       # Chart visualization
│               ├── orderbook_widget.dart   # Orderbook display
│               ├── recent_trades_widget.dart # Recent trades list
│               ├── trading_tabs.dart       # Tab navigation
│               ├── trading_header.dart     # App header with theme toggle
│               ├── trading_form.dart       # Trading form
│               └── trading_bottom_sheet.dart # Bottom sheet for trading
└── injection_container.dart  # Dependency injection setup
```

## Architecture

This application follows **Clean Architecture** principles with the following layers:

1. **Data Layer**: Responsible for data retrieval and storage
   - WebSocket connections to Binance API
   - Data models for candlesticks, orderbook, and trades

2. **Domain Layer**: Business logic implementation
   - Repositories for handling data from various sources
   - Use cases for business operations

3. **Presentation Layer**: UI components and state management
   - BLoC pattern for state management
   - Widgets organized by feature

## State Management

- **BLoC Pattern** for reactive state management
  - Separate BLoCs for chart, orderbook, trades, and theme
  - Events for user interactions
  - States for UI representation

## Theme Management

The app uses a dedicated Theme BLoC for managing light and dark modes:

- **Theme BLoC**: Handles theme toggle events
- **Theme-aware widgets**: All UI components adapt to the current theme
- **Toggle button**: Easy switching between light and dark modes

## WebSocket Implementation

Real-time data is obtained through Binance WebSockets:

- **Candlestick stream**: For chart data
- **Depth stream**: For orderbook data
- **Trade stream**: For recent trades

## UI Components

### Trading Page
The main page with tabs for different trading views:
- Custom tab bar with animations
- Theme-aware styling

### Chart Widget
Displays candlestick charts with:
- Timeframe selection (1H, 2H, 4H, 1D, 1W, 1M)
- Trading view/depth mode toggle
- Full theme support

### Orderbook Widget
Shows current buy and sell orders:
- Color-coded price levels
- Quantity visualization
- Real-time updates

### Recent Trades Widget
Lists the most recent trades:
- Buy/sell indicators
- Price and amount information
- Timestamp display

### Trading Form Bottom Sheet
Mobile-friendly trading interface:
- Buy/Sell toggle
- Order type selection (Limit, Market, Stop-Limit)
- Price and amount inputs
- Account information
- Draggable for easy interaction

## Getting Started

### Prerequisites
- Flutter SDK 2.10.0 or higher
- Dart 2.16.0 or higher

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/crypto_trading_app.git
cd crypto_trading_app
```

2. Install the dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Dependencies

- **flutter_bloc**: For state management
- **web_socket_channel**: For WebSocket connections
- **candlesticks**: For candlestick chart visualization
- **equatable**: For value equality
- **get_it**: For dependency injection
- **intl**: For date formatting and localization

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.