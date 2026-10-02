import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyIdApp());
}

class MyIdApp extends StatelessWidget {
  const MyIdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MY ID',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(),
    );
  }
}

/// 1. Splash Screen:
/// - Immersive full-screen displaying app branding "MY ID"
/// - Exactly 3 seconds (3000ms), smooth transition to HomeScreen
/// - National tricolor accent ring, strictly no Ashoka Chakra
/// - Blue-colored Fingerprint icon
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );

    // Exactly 3 seconds duration
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const HomeScreen(),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF141A32),
                  // National tricolor themed gradient border
                  gradient: const SweepGradient(
                    colors: [
                      Color(0xFFFF9933), // National Saffron
                      Color(0xFFFFFFFF), // National White
                      Color(0xFF138808), // National Green
                      Color(0xFFFF9933), // Loop
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF9933).withOpacity(0.3),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                    BoxShadow(
                      color: const Color(0xFF138808).withOpacity(0.3),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF141A32),
                    ),
                    child: const Center(
                      // Blue-colored Fingerprint Icon (Strictly no Ashoka Chakra)
                      child: Icon(
                        Icons.fingerprint,
                        color: Color(0xFF1A73E8),
                        size: 64,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'MY ID',
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 10),
            // Tricolor accent indicator bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 16, height: 3, color: const Color(0xFFFF9933)),
                  Container(width: 16, height: 3, color: Colors.white),
                  Container(width: 16, height: 3, color: const Color(0xFF138808)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 2. Portal Data Model
class PortalItem {
  final String title;
  final String subtitle;
  final String officialUrl;

  const PortalItem({
    required this.title,
    required this.subtitle,
    required this.officialUrl,
  });
}

/// 20 Official Government Service Portals
const List<PortalItem> officialPortals = [
  PortalItem(
    title: 'Birth Certificate',
    subtitle: 'Civil Registration System (CRS)',
    officialUrl: 'https://crsorgi.gov.in',
  ),
  PortalItem(
    title: 'Aadhaar Card',
    subtitle: 'UIDAI Official Portal',
    officialUrl: 'https://uidai.gov.in',
  ),
  PortalItem(
    title: 'Community Certificate',
    subtitle: 'TNeGA / e-Sevai Portal',
    officialUrl: 'https://esevai.tn.gov.in',
  ),
  PortalItem(
    title: 'TC',
    subtitle: 'School Education Portal - Transfer Certificate',
    officialUrl: 'https://tnschools.gov.in',
  ),
  PortalItem(
    title: 'Mark Sheet',
    subtitle: 'Directorate of Government Examinations (TN DGE)',
    officialUrl: 'https://dge.tn.gov.in',
  ),
  PortalItem(
    title: 'PAN Card',
    subtitle: 'Income Tax & NSDL e-Gov Services',
    officialUrl: 'https://www.onlineservices.nsdl.com',
  ),
  PortalItem(
    title: 'Voter ID',
    subtitle: 'Election Commission of India (ECI)',
    officialUrl: 'https://voters.eci.gov.in',
  ),
  PortalItem(
    title: 'Passport',
    subtitle: 'Passport Seva Portal, MEA India',
    officialUrl: 'https://passportindia.gov.in',
  ),
  PortalItem(
    title: 'Driving Licence',
    subtitle: 'Sarathi Parivahan Sewa, MoRTH',
    officialUrl: 'https://sarathi.parivahan.gov.in',
  ),
  PortalItem(
    title: 'RC',
    subtitle: 'Vehicle Registration (Vahan Parivahan)',
    officialUrl: 'https://vahan.parivahan.gov.in',
  ),
  PortalItem(
    title: 'Marriage Certificate',
    subtitle: 'TNREGINET Registration Department',
    officialUrl: 'https://tnreginet.gov.in',
  ),
  PortalItem(
    title: 'Smart Card/Ration Card',
    subtitle: 'Tamil Nadu Public Distribution System (TN PDS)',
    officialUrl: 'https://tnpds.gov.in',
  ),
  PortalItem(
    title: 'EC',
    subtitle: 'Encumbrance Certificate (TNREGINET)',
    officialUrl: 'https://tnreginet.gov.in',
  ),
  PortalItem(
    title: 'UAN/PF',
    subtitle: "Employees' Provident Fund Organization (EPFO)",
    officialUrl: 'https://unifiedportal-mem.epfindia.gov.in',
  ),
  PortalItem(
    title: 'Kisan ID',
    subtitle: 'PM Kisan Samman Nidhi Portal',
    officialUrl: 'https://pmkisan.gov.in',
  ),
  PortalItem(
    title: 'Electricity Bill',
    subtitle: 'TANGEDCO Online Services',
    officialUrl: 'https://www.tnebnet.org',
  ),
  PortalItem(
    title: 'Water Tax',
    subtitle: 'Metro Water Supply & Urban Tax Portal',
    officialUrl: 'https://chennaimetrowater.tn.gov.in',
  ),
  PortalItem(
    title: 'Gas',
    subtitle: 'MyLPG Official Portal (Indane, Bharat, HP)',
    officialUrl: 'https://www.mylpg.in',
  ),
  PortalItem(
    title: 'Property Tax',
    subtitle: 'TN Urban Local Bodies Online Tax Portal',
    officialUrl: 'https://tnurbanepay.tn.gov.in',
  ),
  PortalItem(
    title: 'Insurance Certificate',
    subtitle: 'IRDAI Bima Bharosa Insurance Portal',
    officialUrl: 'https://bimabharosa.irdai.gov.in',
  ),
];

/// 3. Personal ID Document Model (for secure personal media and ID vault)
class PersonalIdCard {
  final String id;
  final String title;
  final String holderName;
  final String docNumber;
  final String issueDate;
  final Color cardColor;

  const PersonalIdCard({
    required this.id,
    required this.title,
    required this.holderName,
    required this.docNumber,
    required this.issueDate,
    required this.cardColor,
  });
}

/// 4. Home Screen
/// - App Title "MY ID" clearly displayed at the top
/// - Removed tagline "Digital Identity & Credential Vault" entirely
/// - Completely removed bottom navigation bar
/// - Fast search & 20 tricolor-themed portal cards with blue fingerprint icon
/// - Secure Personal ID & Document Vault switcher
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<PortalItem> _filteredPortals = officialPortals;
  int _activeTab = 0; // 0: Portals, 1: Personal Vault
  bool _isMasked = true;

  // Stored personal ID cards
  final List<PersonalIdCard> _vaultCards = [
    const PersonalIdCard(
      id: '1',
      title: 'Aadhaar Card',
      holderName: 'Sarah L. Chen',
      docNumber: '5421 8904 9012',
      issueDate: '12/2018',
      cardColor: Color(0xFF1E3A8A),
    ),
    const PersonalIdCard(
      id: '2',
      title: 'PAN Card',
      holderName: 'Sarah L. Chen',
      docNumber: 'ABCDE 1234F',
      issueDate: '03/2021',
      cardColor: Color(0xFF0F766E),
    ),
    const PersonalIdCard(
      id: '3',
      title: 'Driving Licence',
      holderName: 'Sarah L. Chen',
      docNumber: 'TN01 2020 0012345',
      issueDate: '08/2020',
      cardColor: Color(0xFF7C2D12),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim().toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredPortals = officialPortals;
      } else {
        _filteredPortals = officialPortals.where((p) {
          return p.title.toLowerCase().contains(query) ||
              p.subtitle.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  Future<void> _launchUrl(String urlString) async {
    final uri = Uri.parse(urlString);
    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open $urlString')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error launching portal: $e')),
        );
      }
    }
  }

  String _formatMaskedDoc(String raw) {
    if (!_isMasked) return raw;
    if (raw.length <= 4) return '••••';
    final visiblePart = raw.substring(raw.length - 4);
    return '•••• •••• $visiblePart';
  }

  void _showAddCardDialog() {
    final titleCtrl = TextEditingController();
    final nameCtrl = TextEditingController(text: 'Sarah L. Chen');
    final numCtrl = TextEditingController();
    final dateCtrl = TextEditingController(text: '10/2024');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF141A32),
        title: const Text('Add Document to Vault', style: TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleCtrl,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: 'Document Name (e.g. Voter ID)'),
              ),
              TextField(
                controller: nameCtrl,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: 'Holder Name'),
              ),
              TextField(
                controller: numCtrl,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: 'Document Number'),
              ),
              TextField(
                controller: dateCtrl,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: 'Issue Date'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1A73E8)),
            onPressed: () {
              if (titleCtrl.text.isNotEmpty && numCtrl.text.isNotEmpty) {
                setState(() {
                  _vaultCards.add(
                    PersonalIdCard(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: titleCtrl.text.trim(),
                      holderName: nameCtrl.text.trim(),
                      docNumber: numCtrl.text.trim(),
                      issueDate: dateCtrl.text.trim(),
                      cardColor: const Color(0xFF334155),
                    ),
                  );
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('Save Card', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      // No bottomNavigationBar as strictly required
      body: SafeArea(
        child: Column(
          children: [
            // Top Header Bar - "MY ID" clearly displayed
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: const BoxDecoration(
                color: Color(0xFF141A32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF1A73E8).withOpacity(0.15),
                          border: Border.all(
                            color: const Color(0xFF1A73E8).withOpacity(0.4),
                          ),
                        ),
                        child: const Icon(
                          Icons.fingerprint,
                          color: Color(0xFF1A73E8),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'MY ID',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C2242),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 3,
                          height: 14,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF9933),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _activeTab == 0 ? '20 Portals' : '${_vaultCards.length} IDs Saved',
                          style: const TextStyle(
                            color: Color(0xFFE0E0E0),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Top Tab Selector (Government Portals vs Personal ID Vault)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFF141A32),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF283155)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _activeTab = 0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 9),
                          decoration: BoxDecoration(
                            color: _activeTab == 0
                                ? const Color(0xFF1A73E8)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: const Center(
                            child: Text(
                              'Government Portals (20)',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _activeTab = 1),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 9),
                          decoration: BoxDecoration(
                            color: _activeTab == 1
                                ? const Color(0xFF1A73E8)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: const Center(
                            child: Text(
                              'Personal ID Vault',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Content Area based on selected Tab
            Expanded(
              child: _activeTab == 0 ? _buildPortalsTab() : _buildVaultTab(),
            ),
          ],
        ),
      ),
    );
  }

  /// Government Portals View
  Widget _buildPortalsTab() {
    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              hintText: 'தேவையான சேவையைத் தேடவும்... (Search)',
              hintStyle: const TextStyle(
                color: Color(0xFF888899),
                fontSize: 14,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Color(0xFF1A73E8),
              ),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: Colors.grey),
                      onPressed: () => _searchController.clear(),
                    )
                  : null,
              filled: true,
              fillColor: const Color(0xFF141A32),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF283155)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF1A73E8)),
              ),
            ),
          ),
        ),

        // 20 Service Cards List
        Expanded(
          child: _filteredPortals.isEmpty
              ? Center(
                  child: Text(
                    'சேவைகள் எதுவும் கிடைக்கவில்லை.\nNo portals found matching "${_searchController.text}"',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  itemCount: _filteredPortals.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final portal = _filteredPortals[index];
                    return _buildPortalCard(portal);
                  },
                ),
        ),
      ],
    );
  }

  /// Personal Media & ID Vault View
  Widget _buildVaultTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () => setState(() => _isMasked = !_isMasked),
                icon: Icon(
                  _isMasked ? Icons.visibility_off : Icons.visibility,
                  size: 18,
                  color: const Color(0xFF4DA6FF),
                ),
                label: Text(
                  _isMasked ? 'Masking ON' : 'Masking OFF',
                  style: const TextStyle(color: Color(0xFF4DA6FF)),
                ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A73E8),
                  shape: RoundedCornerShape(8),
                ),
                onPressed: _showAddCardDialog,
                icon: const Icon(Icons.add, size: 18, color: Colors.white),
                label: const Text('Add ID Card', style: TextStyle(color: Colors.white, fontSize: 13)),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            itemCount: _vaultCards.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final card = _vaultCards[index];
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: card.cardColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: card.cardColor.withOpacity(0.6)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          card.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(Icons.verified_user, color: Color(0xFF10B981), size: 18),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _formatMaskedDoc(card.docNumber),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'monospace',
                        letterSpacing: 2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Holder: ${card.holderName}',
                          style: const TextStyle(color: Color(0xFF9EA7C4), fontSize: 12),
                        ),
                        Text(
                          'Issued: ${card.issueDate}',
                          style: const TextStyle(color: Color(0xFF9EA7C4), fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Portal Card with:
  /// - Professional light-dark national tricolor-themed shadow effect
  /// - Centered blue-colored Fingerprint icon (Strictly NO Ashoka Chakra)
  /// - Direct, clean, and fast navigation to official URL
  Widget _buildPortalCard(PortalItem portal) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF15192E),
        borderRadius: BorderRadius.circular(14),
        // National Tricolor Shadow Effect
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF9933).withOpacity(0.18),
            blurRadius: 8,
            offset: const Offset(-2, -2),
          ),
          BoxShadow(
            color: const Color(0xFF138808).withOpacity(0.22),
            blurRadius: 8,
            offset: const Offset(2, 2),
          ),
        ],
        // National Tricolor Border
        border: Border.all(
          width: 1.2,
          color: const Color(0xFF2A3150),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () => _launchUrl(portal.officialUrl),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                // Centered Blue Fingerprint Icon Container (No Ashoka Chakra)
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF1A73E8).withOpacity(0.12),
                    border: Border.all(
                      color: const Color(0xFF1A73E8).withOpacity(0.35),
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.fingerprint,
                      color: Color(0xFF1A73E8), // Blue-colored Fingerprint
                      size: 28,
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                // Title & Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        portal.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        portal.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF9EA7C4),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.open_in_new,
                            color: Color(0xFF4DA6FF),
                            size: 11,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              portal.officialUrl
                                  .replaceAll('https://', '')
                                  .replaceAll('/', ''),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color(0xFF4DA6FF),
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),

                // Fast Action Arrow
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF202646),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFFE0E0E0),
                    size: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
