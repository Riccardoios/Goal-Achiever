//
//  Banner.swift
//  Goals
//
//  Created by Riccardo Carlotto on 25/11/21.
//

import SwiftUI
import GoogleMobileAds

final private class BannerVC: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        
        let banner = GADBannerView(adSize: GADAdSizeBanner)
        
        let viewController = UIViewController()
        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"//"ca-app-pub-6567836193057519/5296361074"
        banner.rootViewController = viewController
        viewController.view.addSubview(banner)
        viewController.view.frame = CGRect(origin: .zero, size: GADAdSizeBanner.size)
        banner.load(GADRequest())
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

struct Banner: View {
    var body: some View {
        HStack(alignment:.center) {
            BannerVC()
                .frame(width: 320, height: 50, alignment: .center)
        }
    }
}

struct Banner_Previews: PreviewProvider {
    static var previews: some View {
        Banner()
    }
}
