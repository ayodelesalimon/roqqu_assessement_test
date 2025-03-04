import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/theme/theme_bloc.dart';
import '../blocs/theme/theme_state.dart';

class TradingBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const TradingFormSheet(),
    );
  }
}

class TradingFormSheet extends StatefulWidget {
  const TradingFormSheet({Key? key}) : super(key: key);

  @override
  State<TradingFormSheet> createState() => _TradingFormSheetState();
}

class _TradingFormSheetState extends State<TradingFormSheet> {
  bool isBuySelected = true;
  String selectedOrderType = 'Limit';
  bool postOnly = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState.themeMode == ThemeModes.dark;

        return DraggableScrollableSheet(
          initialChildSize: 0.8,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF1C232D) : Colors.white,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Drag handle
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Colors.grey.shade700
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),

                      // Buy/Sell toggle
                      _buildBuySellToggle(isDarkMode),
                      const SizedBox(height: 24),

                      // Order type selector
                      _buildOrderTypeSelector(isDarkMode),
                      const SizedBox(height: 24),

                      // Limit price
                      _buildTextField(
                        isDarkMode: isDarkMode,
                        label: 'Limit price',
                        value: '0.00',
                        suffix: 'USD',
                        showInfo: true,
                      ),
                      const SizedBox(height: 16),

                      // Amount
                      _buildTextField(
                        isDarkMode: isDarkMode,
                        label: 'Amount',
                        value: '0.00',
                        suffix: 'USD',
                        showInfo: true,
                      ),
                      const SizedBox(height: 16),

                      // Type dropdown
                      _buildDropdownField(
                        isDarkMode: isDarkMode,
                        label: 'Type',
                        value: 'Good till cancelled',
                      ),
                      const SizedBox(height: 16),

                      // Post Only checkbox
                      _buildCheckboxField(
                        isDarkMode: isDarkMode,
                        label: 'Post Only',
                      ),
                      const SizedBox(height: 16),

                      // Total row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 16,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          Text(
                            '0.00',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Buy/Sell button
                      _buildActionButton(isDarkMode),
                      const SizedBox(height: 32),

                      // Account section
                      _buildAccountSection(isDarkMode),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBuySellToggle(bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.black : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isBuySelected = true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: isBuySelected
                      ? const Color(0xFF36B37E)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Buy',
                  style: TextStyle(
                    color: isBuySelected
                        ? Colors.white
                        : (isDarkMode ? Colors.grey : Colors.grey.shade700),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isBuySelected = false),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: !isBuySelected
                      ? const Color(0xFFF86B6B)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Sell',
                  style: TextStyle(
                    color: !isBuySelected
                        ? Colors.white
                        : (isDarkMode ? Colors.grey : Colors.grey.shade700),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderTypeSelector(bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildOrderTypeButton('Limit', isDarkMode),
        _buildOrderTypeButton('Market', isDarkMode),
        _buildOrderTypeButton('Stop-Limit', isDarkMode),
      ],
    );
  }

  Widget _buildOrderTypeButton(String type, bool isDarkMode) {
    final isSelected = selectedOrderType == type;

    return GestureDetector(
      onTap: () => setState(() => selectedOrderType = type),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          type,
          style: TextStyle(
            color: isSelected
                ? (isDarkMode ? Colors.white : Colors.black)
                : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required bool isDarkMode,
    required String label,
    required String value,
    required String suffix,
    required bool showInfo,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: isDarkMode ? Colors.grey : Colors.grey.shade700,
              ),
            ),
            if (showInfo)
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Icon(
                  Icons.info_outline,
                  size: 16,
                  color: isDarkMode ? Colors.grey : Colors.grey.shade700,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.black : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              Text(
                suffix,
                style: TextStyle(
                  fontSize: 14,
                  color: isDarkMode ? Colors.grey : Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required bool isDarkMode,
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: isDarkMode ? Colors.grey : Colors.grey.shade700,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Icon(
                Icons.info_outline,
                size: 16,
                color: isDarkMode ? Colors.grey : Colors.grey.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.black : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: isDarkMode ? Colors.grey : Colors.grey.shade700,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCheckboxField({
    required bool isDarkMode,
    required String label,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: postOnly,
            onChanged: (value) {
              setState(() {
                postOnly = value ?? false;
              });
            },
            activeColor: const Color(0xFF36B37E),
            side: BorderSide(
              color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade400,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Icon(
            Icons.info_outline,
            size: 16,
            color: isDarkMode ? Colors.grey : Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isBuySelected
              ? [
                  const Color.fromARGB(255, 54, 87, 179),
                  const Color.fromARGB(255, 107, 42, 157)
                ]
              : [
                  const Color.fromARGB(255, 54, 87, 179),
                  const Color.fromARGB(255, 107, 42, 157)
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(
          isBuySelected ? 'Buy BTC' : 'Sell BTC',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildAccountSection(bool isDarkMode) {
    final labelStyle = TextStyle(
      fontSize: 14,
      color: isDarkMode ? Colors.grey : Colors.grey.shade700,
    );
    final valueStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: isDarkMode ? Colors.white : Colors.black,
    );

    return Column(
      children: [
        // Divider
        Container(
          height: 1,
          color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
          margin: const EdgeInsets.symmetric(vertical: 16),
        ),

        // Total account value
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total account value', style: labelStyle),
            Row(
              children: [
                Text('NGN', style: labelStyle),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: isDarkMode ? Colors.grey : Colors.grey.shade700,
                  size: 20,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: Text('0.00', style: valueStyle),
        ),
        const SizedBox(height: 24),

        // Open Orders & Available
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Open Orders', style: labelStyle),
            Text('Available', style: labelStyle),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('0.00', style: valueStyle),
            Text('0.00', style: valueStyle),
          ],
        ),
        const SizedBox(height: 24),

        // Deposit button
        Row(
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
              ),
              child: const Text(
                'Deposit',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Usage example:
// In your code where you want to show the bottom sheet:
// ElevatedButton(
//   onPressed: () => TradingBottomSheet.show(context),
//   child: Text('Trade'),
// )
