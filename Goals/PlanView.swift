//
//  PlanView.swift
//  Foocus
//
//  Created by Riccardo Carlotto on 05/08/2020.
//  Copyright © 2020 Riccardo Carlotto. All rights reserved.
//

import SwiftUI
import CoreData
import Combine
import UserNotifications

struct PlanView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Goal.entity(), sortDescriptors: [
        NSSortDescriptor(key: #keyPath(Goal.dateEdited), ascending: false)
    ]) var goals: FetchedResults<Goal> // from the oldest to the newst
    
    @State var emojisArray = ["🛠", "💰", "📝", "🖋", "💻", "📚", "🎹", "🎯", "💼",
                              "🎸",  "🇬🇧", "🇪🇸", "🇨🇳", "🇫🇷", "🇮🇹"]
    @State var goalTitle : String = ""
    @State var numberOfDays : String = ""
    @State var statement : String = ""
    @State var selectedIndex = 11 //for the emoji
    @State var weekSelection : [Bool] = [false, false, false, false, false, false, false]
    @State var motivationText : String = ""
    @EnvironmentObject var timerVM : TimerViewModel
    @State var showGoalExamples = false
    @State private var scrollViewID = UUID() // a workaround to make the scrollview go to top
    
    @Binding var showPlanView: Bool
    @Binding var showDoView: Bool
    @Binding var showChartsView: Bool
    
    var body: some View {
        
         ZStack {
            
            ScrollView(.vertical, showsIndicators: true){
                
                VStack(alignment: .leading) {
                    
                    Group {
                        
                        Group {
                            
                            HStack {
                            Text("My goals")
                                .font(.system(size: timerVM.firstSizeFont * myCoef, weight: .regular ))
                                .foregroundColor(Color(timerVM.firstColorText))
                                .modifier(ShadowLightModifier())
                                .padding(.horizontal)
                                
                                Spacer()
                                
                                
                            }
                            
                            ZStack {
                                
                                AntiRilievoView(width: screen.width - 25, height: goals.isEmpty ? 100 * myCoef : 0, cornerRadious: 30)
                                
                                if goals.isEmpty {
                                    Text("You have 0 goals yet, to create one fill up the short form below")
                                        .font(.system(size: (timerVM.secondSizeFont - 3) * myCoef, weight: .regular))
                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineLimit(nil)
                                        .foregroundColor(Color(timerVM.secondColorText))
                                        .modifier(ShadowLightModifier())
                                        .frame(width: screen.width - 50, height: goals.isEmpty ? 100 : 0)
                                    
                                }
                                
                            }
                            .padding(.horizontal)
                            
//                            ForEach(goals, id:\.self, content: { index in
//                                GoalPaneView(goals: index, enlarge: .constant(index = 0 ? true : false), showPlanView: self.$showPlanView, showDoView: self.$showDoView, showChartsView: self.$showChartsView)
//
//                            })
                            ForEach(goals, id:\.self, content: { index in
                                GoalPaneView(goals: index, showPlanView: self.$showPlanView, showDoView: self.$showDoView, showChartsView: self.$showChartsView)
                                
                            })
                            
                        }
                        
                        Group {
                            Text("Set your goal")
                                .font(.system(size: timerVM.firstSizeFont * myCoef, weight: .regular ))
                                .foregroundColor(Color(timerVM.firstColorText))
                                .modifier(ShadowLightModifier())
                                .padding(.horizontal)
                            
                            HStack {
                                Text("What is your goal?")
                                    .font(.system(size: timerVM.secondSizeFont * myCoef, weight: .regular ))
                                    .foregroundColor(Color(timerVM.firstColorText))
                                    .modifier(ShadowLightModifier())
                                    .padding(.horizontal)
                                
                                Spacer()
                                
                                ColorButtonView(isPressed: $showGoalExamples, color: timerVM.firstColorText, orText: true, textValue: "?", textSize: timerVM.secondSizeFont, antiRiSize: 40, antiRiCorner: 40, rectSize: 30, rectCorner: 30)
                                    .padding(.trailing)
                                    .onTapGesture {
                                        self.showGoalExamples.toggle()
                                        self.timerVM.classicVibration()
                                }
                                
                            }
                            
                            TextField("Have short chats with native spanish", text: $statement)
                                .foregroundColor(Color(timerVM.secondColorText))
                                .font(.system(size: timerVM.secondSizeFont * myCoef, weight: .regular ))
                                .modifier(ShadowLightModifier())
                                .padding(.horizontal)
                        }
                        
                        
                        Group {
                            HStack {
                                Spacer()
                                ZStack {
                                    
                                    AntiRilievoView(width: screen.width - 25, height: self.showGoalExamples ? 320 : 0, cornerRadious: 30)
                                    
                                    if showGoalExamples {
                                        
                                        Text("To set a goal write a concrete statement, it has to be doable and challenging at the same time. In the end the commitment will make achive your goal. ex: Read one book a week for 5 weeks, Being able to play Jingle bells on the guitar, Study those 100 pages for the exam of art.")
                                            .font(.system(size: (timerVM.secondSizeFont - 3) * myCoef, weight: .regular))
                                            .fixedSize(horizontal: false, vertical: true)
                                            .lineLimit(nil)
                                            .foregroundColor(Color(timerVM.secondColorText))
                                            .modifier(ShadowLightModifier())
                                            .frame(width: screen.width - 70, height: 300)
                                            .onTapGesture {
                                                self.showGoalExamples.toggle()
                                        }
                                    }
                                    
                                }
                                
                                Spacer()
                            }
                            .frame(height: self.showGoalExamples ? 300 : 0)
                            .animation(.linear)
                        }
                        
                        Text("How many days do you give to yourself?")
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(nil)
                            .font(.system(size: timerVM.secondSizeFont * myCoef, weight: .regular ))
                            .foregroundColor(Color(timerVM.firstColorText))
                            .modifier(ShadowLightModifier())
                            .padding(.horizontal)
                        
                        TextField("30", text: $numberOfDays)
                            .foregroundColor(Color(timerVM.secondColorText))
                            .font(.system(size: timerVM.secondSizeFont * myCoef, weight: .regular ))
                            .modifier(ShadowLightModifier())
                            .padding(.horizontal)
                            .keyboardType(.numberPad)
                        
                        Text("Give it a short title")
                            .font(.system(size: timerVM.secondSizeFont * myCoef, weight: .regular ))
                            .foregroundColor(Color(timerVM.firstColorText))
                            .modifier(ShadowLightModifier())
                            .padding(.horizontal)
                        
                        TextField("Speak basic Spanish", text: $goalTitle)
                            .foregroundColor(Color(timerVM.secondColorText))
                            .font(.system(size: timerVM.secondSizeFont * myCoef, weight: .regular ))
                            .modifier(ShadowLightModifier())
                            .padding(.horizontal)
                            .onReceive(Just(self.goalTitle)) { inputValue in
                                
                                if inputValue.count > 15 { // limit the character to 15
                                    self.goalTitle.removeLast()
                                }
                        }
                        
                        Text("Choose one image")
                            .font(.system(size: timerVM.secondSizeFont * myCoef, weight: .regular ))
                            .foregroundColor(Color(timerVM.firstColorText))
                            .modifier(ShadowLightModifier())
                            .padding(.horizontal)
                            
                        
                        
                        ScrollView(.horizontal) {
                            
                            HStack {
                                ForEach(0..<emojisArray.count) { item in
                                    
                                    GoalIconView(emoji: self.emojisArray[item], isSelected: item == self.selectedIndex ? true : false)
                                        
                                        .onTapGesture {
                                            self.selectedIndex = item
                                            self.timerVM.classicVibration()
                                        }
                                        .frame(width:100, height:130)
                                    
                                }
                            }
                            .frame(height:130)
                            .padding(.horizontal)
                            
                        }
                        
                        Group {
                            Group {
                                Text("What are your ideal days to work for your goal?")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .lineLimit(nil)
                                    .font(.system(size: timerVM.secondSizeFont * myCoef, weight: .regular ))
                                    .foregroundColor(Color(timerVM.firstColorText))
                                    .modifier(ShadowLightModifier())
                                    .padding(.horizontal)
                                
                                HStack{
                                    
                                    Spacer()
                                    
                                    weekButtons(weekArray: $weekSelection)
                                    
                                    Spacer()
                                }
                                
                                Text("Only you can best motivate yourself, write a sentence:")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .lineLimit(nil)
                                    .font(.system(size: timerVM.secondSizeFont * myCoef, weight: .regular ))
                                    .foregroundColor(Color(timerVM.firstColorText))
                                    .modifier(ShadowLightModifier())
                                    .padding(.horizontal)
                                
                                TextField("This challenge is a breakthrough for me", text: $motivationText)
                                    .foregroundColor(Color(timerVM.secondColorText))
                                    .font(.system(size: timerVM.secondSizeFont * myCoef, weight: .regular ))
                                    .modifier(ShadowLightModifier())
                                    .padding(.horizontal)
                                
                                Spacer()
                                    .frame(height:50)
                            }
                            
                            Group {
                                
                                HStack {
                                    
                                    Spacer()
                                    
                                    // MARK: - save goal button
                                    
                                    Button(action: {
                                        self.timerVM.robustVibration()
                                        self.timerVM.settingsOnDefault()
                                        
                                        let newGoal = Goal(context: self.moc)
                                        let now = Date()
                                        
                                        newGoal.title = self.goalTitle
                                        newGoal.motivation = self.motivationText
                                        newGoal.image = self.emojisArray[self.selectedIndex]
                                        newGoal.statement = self.statement
                                        newGoal.daysToAchieve = self.numberOfDays
                                        newGoal.dateEdited = now
                                        newGoal.sunday = self.weekSelection[0]
                                        newGoal.monday = self.weekSelection[1]
                                        newGoal.tuesday = self.weekSelection[2]
                                        newGoal.wednesday = self.weekSelection[3]
                                        newGoal.thursday = self.weekSelection[4]
                                        newGoal.friday = self.weekSelection[5]
                                        newGoal.saturnday = self.weekSelection[6]
                                        
                                        newGoal.selected = now
                                        
                                        try? self.moc.save()
                                        
                                        self.notificationIdealDays()
                                        
                                        if Int(self.numberOfDays) != nil {
                                            timerVM.deadlineNotification(withinDays: Int(self.numberOfDays)!)
                                        }
                                        
                                        self.scrollViewID = UUID()
                                        
                                    }) {
                                        ZStack{
                                            ButtonView(width: 200, height: 90, cornerRadius: 30, showImage: false)
                                            
                                            Text("Save Goal")
                                                .foregroundColor(Color(timerVM.firstColorText))
                                                .font(.system(size: timerVM.secondSizeFont * myCoef, weight: .regular ))
                                                .modifier(ShadowLightModifier())
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                }
                                
                            }
                            Spacer()
                                .frame(height: 200)
                        }
                    }
                    
                }
                .padding(.top, 60)
                .animation(.linear)
                .onTapGesture {
                    self.showGoalExamples = false
                }
            }
            .onAppear{
                let center = UNUserNotificationCenter.current()
                center.getPendingNotificationRequests(completionHandler: { requests in
                    for request in requests {
                        print(request)
                    }
                })
            }
            .dismissKeyboardOnTap()
            .id(scrollViewID)
            
        }
        
    }
    
    func notificationIdealDays() {
        
                let content = UNMutableNotificationContent()
        
                content.title = "Reminder of: " + (goals.first?.image ?? "") + (goals.first?.title ?? "Your goal")
                content.body = self.timerVM.motivationQuote
                content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: "future_sms.mp3"))
        
                var datesOfNotifications = DateComponents()
                let arrOfWeek = [goals.first?.sunday, goals.first?.monday, goals.first?.tuesday, goals.first?.wednesday, goals.first?.thursday, goals.first?.friday, goals.first?.saturnday]
        
                var arrOftrueIndexes = [Int]()
                // find indexes of true
                for ind in 0...6 {
                    if arrOfWeek[ind] == true {
                        arrOftrueIndexes.append(ind+1) // + 1 is for the weekday
                    }
                }
        
                for elem in arrOftrueIndexes {
                    //trigger the notification as many time as there are element in the arr
                    datesOfNotifications.weekday = elem // weekday works counting from 1 from sunday
                    datesOfNotifications.hour = 9
        
                    let trigger = UNCalendarNotificationTrigger(dateMatching:datesOfNotifications, repeats: true)
                    let request = UNNotificationRequest(identifier: "goal reminder notification" + "\(elem)", content: content, trigger: trigger)
        
                    UNUserNotificationCenter.current().add(request)
        
                }
    }
    
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        PlanView(showPlanView: .constant(true), showDoView: .constant(false), showChartsView: .constant(false)).environmentObject(TimerViewModel())
        
    }
}
