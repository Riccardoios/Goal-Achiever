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
    
    @State var circlePressed = false
    @State var showPreferencesView = false
    
    @Binding var putAwayMenu: Bool
    
    var body: some View {
        
        let permissionsBinding = Binding (
            get: {self.timerVM.remidUserToActivateNotification},
            set: {
                
                //               self.timerVM.requestNotificationAutorization();
                
                self.timerVM.remidUserToActivateNotification = $0
                
        })
        
        return
            
            ZStack {
                
                if !showPreferencesView {
                    
                VStack {
                    
                    
                    
                    HStack(alignment:.top){
                        
                       
                            ColorButtonView(isPressed: $showInfo, color: timerVM.firstColorText, orText: true, textValue: "?", textSize: 30, antiRiSize: 50, antiRiCorner: 50, rectSize: 40, rectCorner: 40)
                                .onTapGesture {
                                    self.showInfo.toggle()
                                }
                                .padding(.leading)
                        
                        
                        Spacer()
                        
                        if !UIDevice.current.hasNotch {
                            
                        VStack {

                            FoocusTitleView()

                            Text("\(timerVM.whichCycle())")
                                .foregroundColor(Color(timerVM.backgroundColor))
                                .font(.system(size: timerVM.secondSizeFont * myCoef))
                                .modifier(ShadowLightModifier())
                                .frame(minWidth:110)
                            
                        }.frame(minHeight:110)
                        

                        Spacer()
                        }
                        
                        
                            ButtonView(width: 50, height: 50, image: Image(uiImage:#imageLiteral(resourceName: "noun_setting_196307")), offsetY: 2, cornerRadius: 90)
                                
                                .onTapGesture {
                                    self.timerVM.myTimer?.invalidate()
                                    self.circlePressed.toggle(); self.timerVM.robustVibration();
                                    Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in                               self.showPreferencesView = true
                                    }
                            }
                                .padding(.trailing)
                          
                        
                    }.frame(minHeight:UIDevice.current.hasNotch ? nil : 110)
                    
                    if UIDevice.current.hasNotch {
                    FoocusTitleView()

                    Text("\(timerVM.whichCycle())")
                        .foregroundColor(Color(timerVM.backgroundColor))
                        .font(.system(size: timerVM.secondSizeFont * myCoef))
                        .modifier(ShadowLightModifier())
                        .padding(.bottom)
                    
                    Spacer()
                    }
                    //                .padding(.top, 30)
                    
                    
//                    Spacer()
                    
//                    VStack {
                        CrownView(rectangularize: $showInfo)
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
                                    self.timerVM.backward()
                                }) {
                                    ButtonView(width: 60 * myCoef, height: 40  * myCoef,  image: Image(uiImage: #imageLiteral(resourceName: "noun_forward_1248722 copy")), imageSize: 1.3, offsetY: -2, cornerRadius: 40)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    
                                    // i use this button just for the animation the actions are in ontap gestures
                                    
                                }) {
                                    ButtonView(width: 100  * myCoef, height: 100  * myCoef, image: Image(systemName: "playpause"), imageSize: 0.8 , offsetX: -1, cornerRadius: 100)
                                        .onTapGesture {
                                            self.timerVM.classicVibration(); self.timerVM.playPause()
                                    }
                                    .onLongPressGesture(minimumDuration:1) {
                                        self.timerVM.robustVibration(); self.timerVM.setLongBreak()
                                    }
                                    
                                    
                                }
                                .alert(isPresented: permissionsBinding) { () -> Alert in
                                    Alert(title: Text("Please Enable notification Access in Settings -> Foocus -> Notifications -> Allow Notifications, otherwise Foocus won't work properly"))
                                }
                                
                                
                                Spacer()
                                
                                Button(action: {
                                    
                                    self.timerVM.classicVibration();
                                    self.timerVM.forward();
                                }) {
                                    ButtonView(width: 60 * myCoef, height: 40  * myCoef, image:Image(uiImage:#imageLiteral(resourceName: "noun_forward_1248722")), imageSize: 1.3, offsetX: 3, offsetY: 2, cornerRadius: 40 )
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
                    
                    VStack{ //circle animation
                        HStack{
                            
                            Spacer()
                            
                            Circle()
                                .frame(width: circlePressed ? 2000 : 1, height: circlePressed ? 2000 : 1)
                                .foregroundColor(Color(#colorLiteral(red:0.89, green:0.90, blue:0.93, alpha:1.00)))
                                .modifier(ShadowLightModifier())
                                .onTapGesture {
                                    self.circlePressed.toggle(); self.timerVM.robustVibration()
                            }
                            .animation(.easeInOut(duration: 5.0))
                            .padding(.trailing, 30)
                            
                        }
                        .frame(width:screen.width, height:100)
                        
                        Spacer()
                    }
                    .onAppear{self.putAwayMenu = false}
                    .onDisappear{
                        self.saveSession(input: self.timerVM.secondForSession)
                    }
                    
                }
                
                if showPreferencesView {
                    SettingsScreenView(showView: $showPreferencesView, ballActive: $circlePressed)
                        .onAppear{self.putAwayMenu = true}
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
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DoView(putAwayMenu: .constant(false)).environmentObject(TimerViewModel())
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

