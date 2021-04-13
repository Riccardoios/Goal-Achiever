//
//  BarPreferenceView.swift
//  Foocus
//
//  Created by Riccardo Carlotto on 03/05/2020.
//  Copyright © 2020 Riccardo Carlotto. All rights reserved.
//


// esclude with .animation(nil) the movement that i want to exclude
import SwiftUI


struct BarPreferenceView: View {
    
    @EnvironmentObject var timerVM : TimerViewModel
    @State var lowerBound : Int = 10
    @State var upperBound : Int = 60
    @Binding var output : Int
    //    @State var output : Int = 0
    
    @State var movingWheelState : CGSize = .zero
    @State var accumulatedMoving : CGSize = .zero   
    var body: some View {
        
        ZStack{
            
            //            VStack {
            //                Text("\(output)")
            //                Spacer()
            //            }
            
            VStack{
                
                HStack {
                    
                    if screen.width >= 768 {
                        Spacer().frame(width:screen.width / 4)
                    }
                    
                    
                    Group {
                        
                        Color(#colorLiteral(red: 0.681924929, green: 0.6859496321, blue: 0.7170756985, alpha: 1))
                            .frame(width: 2, height: 10)
                            .cornerRadius(9)
                        
                        //                        AntiRilievoView(width: 14, height: 20, cornerRadius: 9)
                        
                        Spacer()
                        
                        Color(#colorLiteral(red: 0.681924929, green: 0.6859496321, blue: 0.7170756985, alpha: 1))
                            .frame(width: 2, height: 10)
                            .cornerRadius(9)
                        //                        AntiRilievoView(width: 14, height: 20, cornerRadius: 9)
                        
                        Spacer()
                        
                        Color(#colorLiteral(red: 0.681924929, green: 0.6859496321, blue: 0.7170756985, alpha: 1))
                            .frame(width: 2, height: 10)
                            .cornerRadius(9)
                        //                        AntiRilievoView(width: 14, height: 20, cornerRadius: 9)
                        
                        Spacer()
                        
                        Color(#colorLiteral(red: 0.681924929, green: 0.6859496321, blue: 0.7170756985, alpha: 1))
                            .frame(width: 2, height: 10)
                            .cornerRadius(9)
                        //                        AntiRilievoView(width: 14, height: 20, cornerRadius: 9)
                        
                        Spacer()
                        
                        Color(#colorLiteral(red: 0.681924929, green: 0.6859496321, blue: 0.7170756985, alpha: 1))
                            .frame(width: 2, height: 10)
                            .cornerRadius(9)
                        //                        AntiRilievoView(width: 14, height: 20, cornerRadius: 9)
                    }
                    
                    if screen.width >= 768 {
                        Spacer().frame(width:screen.width / 4)
                    }
                    
                }
                .padding(.horizontal, 30)
                Spacer().frame(height: 40)
                
            }
            
            if screen.width < 768 {
                Rectangle()
                    .frame(width: screen.width - 50, height: 10)
                    .cornerRadius(30)
                    .foregroundColor(Color(timerVM.backgroundColor))
                    .shadow(color: Color.black.opacity(0.35), radius: 2, x: 1, y: 1)
                    .shadow(color: Color.white.opacity(1), radius: 1, x: -2, y: -2)
                
                
//                AntiRilievoView(width: screen.width - 50 , height: 20, cornerRadius: 30)
            } else {
                
                Rectangle()
                    .frame(width: 364, height: 10)
                    .cornerRadius(30)
                    .foregroundColor(Color(timerVM.backgroundColor))
                    .shadow(color: Color.black.opacity(0.35), radius: 2, x: 1, y: 1)
                    .shadow(color: Color.white.opacity(1), radius: 1, x: -2, y: -2)
                
//                AntiRilievoView(width: 364 , height: 20, cornerRadius: 30)
            }
            
            ZStack {
                
//                Color(#colorLiteral(red: 0.5996333957, green: 0.6073881984, blue: 0.6364005208, alpha: 1)).brightness(0.1)
//
//                Circle()
//                    .foregroundColor(Color(#colorLiteral(red: 0.9567099214, green: 0.9566277862, blue: 0.9730718732, alpha: 1)))
//                    .blur(radius: 4)
//                    .offset(x: -8, y: -8)
//
//                Circle()
//                    .fill(
//
//                        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9567099214, green: 0.9566277862, blue: 0.9730718732, alpha: 1)), Color(#colorLiteral(red: 0.5996333957, green: 0.6073881984, blue: 0.6364005208, alpha: 0.567583476))]), startPoint: .leading, endPoint: .trailing)
//                    )
//                    .frame(width: 30)
//                    .rotationEffect(Angle(degrees: 220))
                Circle()
                    .foregroundColor(Color(timerVM.backgroundColor))
                    .frame(width:40)
                    .modifier(ShadowLightModifier())
                
            }
            .frame(width: 40)
//            .clipShape(Circle())
//            .shadow(color: Color(#colorLiteral(red: 0.5996333957, green: 0.6073881984, blue: 0.6364005208, alpha: 1)), radius: 2, x: 2, y: 2)
            .offset(x: movingWheelState.width)
            .gesture(
                
                
                DragGesture().onChanged({ (value) in
                    
                        self.movingWheelState = CGSize(width: value.translation.width + self.accumulatedMoving.width, height: 0)
                        
                        self.output = self.whichRange(lowerBound: self.lowerBound, upperBound: self.upperBound)
                    
                    
                })
                .onEnded({ (value) in
                    
                        self.movingWheelState = CGSize(width: value.translation.width + self.accumulatedMoving.width, height: 0)
                        
                        if self.movingWheelState.width > 150 {
                            self.movingWheelState.width = 150
                        }
                        
                        if self.movingWheelState.width < -150 {
                            self.movingWheelState.width = -150
                        }
                        
                        self.accumulatedMoving = self.movingWheelState
                        
                        self.output = self.whichRange(lowerBound: self.lowerBound, upperBound: self.upperBound)
                    
                })
                
            )
            
            
            
            
        }
        .animation(.none)
    }
    
    func whichRange(lowerBound:Int, upperBound:Int) -> Int {
        let percentageValueFromInput:Float = ((Float(movingWheelState.width) + 150.0)/300)*100
        //this  rappresent the persentage value from a random number betweeen -150 e 150
        
        let hundredPercentOfMyRange = upperBound - lowerBound
        
        //yo : 100 = output : hundredPercent
        let output = (Int(percentageValueFromInput) * hundredPercentOfMyRange)/100
        
        return output + lowerBound
    }
    
    
}

struct BarPreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        BarPreferenceView(output: .constant(0))
    }
}
