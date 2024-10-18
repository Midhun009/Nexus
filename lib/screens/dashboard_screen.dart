  import 'package:flutter/material.dart';
  import 'package:font_awesome_flutter/font_awesome_flutter.dart';
  import 'package:google_fonts/google_fonts.dart';
  import 'package:url_launcher/url_launcher.dart';
  import 'pdf_viewer_screen.dart'; // Import the PDF viewer screen
  import 'web_view_screen.dart'; // Import the WebViewScreen

  class DashboardScreen extends StatelessWidget {
    void _openWebView(BuildContext context, String url) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WebViewScreen(url: url)),
      );
    }

    void _openWhatsApp(String phoneNumber) async {
      final Uri url = Uri.parse('https://wa.me/$phoneNumber');
      try {
        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
          throw 'Could not launch $url';
        }
      } catch (e) {
        print('Error opening WhatsApp: $e');
      }
    }

    void _makePhoneCall(String phoneNumber) async {
      final Uri url = Uri.parse('tel:$phoneNumber');
      try {
        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
          throw 'Could not launch $url';
        }
      } catch (e) {
        print('Error making phone call: $e');
      }
    }

    void _openPDF(String assetPath, BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PDFViewerScreen(
            path: assetPath,
          ),
        ),
      );
    }

     void _openExternalApp(String url) async {
  final Uri uri = Uri.parse(url);
  try {
    if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
      throw 'Could not launch $uri';
    }
  } catch (e) {
    print('Error opening external app: $e');
  }
}
   void _showPhoneNumberOptions(BuildContext context, List<String> phoneNumbers) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white, // Background color of the popup
        title: Text(
          'Select a Phone Number',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.blue.shade900, // Customize title color
          ),
        ),
        contentPadding: EdgeInsets.all(5.0), // Adjust content padding
        content: Container(
          width: 115.0, // Adjust the width as needed
          height: 115.0, // Adjust the height as needed
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: phoneNumbers.map((phoneNumber) {
              return ListTile(
                title: Text(
                  phoneNumber,
                  style: TextStyle(
                    fontSize: 18, // Adjust font size
                  ),
                ),
                onTap: () {
                  _makePhoneCall(phoneNumber);
                  Navigator.pop(context); // Close the dialog after selection
                },
              );
            }).toList(),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0), // Rounded corners
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close the dialog
            style: TextButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.red.shade600, // Text color of the button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // Rounded corners for the button
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Padding inside the button
            ),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontWeight: FontWeight.bold, // Font weight of the button text
                fontSize: 16, // Font size of the button text
              ),
            ),
          ),
        ],
      );
    },
  );
}


    @override
    Widget build(BuildContext context) {
      List<DashboardItem> items = [
        DashboardItem(
          title: "Franchise Login",
          subtitle: "",
          icon: Icons.login,
          url: 'https://acenexus.in/home/index.php',
          color: Colors.blue.shade800,
        ),
       
        DashboardItem(
        title: "Agent Login",
        subtitle: "",
        icon: Icons.person,
        url: 'https://acenexus.in/home/franchise/index.php',
        color: const Color.fromARGB(255, 40, 132, 198),
      ),

        DashboardItem(
          title: "Admin Login",
          subtitle: "",
          icon: Icons.admin_panel_settings,
          url: 'https://acenexus.in/home/nexus_projects/acelogin/moblog.php',
          color: Colors.red.shade800,
        ),
        DashboardItem(
          title: "Insta ATM",
          subtitle: "",
          icon: FontAwesomeIcons.creditCard,
          url: 'https://acenexus.in/instaatm.php',
          color: Colors.teal.shade800,
        ),
        DashboardItem(
          title: "Video Gallery",
          subtitle: "",
          icon: FontAwesomeIcons.video,
          url: 'https://acenexus.in/video_gallery.php',
          color: Colors.purple.shade800,
        ),
        DashboardItem(
          title: "Nexus Brochure",
          subtitle: "",
          icon: FontAwesomeIcons.filePdf,
          url: 'assets/pdf/nexus.pdf',
          color: Colors.red.shade800,
        ),
        DashboardItem(
          title: "Tata Indicash",
          subtitle: "",
          icon: FontAwesomeIcons.moneyBillWave,
          url: 'assets/pdf/atm.pdf',
          color: Colors.green.shade800,
        ),
        DashboardItem(
          title: "Smart Bank",
          subtitle: "",
          icon: FontAwesomeIcons.bank,
          url: 'assets/pdf/smart.pdf',
          color: const Color.fromARGB(255, 192, 21, 101),
        ),
        DashboardItem(
          title: "Hitachi ATM",
          subtitle: "",
          icon: FontAwesomeIcons.building,
          url: 'assets/pdf/hitachi.pdf',
          color: Colors.brown.shade800,
        ),
        DashboardItem(
          title: "Smart ATM Kiosk",
          subtitle: "",
          icon: FontAwesomeIcons.cashRegister,
          url: 'assets/pdf/instaatm.pdf',
          color: Colors.orange.shade800,
        ),
        DashboardItem(
          title: "Our Website",
          subtitle: "",
          icon: FontAwesomeIcons.globe,
          url: 'https://acenexus.in/',
          color: Colors.blue.shade800,
        ),
        DashboardItem(
          title: "Youtube Channel",
          subtitle: "",
          icon: Icons.video_library,
          url: 'https://www.youtube.com/@sajithnair',
          color: Colors.red.shade800,
        ),
        DashboardItem(
          title: "Contact Us",
          subtitle: "",
          icon: Icons.contact_mail,
          url: 'https://acenexus.in/contact.php',
          color: Colors.green.shade800,
        ),
        DashboardItem(
          title: "Instagram",
          subtitle: "",
          icon: FontAwesomeIcons.instagram,
          url: 'https://www.instagram.com/acenexus.in/',
          color: Colors.pink.shade800,
        ),
        DashboardItem(
          title: "WhatsApp",
          subtitle: "",
          icon: FontAwesomeIcons.whatsapp,
          phoneNumber: '918848043325',
          url: 'https://wa.me/918848043325',
          color: Colors.green.shade800,
        ),
         DashboardItem(
        title: "Call Now",
        subtitle: "",
        icon: FontAwesomeIcons.phone,
        url: 'tel:', // Not used in this case
        phoneNumbers: ['9895683714', '8848043325'], 
        color: Colors.blue.shade800,
      ),
      ];

      return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Curved top bar
            Positioned(
              top: 0, // Ensure it starts from the top of the screen
              left: 0,
              right: 0,
              child: ClipPath(
                clipper: CustomClipPath(),
                child: Container(
                  width: double.infinity,
                  height: 180, // Ensure this height fits your design
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade900, Colors.blue.shade500],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0), // Adjust padding as needed
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between logo and text
                      children: [
                        // Logo on the left
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: CircleAvatar(
                            backgroundColor: const Color.fromARGB(10, 18, 63, 209),
                            radius: 40,
                            child: Image.asset(
                              'assets/logo-light.png',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Content on the right
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20.0, top: 30), // Right padding to align text
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ACE NEXUS',
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Welcome to ACE Nexus Online Service Solutions',
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Floating dashboard items
            Positioned(
              top: 140, // Adjusted position to move content up from the top bar
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0), // Reduced padding
                child: SingleChildScrollView(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(), // Disable scrolling in GridView
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return _buildGridItem(context, items[index]);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildGridItem(BuildContext context, DashboardItem item) {
  return GestureDetector(
    onTap: () {
      if (item.phoneNumbers != null && item.phoneNumbers!.isNotEmpty) {
        _showPhoneNumberOptions(context, item.phoneNumbers!);
      } else if (item.phoneNumber != null) {
        _openWhatsApp(item.phoneNumber!);
      } else if (item.url.startsWith('tel:')) {
        _makePhoneCall(item.url.substring(4)); // Remove 'tel:' prefix
          } else if (item.url.startsWith('assets/')) {
            _openPDF(item.url, context);
          } else if (item.url.startsWith('http')) {
          // Handle URLs with http or https
          if (item.title == 'Youtube Channel') {
            _openExternalApp(item.url); // Open YouTube in the external app
          } else if (item.title == 'Instagram') {
            _openExternalApp(item.url); // Open Instagram in the external app
          } else {
            _openWebView(context, item.url); // Open other URLs in WebView
          }
          }
        },
        child: Container(
          padding: EdgeInsets.all(8), // Reduced padding
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                item.icon,
                size: 40,
                color: item.color,
              ),
              SizedBox(height: 8),
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              if (item.subtitle.isNotEmpty) ...[
                SizedBox(height: 4),
                Text(
                  item.subtitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }
  }

  class DashboardItem {
    final String title;
    final String subtitle;
    final IconData icon;
    final Color color;
    final String url;
    final String? phoneNumber;
     final List<String>? phoneNumbers; // Change from String? to List<String>?


    DashboardItem({
      required this.title,
      required this.subtitle,
      required this.icon,
      required this.color,
      required this.url,
      this.phoneNumber,
      this.phoneNumbers,
    });
  }

  class CustomClipPath extends CustomClipper<Path> {
    @override
    Path getClip(Size size) {
      final path = Path();
      path.lineTo(0, size.height - 40);
      path.quadraticBezierTo(
          size.width / 2, size.height, size.width, size.height - 40);
      path.lineTo(size.width, 0);
      path.close();
      return path;
    }

    @override
    bool shouldReclip(CustomClipper<Path> oldClipper) => false;
  }
