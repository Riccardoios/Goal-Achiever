//
//  Home.swift
//  Foocus
//
//  Created by Riccardo Carlotto on 30/07/2020.
//  Copyright © 2020 Riccardo Carlotto. All rights reserved.

// 4.7"(SE), 5.5" (8 plus), 6.1" (iphone Xr), then ipads..

/*
 
 TO DO LIST:
- remeber to set false for premium content
 
 - continue with the paywallview and its binding in the parent view it is presented
 - trackview it has still lags
 
 
 - change the description of the listing in the apple app store from focus app to goal achiever app

 
 testing with sanbox premimum if the logic of istomatotimer = false is correct
 

 
 - Notification of the day 1 ( remind the user he has the app)
 
 - set the icon as Premium when is purchased
 
 - new graph for the streak
 
 - method for cleaning the data of the old goal
 
 - Find acquisition channels for free
 
 - add subscirption weekly and maybe lifetime
 
 - personalise app color view in settings
 
 - when i create a new goal have the timer to 0:00

- advertise as much as I can
- it is really time to go to upWork
 
 SECONDARY
- func where i delete the old session for performances purpuses
- permissions of notfications alert if are set to no
 
 antipattern
 - the remind to turn on notification is not good
 - the tomato timer when is on it get trigged when the trackview get initialised so we have an animation and not quite a good pattern 
 
 
*/

/// BUGS:

// if i stop the timer the notification of timer finished comes anyway
// the circle when i press done in the preferences doesn't shrink but in the preview yes??
// if i set not allow notifications and then i set it mannualy when i open the app i see for half second the alert of turning on the notification and then it disappear
// if i move the circle on the bar outside of the bar it goes far and come back,but it just shouldn't.

import SwiftUI
import CoreData
import Purchases

let screen = UIScreen.main.bounds
let myCoef = screen.size.width / 375 // if iphone x = 1 if iphone se = 0.82

struct Home: View {
    
    @State var showHome = false
    @EnvironmentObject var timerVM : TimerViewModel
    @EnvironmentObject var subManager: SubscriptionManager
    @Environment(\.managedObjectContext) var moc
    
    @State var showPlanView = true
    @State var showDoView = false
    @State var showChartsView = false
    @State var showSettingsView = false
    @State var showPayWallView = false
    
    @FetchRequest(entity: Goal.entity(), sortDescriptors: [
        NSSortDescriptor(key: #keyPath(Goal.dateEdited), ascending: false)
    ]) var goals: FetchedResults<Goal> // from the oldest to the newst
    //for the graphic charts
    
    @FetchRequest(entity: Sessions.entity(), sortDescriptors: []) var sessions: FetchedResults<Sessions>
    
    
    var body: some View {
        
        //        let permissionsBinding = Binding (
        //            get: {self.timerVM.remidUserToActivateNotification},
        //            set: {
        //                //self.timerVM.requestNotificationAutorization();
        //                self.timerVM.remidUserToActivateNotification = $0
        //
        //        })
        //
        //        return
        
        if showHome == false {
            LaunchView(showHome: $showHome)
        } else {
        
        
        ZStack {

                Color(#colorLiteral(red:0.89, green:0.90, blue:0.93, alpha:1.00))
                    .edgesIgnoringSafeArea(.all)
                             
                VStack {
                    
                    if showPlanView {
                        PlanView(showPlanView: $showPlanView, showDoView: $showDoView, showChartsView: $showChartsView, showSettingsView: $showSettingsView, showPayWall: $showPayWallView)
                    }
                    
                    if showDoView {
                        DoView(showPlanView: $showPlanView, showDoView: $showDoView, showChartsView: $showChartsView)
                    }
                    
                    if showChartsView {
                        TrackView(goals: goals, sessions: sessions)
                    }
                    
                    if showSettingsView {
                        SettingsScreenView(showPlanView: $showPlanView, showDoView: $showDoView, showChartsView: $showChartsView, showSettingView: $showSettingsView, showPayWallView: $showPayWallView)
                    }
                    if showPayWallView {
                        PayWallView(showPayWall: $showPayWallView, showSettingView: $showSettingsView)
                    }
                    
                    if !showPayWallView {
                        MenuPane(showPlan: $showPlanView , showDo: $showDoView , showCharts: $showChartsView, showSettings: $showSettingsView)
                        .ignoresSafeArea(.keyboard, edges: .vertical)
                    }
//                    .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                        
                        if !UIDevice.current.hasNotch {
                            Spacer().frame(height: 18)
                        }
                       
                    
                }
                
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        // for ios 14 the keyboard now move the all view to the top but with this line you cancel this behavior
        .onAppear{
            self.timerVM.incrementAppRuns()
            
            //check for user entitlements 
            Purchases.shared.purchaserInfo { (purchaserInfo, error) in
                if purchaserInfo?.entitlements.all["pro"]?.isActive == true {
                    self.subManager.subscriptionStatus = true
                    
                }
            }
            
        }
        
    }
    }
    
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home().environmentObject(TimerViewModel())
    }
}

extension UIDevice {
    
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
        
    }
}

