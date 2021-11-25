//
//  Interstitial.swift
//  Goals
//
//  Created by Riccardo Carlotto on 25/11/21.
//

import SwiftUI
import GoogleMobileAds
    
final class Interstitial: NSObject, GADFullScreenContentDelegate {
    
    private var interstitial: GADInterstitialAd?
    
    override init() {
        super.init()
        LoadInterstitial()
    }
    
    func LoadInterstitial() {
        let request = GADRequest()
            GADInterstitialAd.load(withAdUnitID:"ca-app-pub-3940256099942544/4411468910",
                                        request: request,
                              completionHandler: { [self] ad, error in
                                if let error = error {
                                  print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                  return
                                }
                                interstitial = ad
                                interstitial?.fullScreenContentDelegate = self
                              }
            )
    }
    
    func showAd(){
        
        
        if interstitial != nil {
            let root = UIApplication.shared.windows.first?.rootViewController
            interstitial!.present(fromRootViewController: root!)
          } else {
            print("Ad wasn't ready")
          }
        
        
        
//        if self.interstitial.isReady{
//           let root = UIApplication.shared.windows.first?.rootViewController
//           self.interstitial.present(fromRootViewController: root!)
//        }
//       else{
//           print("Not Ready")
//       }
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        LoadInterstitial()
      }
}
