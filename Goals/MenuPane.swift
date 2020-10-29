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
    @Binding var showGoal : Bool
    @Binding var showHome : Bool
    @Binding var showCharts : Bool
    
    var body: some View {
         ZStack {
                
                Rectangle()
                    .cornerRadius(30)
                    .frame(width:screen.width, height:90)
                    .foregroundColor(Color(#colorLiteral(red:0.89, green:0.90, blue:0.93, alpha:1.00)))
                    .modifier(ShadowLightModifier())
                
                ZStack {
                    
                    AntiRilievoView(width: 90, height: 90, cornerRadious: 25)
                        
                        .offset(x: showGoal ? -screen.width / 3.5 : .zero)
                        .offset(x: showCharts ? screen.width / 3.5 : .zero)
                        .animation(.linear)
                    
                    HStack {
                        
                        Spacer()
                        
                        VStack(alignment: .center, spacing: -3.0) {
                            
                            IconView(image:Image(uiImage:#imageLiteral(resourceName: "blueprint")), color: showGoal ? Color(timerVM.firstColorText) : Color(#colorLiteral(red: 0.8469662666, green: 0.8471121192, blue: 0.8469570279, alpha: 1)))
                                .onTapGesture {
                                    self.timerVM.classicVibration()
                                    withAnimation {
                                    self.showGoal = true; self.showHome = false; self.showCharts = false
                                    }
                            }
                            
                            
                            
                            
                            Text("PLAN")
                                .foregroundColor(showGoal ? Color(timerVM.firstColorText) : Color(#colorLiteral(red: 0.8469662666, green: 0.8471121192, blue: 0.8469570279, alpha: 1)))
                                .modifier(ShadowLightModifier())
                                .animation(.linear)
                            
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .center, spacing: -3.0) {
                            
                            IconView(image:Image(uiImage:#imageLiteral(resourceName: "goal")), color: showHome ? Color(timerVM.firstColorText) : Color(#colorLiteral(red: 0.8469662666, green: 0.8471121192, blue: 0.8469570279, alpha: 1)))
                                .onTapGesture {
                                    self.timerVM.classicVibration()
                                    withAnimation {
                                    self.showHome = true; self.showGoal = false; self.showCharts = false
                                    }
                            }
                            
                            
                            
                            Text("DO")
                                .foregroundColor(showHome ? Color(timerVM.firstColorText) : Color(#colorLiteral(red: 0.8469662666, green: 0.8471121192, blue: 0.8469570279, alpha: 1)))
                                .modifier(ShadowLightModifier())
                                .animation(.linear)
                            
                            
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .center, spacing: -3.0) {
                            IconView(image:Image(uiImage:#imageLiteral(resourceName: "graph")),
                                     color: showCharts ? Color(timerVM.firstColorText) : Color(#colorLiteral(red: 0.8469662666, green: 0.8471121192, blue: 0.8469570279, alpha: 1)))
                                .onTapGesture {
                                    self.timerVM.classicVibration()
                                    withAnimation {
                                    self.showCharts = true; self.showGoal = false; self.showHome = false
                                    }
                            }
                            
                            Text("TRACK")
                                .foregroundColor(showCharts ? Color(timerVM.firstColorText) : Color(#colorLiteral(red: 0.8469662666, green: 0.8471121192, blue: 0.8469570279, alpha: 1)))
                                .modifier(ShadowLightModifier())
                                .animation(.linear)
                        }
                        
                        Spacer()
                            
                            .animation(.linear)
                    }
                }
                
                //            .frame(width: 220 * (myCoef), height: 70 * (myCoef))
            }
            
            
            
        
    }
    
}



struct MenuPane_Previews: PreviewProvider {
    static var previews: some View {
        MenuPane(showGoal: .constant(true), showHome: .constant(false), showCharts: .constant(false)).environmentObject(TimerViewModel())
    }
}
