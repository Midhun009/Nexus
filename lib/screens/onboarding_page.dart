import 'package:flutter/material.dart';
import '../preferences_manager.dart'; // Import your PreferencesManager
import 'dashboard_screen.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController pageController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemCount: onboardingData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: onboardingData[index].width,
                        height: onboardingData[index].height,
                        child: Image.asset(onboardingData[index].image),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        onboardingData[index].title,
                        style: const TextStyle(
                          fontSize: 28,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          onboardingData[index].description,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          buildDots(),
          buildButton(),
        ],
      ),
    );
  }

  Widget buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        onboardingData.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          height: 7,
          width: currentIndex == index ? 25 : 7,
          decoration: BoxDecoration(
            color: currentIndex == index ? primaryColor : const Color(0xFFE0E0E0),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget buildButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 55,
      child: ElevatedButton(
        onPressed: () async {
          if (currentIndex == onboardingData.length - 1) {
            await PreferencesManager.setHasSeenOnboarding(true); // Set onboarding status
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardScreen()),
            );
          } else {
            pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          currentIndex == onboardingData.length - 1 ? 'Get Started' : 'Continue',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

const primaryColor = Color(0xFF274a99);

final onboardingData = [
  OnboardingInfo(
    title: "Welcome to Nexus!",
    description: "Join Kerala and Karnataka's fastest-growing financial services network, empowering you with trusted partnerships and innovative solutions.",
    image: "assets/logo.png",
    width: 300.0,
    height: 300.0,
  ),
  OnboardingInfo(
    title: "Seamless Financial Services",
    description: "Unlock a world of financial services with Nexus. From ATMs to online solutions, we bring opportunities right to your fingertips.",
    image: "assets/accounting.png",
    width: 100.0,
    height: 100.0,
  ),
  OnboardingInfo(
    title: "Grow with Trusted Partners",
    description: "Partner with top industry names like Tata, Hitachi, and SBI FASTag. Gain access to cutting-edge technology and market-leading commissions.",
    image: "assets/trust.png",
    width: 140.0,
    height: 140.0,
  ),
  OnboardingInfo(
    title: "Your Success, Our Priority",
    description: "Receive full support, comprehensive training, and the best tools to build a successful, profitable franchise with Nexus.",
    image: "assets/success.png",
    width: 130.0,
    height: 130.0,
  ),
];

class OnboardingInfo {
  final String title;
  final String description;
  final String image;
  final double width;
  final double height;

  OnboardingInfo({
    required this.title,
    required this.description,
    required this.image,
    this.width = 100.0,
    this.height = 100.0,
  });
}
