import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/profile_info_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 4;

  final List<_BottomNavItem> _items = const [
    _BottomNavItem(Icons.home_outlined, 'Home'),
    _BottomNavItem(Icons.map_outlined, 'Map'),
    _BottomNavItem(Icons.swap_horiz_rounded, 'Transfer'),
    _BottomNavItem(Icons.settings_outlined, 'Settings'),
    _BottomNavItem(Icons.person_outline_rounded, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final backgroundColor = isDarkMode
        ? theme.scaffoldBackgroundColor
        : const Color(0xffF3F3F6);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 0),
              child: Row(
                children: [
                  SizedBox(
                    height: 44,
                    width: 44,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios_new, size: 18),
                      onPressed: () => Navigator.pop(context),
                      splashRadius: 24,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Profile',
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 44),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),

                    const SizedBox(height: 28),

                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 170,
                            height: 170,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: theme.colorScheme.surface,
                              border: Border.all(
                                color: isDarkMode
                                    ? Colors.white10
                                    : Colors.white,
                                width: 8,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.shadowColor.withAlpha(20),
                                  blurRadius: 24,
                                  offset: const Offset(0, 12),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/profile_placeholder.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          Positioned(
                            right: -2,
                            bottom: -2,
                            child: Container(
                              height: 56,
                              width: 56,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surface,
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.shadowColor.withAlpha(25),
                                    blurRadius: 18,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.edit_outlined,
                                size: 26,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    _buildSectionCard(
                      title: 'Personal info',
                      actionText: 'Edit',
                      children: const [
                        ProfileInfoTile(
                          icon: Icons.person_outline,
                          title: 'Name',
                          value: 'Sumindra Chaudhary',
                        ),
                        SizedBox(height: 28),
                        ProfileInfoTile(
                          icon: Icons.email_outlined,
                          title: 'E-mail',
                          value: 'sumindra@gmail.com',
                        ),
                        SizedBox(height: 28),
                        ProfileInfoTile(
                          icon: Icons.call_outlined,
                          title: 'Phone number',
                          value: '+977 98XXXXXXXX',
                        ),
                        SizedBox(height: 28),
                        ProfileInfoTile(
                          icon: Icons.home_outlined,
                          title: 'Home address',
                          value: 'Baneshwor, Kathmandu, Nepal',
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    _buildSectionCard(
                      title: 'Account info',
                      children: const [
                        ProfileInfoTile(
                          icon: Icons.account_balance_outlined,
                          title: 'Bank Name',
                          value: 'Nepal Investment Mega Bank',
                        ),
                        SizedBox(height: 28),
                        ProfileInfoTile(
                          icon: Icons.credit_card_outlined,
                          title: 'Account Number',
                          value: '0123456789012345',
                        ),
                        SizedBox(height: 28),
                        ProfileInfoTile(
                          icon: Icons.location_city_outlined,
                          title: 'Branch',
                          value: 'Baneshwor Branch',
                        ),
                        SizedBox(height: 28),
                        ProfileInfoTile(
                          icon: Icons.verified_user_outlined,
                          title: 'Status',
                          value: 'Active',
                        ),
                      ],
                    ),

                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),

            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    String? actionText,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withAlpha(14),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
              if (actionText != null)
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    foregroundColor: theme.colorScheme.primary,
                    textStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: Text(actionText),
                ),
            ],
          ),

          const SizedBox(height: 28),

          ...children,
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 14, bottom: 20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withAlpha(51)
                : Colors.black.withAlpha(10),
            blurRadius: 18,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_items.length, (index) {
            final item = _items[index];
            final selected = index == _selectedIndex;

            final bool isProfileTab = index == 4;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });

                debugPrint('Selected ${item.label}');
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isProfileTab)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: selected
                            ? theme.colorScheme.primary.withAlpha(31)
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: selected
                          ? Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: theme.colorScheme.primary,
                                  width: 2,
                                ),
                              ),
                              child: const CircleAvatar(
                                radius: 14,
                                backgroundImage: AssetImage(
                                  'assets/profile_placeholder.png',
                                ),
                              ),
                            )
                          : Icon(
                              Icons.person_outline_rounded,
                              size: 28,
                              color: theme.colorScheme.onSurface.withAlpha(166),
                            ),
                    )
                  else
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: selected
                            ? theme.colorScheme.primary.withAlpha(31)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        item.icon,
                        size: 28,
                        color: selected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurface.withAlpha(165),
                      ),
                    ),

                  const SizedBox(height: 6),

                  Text(
                    item.label,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                      color: selected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface.withAlpha(165),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _BottomNavItem {
  final IconData icon;
  final String label;

  const _BottomNavItem(this.icon, this.label);
}
