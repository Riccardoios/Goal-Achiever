//
//  Home.swift
//  Foocus
//
//  Created by Riccardo Carlotto on 30/07/2020.
//  Copyright © 2020 Riccardo Carlotto. All rights reserved.

// 4.7"(SE), 5.5" (8 plus), 6.1" (iphone Xr), then ipads..

/*
 TO DO LIST:
 
ios 14 bug

X Restore notifications system
X rename foocus with Goals
X space in the spacer of weekgoal
- func where i delete the old session for performances purpuses
- func of scroll up ios 14 rather than id
- permissions of notfications alert if are set to no
 
 
X video lunch

NEXT FEATURES
1. i want to evidence somehow the setting button in order to make it press (small shake maybe? as pages ios)
2. picker view in the setting?
3. review request notificatin alert and company
 
*/

/// BUGS:

// if i stop the timer the notification of timer finished comes anyway
// the circle when i press done in the preferences doesn't shrink but in the preview yes??
// if i set not allow notifications and then i set it mannualy when i open the app i see for half second the alert of turning on the notification and then it disappear
// if i move the circle on the bar outside of the bar it goes far and come back,but it just shouldn't.

import SwiftUI
import CoreData

let screen = UIScreen.main.bounds
let myCoef = screen.size.width / 375 // if iphone x = 1 if iphone se = 0.82

struct Home: View {
    
    @State var circlePressed = false
//    @State var showPreferencesView = true
    @EnvironmentObject var timerVM : TimerViewModel
    @Environment(\.managedObjectContext) var moc
    
    @State var showPlanView = true
    @State var showDoView = false
    @State var showChartsView = false
    
    @State var putAwayMenu = false
    
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
        
        ZStack {

                Color(#colorLiteral(red:0.89, green:0.90, blue:0.93, alpha:1.00))
                    .edgesIgnoringSafeArea(.all)
                             
                VStack {
                    
                    if showPlanView {
                        
                        PlanView(showPlanView: $showPlanView, showDoView: $showDoView, showChartsView: $showChartsView)
                            .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                        
                    }
                    if showDoView {
                        
                        DoView(putAwayMenu: $putAwayMenu)
                            .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                    }
                    if showChartsView {
                        
                        TrackView(goals: goals, sessions: sessions)
                    }
                    
                    if !putAwayMenu {
                    MenuPane(showGoal:  $showPlanView , showHome: $showDoView , showCharts:  $showChartsView)
                        .ignoresSafeArea(.keyboard, edges: .vertical)
//                    .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                        
                        if !UIDevice.current.hasNotch {
                            Spacer().frame(height: 18)
                        }
                       
                    }
                }
                
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        // for ios 14 the keyboard now move the all view to the top but with this line you cancel this behavior
        
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

