//
//  GoalPaneView.swift
//  Foocus
//
//  Created by Riccardo Carlotto on 31/08/2020.
//  Copyright © 2020 Riccardo Carlotto. All rights reserved.
//

// just run the code the read the console you will understand

import SwiftUI
import CoreData

struct GoalPaneView: View {
    
    @Environment(\.managedObjectContext) var moc
    let goals:Goal
    
    @EnvironmentObject var timerVM : TimerViewModel
    
    var width: CGFloat = 340
    var height: CGFloat = 100
    var bigHeight: CGFloat = 400
    
    @State var enlarge = false
    @State var week = Array(repeatElement(false, count: 7))
    
    @Binding var showPlanView: Bool
    @Binding var showDoView: Bool
    @Binding var showChartsView: Bool
    
    var body: some View {
            ZStack {
            
            Color(#colorLiteral(red:0.89, green:0.90, blue:0.93, alpha:1.00))
            
            RoundedRectangle(cornerRadius: 45)
                .foregroundColor(Color(#colorLiteral(red:0.89, green:0.90, blue:0.93, alpha:1.00)))
                .modifier(ShadowLightModifier())
                .frame(maxWidth: width, minHeight: enlarge ? bigHeight : height)
            
            VStack {
                
                ZStack{
                    
                    HStack {
                        
                        Text(self.goals.image ?? "😇")
                        .font(.system(size: 40))
                        .modifier(ShadowLightModifier())
                        .padding()
                        
                        Spacer()
                        
                        ColorButtonView(isPressed: $enlarge, color: timerVM.firstColorText, orText: true, textValue: "i", textSize: 20, antiRiSize: 40, antiRiCorner: 40, rectSize: 30, rectCorner: 30)
                            .onTapGesture {
                                self.enlarge.toggle()
                                self.timerVM.classicVibration()
                        }
                        .padding(.bottom, 25)
                        .padding(.trailing)
                        
                    }
                   
                        HStack {
                            
                            Text(self.goals.title ?? "Unknown Title")
                                .font(.system(size: 30))
                                .foregroundColor(Color(timerVM.firstColorText))
                                .modifier(ShadowLightModifier())
                            
                            }
                        
                    
                }
                
                if enlarge {
                
                    Text(self.goals.statement ?? "Unknown Statement")
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(nil)
                        .font(.system(size: 20))
                        .foregroundColor(Color(timerVM.firstColorText))
                        .modifier(ShadowLightModifier())
                        .padding(.horizontal)
                    
                    weekButtons(weekArray: $week)
                        .onAppear{
                            self.loadTheWeek()
                    }
                    
                    Text("to finish before "  + self.timerVM.calculateTheFutureDate(whitin: goals.daysToAchieve)) 
                        .underline()
                        .font(.system(size: 20))
                        .foregroundColor(Color(timerVM.firstColorText))
                        .modifier(ShadowLightModifier())
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    Text(self.goals.motivation ?? "'motivational sentece Unkown'")
                        .italic()
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(nil)
                        .font(.system(size: 20))
                        .foregroundColor(Color(timerVM.firstColorText))
                        .modifier(ShadowLightModifier())
                        .padding(.horizontal)
                    
                    Spacer()
                    // MARK: - select this goal button
                    
                    HStack {
                        
                        Button(action: {
                            
                            self.goals.dateEdited = Date()  // this set as the goal for the doview
//                            try? self.moc.save() // just added check it out
                            self.showPlanView = false
                            self.showDoView = true
                            self.showChartsView = false
                            self.timerVM.classicVibration()
                            
                        }, label: {
                            ZStack{
                                ButtonView(width: 180, height: 50, cornerRadius: 20, showImage: false)
                                
                                Text("Let's do this")
                                    .foregroundColor(Color(timerVM.firstColorText))
                                    .font(.system(size: 18 * myCoef, weight: .regular ))
                                    .modifier(ShadowLightModifier())
                            }
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            // delete the current goal
                            self.moc.delete(self.goals)
                            
                            try? self.moc.save()
                            
                            let center = UNUserNotificationCenter.current()
                            center.removeAllPendingNotificationRequests()
                            
                            
                            self.timerVM.classicVibration()
                        }, label: {
                            ZStack{
                                ButtonView(width: 50, height: 50, cornerRadius: 20, showImage: false)
                                
                                Image(systemName: "trash")
                                    .foregroundColor(Color(timerVM.firstColorText))
                                    .font(.system(size: 18 * myCoef, weight: .regular ))
                                    .modifier(ShadowLightModifier())
                            }
                        })
                            .padding(.trailing)
                        
                    }
                }
                
            }
            .padding(7)
            .frame(maxWidth: width, minHeight: enlarge ? bigHeight : height)
        
            
        }
        .animation(.linear)
        .onTapGesture {
            self.enlarge.toggle()
        }
        
    }
    
    func loadTheWeek() {
        week = [goals.monday, goals.tuesday, goals.wednesday, goals.thursday, goals.friday, goals.saturnday, goals.sunday]
    }
    
    
    
}
