import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/theme/theme_bloc.dart';
import '../blocs/theme/theme_event.dart';
import '../blocs/theme/theme_state.dart';

class TradingHeader extends StatelessWidget {
  const TradingHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState.themeMode == ThemeModes.dark;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
            ),
          ),
          child: Column(
            children: [
           
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
               
                  Row(
                    children: [
                      Icon(
                        Icons.flash_on,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Sisyphus',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                 
                  Row(
                    children: [
                     
                      IconButton(
                        icon: Icon(
                          isDarkMode ? Icons.light_mode : Icons.dark_mode,
                        ),
                        onPressed: () {
                          context.read<ThemeBloc>().add(ToggleTheme());
                        },
                      ),
                      const CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.orange,
                        child: Text('J'),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.language),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              Row(
                children: [
               
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? Colors.grey.shade800.withOpacity(0.3)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                color: Colors.orange,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Text(
                                  'B',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Text(
                                  'S',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'BTC/USDT',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '\$20,634',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
           
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatItem(
                    context: context,
                    icon: Icons.access_time,
                    label: '24h change',
                    value: '\$20.80',
                    percentage: '+1.25%',
                    isPositive: true,
                  ),
                  _buildStatItem(
                    context: context,
                    icon: Icons.arrow_upward,
                    label: '24h high',
                    value: '\$20.80',
                    percentage: '+1.25%',
                    isPositive: true,
                  ),
                  _buildStatItem(
                    context: context,
                    icon: Icons.arrow_downward,
                    label: '24h low',
                    value: '\$20.80',
                    percentage: '+1.2%',
                    isPositive: true,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
    required String percentage,
    required bool isPositive,
  }) {
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey
        : Colors.grey.shade600;

    return Row(
      children: [
        Icon(icon, size: 14, color: textColor),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: textColor,
              ),
            ),
            Row(
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  percentage,
                  style: TextStyle(
                    fontSize: 14,
                    color: isPositive ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
