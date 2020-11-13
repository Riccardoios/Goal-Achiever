//
//  DoView.swift
//  Foocus

//
//  Created by Riccardo Carlotto on 09/04/2020.
//  Copyright © 2020 Riccardo Carlotto. All rights reserved.
//

/*
 - after do the setting view that take in consideratino all the views as settings and also edit the button that is embedded in all the views not anymore in the home
 */

// when you press the play button the timer will run and it will track your performances in the track view you can customize your timer of doing your goal and your breaks


// we set the timer with the pomodoro tecqnique which make you more effective


// save session on disappear of this view and set to 0 the pubblic seconds for session
import SwiftUI
import StoreKit

struct DoView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Sessions.entity(), sortDescriptors: [
        NSSortDescriptor(key: #keyPath(Sessions.date), ascending: false)
    ]) var sessions: FetchedResults<Sessions>
    @FetchRequest(entity: Goal.entity(), sortDescriptors: [
        NSSortDescriptor(key: #keyPath(Goal.dateEdited), ascending: false)
    ]) var goals: FetchedResults<Goal> // from the oldest to the newst
    
    @EnvironmentObject var timerVM : TimerViewModel
    @State var showInfo = false
    
    @State var wQuestionB: CGFloat = 40
    @State var hQuestionB: CGFloat = 40
    
    @State var isTomatoTimer = false
    @State var animateButton = false
    
    var body: some View {
        
        let permissionsBinding = Binding (
            get: {self.timerVM.remidUserToActivateNotification},
            set: {
                
                //               self.timerVM.requestNotificationAutorization();
                
                self.timerVM.remidUserToActivateNotification = $0
                
        })
        
        return
            
            ZStack {
                VStack {
                    HStack(alignment:.top){
                        
                        ZStack {
                            
                            WaveAnimationView(animate: animateButton)
                                .frame(width: 65, height: 65)
                                .padding(.leading)
                            
                            
                            //MARK: - ? BUTTON
                            ColorButtonView(isPressed: $showInfo, color: timerVM.firstColorText, orText: true, textValue: "?", textSize: 30, antiRiSize: 50, antiRiCorner: 50, rectSize: 40, rectCorner: 40)
                                .padding(.leading)
                               
                        }
                        
                        
                        Spacer()
                        
                        if !UIDevice.current.hasNotch {
                            
                        VStack {

                            FoocusTitleView(isTomatoTimer: $isTomatoTimer)

                            
                            
                            Text(isTomatoTimer ? "\(timerVM.whichCycle())" : "")
                                .foregroundColor(Color(timerVM.backgroundColor))
                                .font(.system(size: timerVM.secondSizeFont * myCoef))
                                .modifier(ShadowLightModifier())
                                .frame(minWidth:110)
                            
                            
                        }.frame(minHeight:110)
                        

                        Spacer()
                        }
                        // MARK: - TOMATO BUTTONS
                        ZStack(alignment: .center) {
                            
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 80, height: 80)
                                .foregroundColor(Color(timerVM.backgroundColor))
                                .modifier(ShadowLightModifier())
                            
                            
                            VStack{
                                
                                Text("🍅 Timer")
                                    .modifier(ShadowLightModifier())
                                    .font(.system(size: timerVM.secondSizeFont / 1.5))
                                    .foregroundColor(Color(timerVM.firstColorText))
                                
                                
                                ToggleButton(toggle: $isTomatoTimer)
                                    .animation(.linear)
                                    .onTapGesture {
                                        self.timerVM.robustVibration();
                                       

                                    }
                                  
                            }
                            .frame(width: 80, height: 80)
                            
                        }
                        .padding(.trailing)
                        
                    }.frame(minHeight:UIDevice.current.hasNotch ? nil : 110)
                    
                    if UIDevice.current.hasNotch {
                        FoocusTitleView(isTomatoTimer: $isTomatoTimer)

                        
                        
                        Text(isTomatoTimer ? "\(timerVM.whichCycle())" : "")
                        .foregroundColor(Color(timerVM.backgroundColor))
                        .font(.system(size: timerVM.secondSizeFont * myCoef))
                        .modifier(ShadowLightModifier())
                        .padding(.bottom)
                        
                    Spacer()
                    }
                    
                    
//                    Spacer()
                    
//                    VStack {
                    CrownView(rectangularize: $showInfo, isTomatoTimer: $isTomatoTimer)
                            .animation(.linear)
//                    }
//                    VStack {
//                        Spacer()
//                        HStack {
//                            Spacer()
//
//                        }
//                        if screen.size.height <= 667 || screen.size.height >= 900 {
//                            // if is an iphone se or smaller screen
//                            Spacer()
//                                .frame(height: 20 * myCoef)
//                        }
//                    }
                    
                    Spacer()
                    
                    VStack {
                        Spacer()
                        HStack {
                            HStack {
                                
                                Button(action: {self.timerVM.classicVibration();
                                    if isTomatoTimer {
                                    self.timerVM.backward()
                                    } else {
                                        saveSession(input: Int32(self.timerVM.normalTimer))
                                        self.timerVM.backwardNormalTimer();
                                        
                                    }
                                }) {
                                    ButtonView(width: isTomatoTimer ? 60 * myCoef : 50  * myCoef, height: isTomatoTimer ? 40  * myCoef : 50 * myCoef,  image: isTomatoTimer ? Image(uiImage: #imageLiteral(resourceName: "noun_forward_1248722 copy")) : Image(systemName: "gobackward"), imageSize: isTomatoTimer ? 1.3 : 0.9, offsetY: -2, cornerRadius: 40)
                                }
                                
                                Spacer()
                                
                                // MARK: - PLAYPAUSE BUTTON
                                
                                Button(action: {
                                    
                                    // i use this button just for the animation the actions are in ontap gestures
                                    
                                }) {
                                    
                                    if isTomatoTimer {
                                        ButtonView(width: 100  * myCoef, height: 100  * myCoef, image: Image(systemName: "playpause"), imageSize: 0.8 , offsetX: -1, cornerRadius: 100)
                                            .onTapGesture {
                                                self.timerVM.classicVibration(); self.timerVM.playPauseTomatoTimer();
                                                showReviewAfter3()
                                                
                                            }
                                            .onLongPressGesture(minimumDuration:1) {
                                                self.timerVM.robustVibration(); self.timerVM.setLongBreak()
                                            }
                                            .onAppear{
                                                self.timerVM.myNormalTimer?.invalidate()
                                            }
                                    } else {
                                        
                                        ButtonView(width: 100  * myCoef, height: 100  * myCoef, image: Image(systemName: "playpause"), imageSize: 0.8 , offsetX: -1, cornerRadius: 100)
                                            .onTapGesture {
                                                self.timerVM.classicVibration();
                                               
                                                self.timerVM.playPauseNormalTimer()
                                            }
                                            .onAppear{
                                                self.timerVM.myTimer?.invalidate()
                                            }
                                        
                                    }
                                    
                                }
                                .alert(isPresented: permissionsBinding) { () -> Alert in
                                    Alert(title: Text("Please Enable notification Access in Settings -> Goals -> Notifications -> Allow Notifications, otherwise Goals won't work properly"))
                                }
                                
                                
                                Spacer()
                                
                                if isTomatoTimer{
                                    Button(action: {
                                        
                                        self.timerVM.classicVibration();
                                        self.timerVM.forward();
                                    }) {
                                        ButtonView(width: 60 * myCoef, height: 40 * myCoef, image:Image(uiImage:#imageLiteral(resourceName: "noun_forward_1248722")), imageSize: 1.3, offsetX: 3, offsetY: 2, cornerRadius: 40 )
                                    }
                                } else {
                                    Spacer()
                                        .frame(width: 60 * myCoef * myCoef, height: 40 * myCoef)
                                }
                            }
                            .frame(width: 150 * myCoef, height:130 * myCoef)
                            .padding()
                            
                        }
//                        if screen.size.height <= 667{
//                            // if is an iphone se or smaller screen
//                            Spacer()
//                                .frame(height: 10 * myCoef)
//                        }
//
//                        if screen.size.height >= 900{
//                            // if is an iphone se or smaller screen
//                            Spacer()
//                                .frame(height: 60)
//                        }
                        Spacer()
                    }.frame(maxHeight: UIDevice.current.hasNotch ? nil : 100)
                    
                        
                    .onAppear{ self.timerVM.requestNotificationAutorization()
                        
                    }// end of contentView
                        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                            print("Moving to the background!")
                            self.timerVM.prepareForBackground()
                            
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                        print("Moving back to the foreground!")
                        self.saveSession(input: Int32(self.timerVM.getSecondsFromSleep()))
                    }
                    
                    Spacer()
                    
                }
                    
                    Spacer()
                    .onAppear{
                        self.mightAnimateQuestionMarkButton()
                        
                    }
                    .onDisappear{
                        self.saveSession(input: self.timerVM.secondForSession)
                       
                    }
                    
                
                
        }
    }
    
    func saveSession(input: Int32) {
        let newSession = Sessions(context: self.moc)
        
        newSession.title = goals.first?.title
        newSession.date = Date()
        
        // save the seconds as well
        newSession.secondsWorked = input
        
        //reset the second for session
        self.timerVM.secondForSession = 0
        print ("from save the session those are the seconds", newSession.secondsWorked)
        
        try? self.moc.save()
    }
    
    func mightAnimateQuestionMarkButton() {
        
        if goals.first?.title != nil {
            
            if sessions.first?.title != goals.first?.title {
                self.animateButton = true
            }
        }
        
    }
    
    func showReviewAfter3() {
        
        let runs = timerVM.getRunCounts()
        print("Show Review")
        
        if runs == 5 || runs == 30 || runs == 50 || runs == 100 {
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
           
            
        } else {
            
            print("Runs are not enough to request review!")
            
        }
        
    }

    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DoView().environmentObject(TimerViewModel())
                .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
                .previewDisplayName("iPhone SE")
            
//            DoView(putAwayMenu: .constant(false)).environmentObject(TimerViewModel())
//                .previewDevice(PreviewDevice(rawValue: "iPhone XR"))
//                .previewDisplayName("iPhone XR")
            
            //            DoView().environmentObject(TimerViewModel())
            //                .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch)"))
            //                .previewDisplayName("iPad Pro (12.9-inch)")
        }
    }
}

