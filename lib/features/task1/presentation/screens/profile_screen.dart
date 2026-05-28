import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  int _selectedIndex = 4;

  final List<_NavItem> _navItems = const [
    _NavItem(label: 'Home', icon: Icons.home_outlined),
    _NavItem(label: 'Map', icon: Icons.map_outlined),
    _NavItem(label: 'Transfer', icon: Icons.swap_horiz_outlined),
    _NavItem(label: 'Settings', icon: Icons.settings_outlined),
    _NavItem(label: 'Profile', icon: Icons.person_rounded),
  ];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOut,
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      bottomNavigationBar: _buildBottomNavigationBar(theme),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildProfileHeader(theme),
              const SizedBox(height: 28),
              _buildInfoSection(
                theme,
                title: 'Personal info',
                items: [
                  const _InfoItem(
                    icon: Icons.person_outline,
                    label: 'Name',
                    value: 'Sumindra Chaudhary',
                  ),
                  const _InfoItem(
                    icon: Icons.email_outlined,
                    label: 'E-mail',
                    value: 'sumindra@gmail.com',
                  ),
                  const _InfoItem(
                    icon: Icons.phone_iphone_outlined,
                    label: 'Phone',
                    value: '+977 98XXXXXXXX',
                  ),
                  const _InfoItem(
                    icon: Icons.location_on_outlined,
                    label: 'Address',
                    value: 'Baneshwor, Kathmandu, Nepal',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildInfoSection(
                theme,
                title: 'Account info',
                items: [
                  const _InfoItem(
                    icon: Icons.account_balance_outlined,
                    label: 'Bank Name',
                    value: 'Nepal Investment Mega Bank (NIMB)',
                  ),
                  const _InfoItem(
                    icon: Icons.confirmation_number_outlined,
                    label: 'Account Number',
                    value: '0123456789012345',
                  ),
                  const _InfoItem(
                    icon: Icons.location_city_outlined,
                    label: 'Branch',
                    value: 'Baneshwor Branch',
                  ),
                  const _InfoItem(
                    icon: Icons.verified_user_outlined,
                    label: 'Status',
                    value: 'Active',
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(ThemeData theme) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 128,
                  height: 128,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF6C63FF),
                        Color(0xFFFF6584),
                      ],
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 64,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('assets/profile_placeholder.png'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.edit,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Sumindra Chaudhary',
              style: GoogleFonts.poppins(
                fontSize: 26,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Flutter Developer',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.72),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildStatChip(theme, '92', 'Tasks'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatChip(theme, '4.9', 'Rating'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(ThemeData theme, String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightCard(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection(
    ThemeData theme, {
    required String title,
    required List<_InfoItem> items,
  }) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 16),
            ...items.asMap().entries.map((entry) {
              final item = entry.value;
              final isLast = entry.key == items.length - 1;
              return Column(
                children: [
                  _buildInfoRow(theme, item),
                  if (!isLast)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Divider(
                        color: theme.dividerColor.withOpacity(0.25),
                        height: 1,
                      ),
                    ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(ThemeData theme, _InfoItem item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(item.icon, color: AppTheme.primaryColor, size: 18),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                item.value,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoTile(ThemeData theme, _InfoItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.colorScheme.primary.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(item.icon, color: AppTheme.primaryColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.label,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.value,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _navItems.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final selected = _selectedIndex == index;
              return Expanded(
                child: InkWell(
                  onTap: () => _onNavItemTapped(index),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: selected
                          ? theme.colorScheme.primary.withOpacity(0.12)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item.icon,
                          size: 24,
                          color: selected
                              ? theme.colorScheme.primary
                              : Colors.grey.shade600,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.label,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                            color: selected
                                ? theme.colorScheme.primary
                                : Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (selected)
                          Container(
                            height: 3,
                            width: 28,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    debugPrint('Navigate to ${_navItems[index].label}');
  }
}

class _InfoItem {
  final IconData icon;
  final String label;
  final String value;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });
}

class _NavItem {
  final String label;
  final IconData icon;

  const _NavItem({required this.label, required this.icon});
}
