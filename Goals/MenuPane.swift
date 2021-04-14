//
//  MenuPane.swift
//  Foocus
//
//  Created by Riccardo Carlotto on 27/07/2020.
//  Copyright © 2020 Riccardo Carlotto. All rights reserved.
//


import SwiftUI

struct MenuPane: View {
    
    @EnvironmentObject var timerVM : TimerViewModel
    @Binding var showPlan: Bool
    @Binding var showDo: Bool
    @Binding var showCharts: Bool
    @Binding var showSettings: Bool
    
    var body: some View {
         ZStack {
                
                Rectangle()
                    .cornerRadius(30)
                    .frame(width:screen.width - 10, height:90)
                    .foregroundColor(Color(#colorLiteral(red:0.89, green:0.90, blue:0.93, alpha:1.00)))
                    .modifier(ShadowLightModifier())
                
                ZStack {
                    
                    AntiRilievoView(width: 90, height: 90, cornerRadius: 25)
                        .offset(x: showPlan ? -screen.width / 2.9 : .zero)
                        .offset(x:showDo ? -screen.width / 8.2 : .zero)
                        .offset(x: showCharts ? screen.width / 9 : .zero)
                        .offset(x: showSettings ? screen.width / 2.9 : .zero)
                        .animation(.linear)
                    
                    HStack {
                        
                        Spacer()
                        
                        VStack(alignment: .center, spacing: -3.0) {
                            
                            IconView(image:Image(uiImage:#imageLiteral(resourceName: "blueprint")), color: showPlan ? Color(timerVM.firstColorText) : Color(#colorLiteral(red: 0.8469662666, green: 0.8471121192, blue: 0.8469570279, alpha: 1)))
                                .animation(.linear)
                                .onTapGesture {
                                    self.timerVM.classicVibration()
                                    withAnimation {
                                    self.showPlan = true; self.showDo = false; self.showCharts = false; self.showSettings = false
                                    }
                            }
                            
                            
                            
                            Text("PLAN")
                                .fontWeight(.medium)
                                .foregroundColor(showPlan ? Color(timerVM.firstColorText) : Color(#colorLiteral(red: 0.8469662666, green: 0.8471121192, blue: 0.8469570279, alpha: 1)))
                                .shadow(color: Color.black.opacity(0.3), radius: 0.5, x: 0.5, y: 0.5)
                                .shadow(color: Color.white.opacity(0.9), radius: 0.5, x: -1, y: -1)
                                .animation(.linear)
                            
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .center, spacing: -3.0) {
                            
                            IconView(image:Image(uiImage:#imageLiteral(resourceName: "goal")), color: showDo ? Color(timerVM.firstColorText) : Color(#colorLiteral(red: 0.8469662666, green: 0.8471121192, blue: 0.8469570279, alpha: 1)))
                                .animation(.linear)
                                .onTapGesture {
                                    self.timerVM.classicVibration()
                                    withAnimation {
                                    self.showDo = true; self.showPlan = false; self.showCharts = false; self.showSettings = false
                                    }
                            }
                            
                            
                            Text("DO")
                                .fontWeight(.medium)
                                .foregroundColor(showDo ? Color(timerVM.firstColorText) : Color(#colorLiteral(red: 0.8469662666, green: 0.8471121192, blue: 0.8469570279, alpha: 1)))
                                .shadow(color: Color.black.opacity(0.3), radius: 0.5, x: 0.5, y: 0.5)
                                .shadow(color: Color.white.opacity(0.9), radius: 0.5, x: -1, y: -1)
                                .animation(.linear)
                            
                            
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .center, spacing: -3.0) {
                            IconView(image:Image(uiImage:#imageLiteral(resourceName: "graph")),
                                     color: showCharts ? Color(timerVM.firstColorText) : Color(#colorLiteral(red: 0.8469662666, green: 0.8471121192, blue: 0.8469570279, alpha: 1)))
                                .animation(.linear)
                                .onTapGesture {
                                    self.timerVM.classicVibration()
                                    withAnimation {
                                        self.showCharts = true; self.showPlan = false; self.showDo = false; self.showSettings = false
                                    }
                            }
                            
                            Text("TRACK")
                                .fontWeight(.medium)
                                .foregroundColor(showCharts ? Color(timerVM.firstColorText) : Color(#colorLiteral(red: 0.8469662666, green: 0.8471121192, blue: 0.8469570279, alpha: 1)))
                                .shadow(color: Color.black.opacity(0.3), radius: 0.5, x: 0.5, y: 0.5)
                                .shadow(color: Color.white.opacity(0.9), radius: 0.5, x: -1, y: -1)
                                .animation(.linear)
                        }
                        
                        
                        Spacer()
                        
                        VStack(alignment: .center, spacing: -3.0) {
                            
                            IconView(image:Image(uiImage:#imageLiteral(resourceName: "noun_setting_196307")), color: showSettings ? Color(timerVM.firstColorText) : Color(#colorLiteral(red: 0.8469662666, green: 0.8471121192, blue: 0.8469570279, alpha: 1)))
                                .animation(.linear)
                                .onTapGesture {
                                    self.timerVM.classicVibration()
                                    withAnimation {
                                        self.showSettings = true; self.showPlan = false; self.showDo = false; self.showCharts = false
                                    }
                            }
                            
                            
                            Text("SETUP")
                                .fontWeight(.medium)
                                .foregroundColor(showSettings ? Color(timerVM.firstColorText) : Color(#colorLiteral(red: 0.8469662666, green: 0.8471121192, blue: 0.8469570279, alpha: 1)))
                                .shadow(color: Color.black.opacity(0.3), radius: 0.5, x: 0.5, y: 0.5)
                                .shadow(color: Color.white.opacity(0.9), radius: 0.5, x: -1, y: -1)
                                .animation(.linear)
                            
                        }
                        
                        
                        Spacer()
                            
                            
                    }
                }
                
                //            .frame(width: 220 * (myCoef), height: 70 * (myCoef))
            }
            
            
            
        
    }
    
}



struct MenuPane_Previews: PreviewProvider {
    static var previews: some View {
        MenuPane(showPlan: .constant(false), showDo: .constant(true), showCharts: .constant(false), showSettings: .constant(false)).environmentObject(TimerViewModel())
    }
}
