//
//  CrownView.swift
//  Foocus
//
//  Created by Riccardo Carlotto on 20/04/2020.
//  Copyright © 2020 Riccardo Carlotto. All rights reserved.
//

import SwiftUI

struct CrownView: View {
    
    @EnvironmentObject var timerVM : TimerViewModel
    @Binding var rectangularize : Bool
    
    var body: some View {
        
        ZStack {
            
            if !rectangularize {
                
                RingView(color1: self.timerVM.colorBar1 , color2:  self.timerVM.colorBar2, width: 215 * myCoef , height: 215 * myCoef, show: .constant(true))
                    .animation(.default)
                
                Circle() // light big circle
                    .stroke(style: StrokeStyle(lineWidth:20 * myCoef))
                    .foregroundColor(Color(#colorLiteral(red: 0.9509803922, green: 0.9565930536, blue: 1, alpha: 1)))//light
                    .brightness(0.1)
                    .frame(width:250 * myCoef, height: 250 * myCoef)
                    .blur(radius: 3.5)
                    .offset(x: -5, y: -5)
                    .opacity(0.6)
                
            }
            
            Rectangle()
                .foregroundColor(Color(#colorLiteral(red: 0.9509803922, green: 0.9565930536, blue: 1, alpha: 1)))//light
                //                    .frame(width:200 * myCoef, height: 200 * myCoef)
                .frame(width:rectangularize ? 270 * myCoef : 200 * myCoef, height: rectangularize ? 270 * myCoef : 200 * myCoef)
                .cornerRadius(rectangularize ? 30 : 200)
                .brightness(0.1)
                .blur(radius: 2.5)
                .offset(x: -5, y: -5)
                .opacity(0.6)
            
            ZStack {
                if !rectangularize {
                    Circle() //shadow big circle
                        .stroke(style: StrokeStyle(lineWidth:20 * myCoef))
                        .foregroundColor(Color(#colorLiteral(red: 0.8897886276, green: 0.8975299001, blue: 0.930650413, alpha: 1)))
                        .frame(width:250 * myCoef, height: 250 * myCoef)
                        .brightness(-0.3)
                        .blur(radius: 3)
                        .offset(x: 5, y: 5)
                }
                Rectangle()
                    .foregroundColor(Color(#colorLiteral(red: 0.8897886276, green: 0.8975299001, blue: 0.930650413, alpha: 1)))
                    //                        .frame(width:200 * myCoef, height: 200 * myCoef)
                    .frame(width:rectangularize ? 270 * myCoef : 200 * myCoef, height: rectangularize ? 270 * myCoef : 200 * myCoef)
                    .cornerRadius(rectangularize ? 30 : 200)
                    .brightness(-0.2)
                    .blur(radius: 2.5)
                    .offset(x: 5, y: 5)
                
                ZStack {
                    if !rectangularize {
                        Circle() //actual big cirlce
                            .stroke(style: StrokeStyle(lineWidth:20 * myCoef))
                            .foregroundColor(Color(#colorLiteral(red: 0.8897886276, green: 0.8975299001, blue: 0.930650413, alpha: 1)))
                            .frame(width:250 * myCoef, height: 250 * myCoef)
                    }
                    Rectangle()
                        .foregroundColor(Color(#colorLiteral(red: 0.8897886276, green: 0.8975299001, blue: 0.930650413, alpha: 1)))
                        //                            .frame(width:200 * myCoef, height: 200 * myCoef)
                        .frame(width:rectangularize ? 270 * myCoef : 200 * myCoef, height: rectangularize ? 270 * myCoef : 200 * myCoef)
                        .cornerRadius(rectangularize ? 30 : 200)
                    
                }
                if !rectangularize {
                    
                    TimerView()
                   
                } else {
                    
                    ScrollView{
                        Text(" 1. Press ⏯ when you are working for your goal \n\n2. Press ⏩ or ⏯ when you finish. Your time spent will be saved and analyzed in the track view \n\nWhat is the 🍅 timer? \n\nIt is a time management method that uses the timer to break down work into intervals, traditionally 25 minutes in length, separated by short breaks to enable it tap the toggle to ON. \n\nHow it works when enabled? \n\n1. Press ⏯ when you are working for your goal \n\n2. Press ⏩ to go straight to the break \n\n3. Press the settings button to change the break and working time \n\n4. Long press ⏯ for a longer break \n\nWhy should I use it? \n\nThere are many research out there that proved a person need about 10 to 25 minutes to achieve high focus, and you also cannot effectively do something really intensive for much longer than 25-30 minutes. 🍅 timer help you to reduce that loosing focus effect. And you only need 5 minutes of break to recover your high focus.")
                            .font(.system(size: 17))
                            .foregroundColor(Color(timerVM.secondColorText))
                            .modifier(ShadowLightModifier())
                            .frame(width: 250)
                            .onTapGesture {
                                self.rectangularize.toggle()
                            }
                    }
                    .frame(height:240)
                }
            }
            
        }
        
    }
}


