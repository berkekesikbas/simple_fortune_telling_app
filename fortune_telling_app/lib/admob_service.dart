import 'package:fl_astrology/pages/gelecek_fali_sonuc.dart';
import 'package:fl_astrology/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static final String interAdTest = "ca-app-pub-3940256099942544/1033173712";
  static final String interAdCanli = "";
  static final String rewardedAdTest = "ca-app-pub-3940256099942544/5224354917";
  static final String rewardedAdCanli = "";
  static final String bannerAdTest = "";
  static final String bannerAdCanli = "";

  int odulluReklam = 0;

  InterstitialAd _interstitialAd;

  RewardedAd _rewardedAd;

  int num_of_attempt_load = 0;

  static initialization() {
    if (MobileAds.instance == null) {
      MobileAds.instance.initialize();
    }
  }

  void createInterAd() {
    InterstitialAd.load(
      adUnitId: interAdTest,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          num_of_attempt_load = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          num_of_attempt_load + 1;
          _interstitialAd = null;

          if (num_of_attempt_load <= 2) {
            createInterAd();
          }
        },
      ),
    );
  }

  void showInterAd() {
    if (_interstitialAd == null) {
      return;
    }

    _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(onAdShowedFullScreenContent: (InterstitialAd ad) {
      print("ad onAdshowedFullscren");
    }, onAdDismissedFullScreenContent: (InterstitialAd ad) {
      print("ad Disposed");
      ad.dispose();
    }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError adError) {
      print("$ad onAdFailed $adError");
      ad.dispose();
      createInterAd();
    });
    _interstitialAd.show();
    _interstitialAd = null;
  }

  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: rewardedAdTest,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          this._rewardedAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          //loadRewardedAd();
        },
      ),
    );
  }

  void showRewardAd(BuildContext context) {
    odulluReklam = 0;
    _rewardedAd.show(onUserEarnedReward: (RewardedAd ad, RewardItem rewardItem) {
      print("Adds Reward is ${rewardItem.amount}");
      odulluReklam++;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GelecekFaliSonuc(),
        ),
      );
    });
    if (odulluReklam == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }

    _rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) => print('$ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
      },
      onAdImpression: (RewardedAd ad) => print('$ad impression occurred.'),
    );
  }
}
