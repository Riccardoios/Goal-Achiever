//
//  SubscriptionManager.swift
//  Goals
//
//  Created by Riccardo Carlotto on 23/11/2020.
//


// sandboxuser riccardo.rich@libero.it Gennaro0987

import Foundation
import SwiftUI
import Purchases

public class SubscriptionManager: ObservableObject {
    
    public static let shared = SubscriptionManager()
    
    
    @Published public var monthlySubscription: Purchases.Package?
    @Published public var yearlySubscription: Purchases.Package?
    @Published public var lifetime: Purchases.Package?
    @Published public var inPaymentProgress = false
    @Published public var offeringObj : Purchases.Offering?
    @Published public var subscriptionStatus = false // the released version need false here
    
    
    init() {
        Purchases.configure(withAPIKey: "uDVuRXSmgsVJJJxeGnUMrkqLfgyoudge")
        Purchases.shared.offerings { (offerings, error) in
            self.monthlySubscription = offerings?.current?.monthly
            self.lifetime = offerings?.current?.lifetime
            self.yearlySubscription = offerings?.current?.annual
            self.offeringObj = offerings?.current
        }
        
    }
    
//        private func processInfo(info: Purchases.PurchaserInfo?) {
//            if info?.entitlements.all["pro"]?.isActive == true {
//                subscriptionStatus = true
//            } else {
//                subscriptionStatus = false
//            }
//            inPaymentProgress = false
//        }
    
    
 
    
    // the snippet

    
//        public func purchase(source: String, product: Purchases.Package) {
//            guard !inPaymentProgress else { return }
//            inPaymentProgress = true
//            Purchases.shared.setAttributes(["source": source,
//                                            "number_of_launch": "\(AppUserDefaults.shared.numberOfLaunch)"])
//            Purchases.shared.purchasePackage(product) { (_, info, _, _) in
//                self.processInfo(info: info)
//            }
//        }
    
   
    
}
//manager:
//import Foundation
//import SwiftUI
//import Purchases
//
//public class SubscriptionManager: ObservableObject {
//    public static let shared = SubscriptionManager()
//    
//    public enum SubscriptionStatus {
//        case subscribed, notSubscribed
//    }
//    
//    @Published public var monthlySubscription: Purchases.Package?
//    @Published public var yearlySubscription: Purchases.Package?
//    @Published public var lifetime: Purchases.Package?
//    @Published public var inPaymentProgress = false
//    @Published public var subscriptionStatus: SubscriptionStatus = AppUserDefaults.shared.isSubscribed ? .subscribed : .notSubscribed
//    
//    init() {
//        Purchases.configure(withAPIKey: "glVAIPplNhAuvgOlCcUcrEaaCQwLRzQs")
//        Purchases.shared.offerings { (offerings, error) in
//            self.monthlySubscription = offerings?.current?.monthly
//            self.lifetime = offerings?.current?.lifetime
//            self.yearlySubscription = offerings?.current?.annual
//        }
//        refreshSubscription()
//    }
//    
//    public func purchase(source: String, product: Purchases.Package) {
//        guard !inPaymentProgress else { return }
//        inPaymentProgress = true
//        Purchases.shared.setAttributes(["source": source,
//                                        "number_of_launch": "\(AppUserDefaults.shared.numberOfLaunch)"])
//        Purchases.shared.purchasePackage(product) { (_, info, _, _) in
//            self.processInfo(info: info)
//        }
//    }
//    
//    
//    public func refreshSubscription() {
//        Purchases.shared.purchaserInfo { (info, _) in
//            self.processInfo(info: info)
//        }
//    }
//    
//    public func restorePurchase() {
//        Purchases.shared.restoreTransactions { (info, _) in
//            self.processInfo(info: info)
//        }
//    }
//    
//    private func processInfo(info: Purchases.PurchaserInfo?) {
//        if info?.entitlements.all["AC+"]?.isActive == true {
//            subscriptionStatus = .subscribed
//            AppUserDefaults.shared.isSubscribed = true
//        } else {
//            AppUserDefaults.shared.isSubscribed = false
//            subscriptionStatus = .notSubscribed
//        }
//        inPaymentProgress = false
//    }
//}


// subscribe view

//import Purchases
//
//struct SubscribeView: View {
//    enum Source: String {
//        case dashboard, turnip, turnipForm, list, musics
//    }
//
//    @EnvironmentObject private var subscriptionManager: SubscriptionManager
//    @Environment(\.presentationMode) private var presentationMode
//
//    let source: Source
//    @State private var sheetURL: URL?
//
//    private var sub: Purchases.Package? {
//        subscriptionManager.monthlySubscription
//    }
//
//    private var yearlySub: Purchases.Package? {
//        subscriptionManager.yearlySubscription
//    }
//
//    private var lifetime: Purchases.Package? {
//        subscriptionManager.lifetime
//    }
//
//    private func formattedPrice(for package: Purchases.Package) -> String {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .currency
//        formatter.locale = sub!.product.priceLocale
//        return formatter.string(from: package.product.price)!
//    }
//}
