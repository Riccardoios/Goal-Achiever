//
//  GoalsApp.swift
//  Goals
//
//  Created by Riccardo Carlotto on 28/10/2020.
//

import SwiftUI
import AppTrackingTransparency
import GoogleMobileAds

@main
struct GoalsApp: App {

    let persistenceController = PersistenceController.shared

    init() {
        
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
                .environmentObject(SubscriptionManager())
        }
    }
    
    
}
