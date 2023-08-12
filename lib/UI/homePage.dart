// ignore_for_file: avoid_print

import '../Global/imports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BannerAd? bannerAd;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    // super.didChangeDependencies();
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: BannerAdsID,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              isLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            setState(() => isLoaded = false);
            // Dispose the ad here to free resources.
            ad.dispose();
            print('Ad failed to load: $error');
          },
        ),
        request: const AdRequest());
    bannerAd?.dispose();
    bannerAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.leave_bags_at_home))
        ],
        title: const Text("Google ads"),
        backgroundColor: Desiredpurple,
      ),
      body: Center(
          child: Column(
        children: [
          Text(
            " Google ads Screen",
            style: TextStyle(fontSize: Fontlength),
          ),
          const Spacer(),
          isLoaded
              ? SizedBox(
                  height: AdHeight,
                  child: AdWidget(
                    ad: bannerAd!,
                  ),
                )
              : const SizedBox(),
        ],
      )),
    );
  }
}
