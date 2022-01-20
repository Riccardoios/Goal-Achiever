//
//  GoalsApp.swift
//  Goals
//
//  Created by Riccardo Carlotto on 28/10/2020.
//

import SwiftUI
import AppTrackingTransparency
import GoogleMobileAds
import AdSupport

@main
struct GoalsApp: App {

    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let store: IAPStore
    
    init() {
        
        self.store = IAPStore(productsIDs: ["ga_5999_1y_", "ga_399_1m"])
        appDelegate.store = store
        
        
        
        ATTrackingManager.requestTrackingAuthorization { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized:
                    // Authorized
                    let idfa = ASIdentifierManager.shared().advertisingIdentifier
                    print (idfa.uuidString, "idfa")
                case .denied:
                    print ("denied")
                case  .notDetermined:
                    print ("not determined")
                case  .restricted:
                    print ("restricret")
                    
                    
                @unknown default:
                    break
                }
            }
        }
        
        
        
        
        if ATTrackingManager.trackingAuthorizationStatus == .notDetermined {
            
        }
        else {
            ATTrackingManager.requestTrackingAuthorization { _ in
                GADMobileAds.sharedInstance().start(completionHandler: nil)
            }
            
        }
        
    }
    
    var body: some Scene {
        WindowGroup {
            Home()
//            PayWallView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(TimerViewModel())
                .environmentObject(store)
//                .environmentObject(SubscriptionManager())
        }
    }
    
    
}
