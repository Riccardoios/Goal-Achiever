//
//  SettingsScreenView.swift
//  Foocus
//
//  Created by Riccardo Carlotto on 26/04/2020.
//  Copyright © 2020 Riccardo Carlotto. All rights reserved.

import SwiftUI


struct SettingsScreenView: View {
    
    //    @State var textPressed = false
    @EnvironmentObject var timerVM : TimerViewModel
    var spaceInTheSpacer: CGFloat = 25
    @State var animateSave = false
    @State var showPayWall = false
    
    //    @State var myArr = [true, true, false, false] // for the logic of the color Buttons
    //    @State var MyPreviousArr = [true, true, false, false] // same
    //    @State var arrayOfIndexesOfChangedValues = [0,1] // same
    
    
    var body: some View {
        
        //        let activateYellow = Binding(
        //            get: { self.myArr[0] },
        //            set: {
        //                //change my arr based on the binding given from the toggle
        //                self.myArr[0] = $0
        //
        //                detectAnyChanges()
        //
        //            }
        //        )
        //
        //        let activateRed = Binding(
        //            get: { self.myArr[1]   },
        //            set: {
        //                self.myArr[1] = $0
        //                detectAnyChanges()
        //            }
        //        )
        //
        //        let activateGreen = Binding(
        //            get: { self.myArr[2] },
        //            set: {
        //                self.myArr[2] = $0
        //
        //               detectAnyChanges()
        //
        //            }
        //        )
        //
        //        let activateBlue = Binding(
        //            get: { self.myArr[3] },
        //            set: {
        //                self.myArr[3] = $0
        //
        //                detectAnyChanges()
        //            }
        //            )
        
        let enableNoStop = Binding(
            get: {self.timerVM.enableNoStop},
            set: {self.timerVM.enableNoStop = $0}
        )
        
        let focusTime = Binding(
            get: {self.timerVM.arrayOfInput[0]},
            set: {self.timerVM.arrayOfInput[0] = $0
                self.timerVM.updateArrayOfInputsAndTimersArray()}
        )
        
        let breakTime = Binding(
            get: {self.timerVM.arrayOfInput[1]},
            set: {self.timerVM.arrayOfInput[1] = $0
                self.timerVM.updateArrayOfInputsAndTimersArray()
            }
        )
        
        let cycles = Binding(
            get: {self.timerVM.arrayOfInput[2]},
            set: {self.timerVM.arrayOfInput[2] = $0
                self.timerVM.updateArrayOfInputsAndTimersArray()
            }
        )
        
        let longBreak = Binding(
            get: {self.timerVM.arrayOfInput[3]},
            set: {self.timerVM.arrayOfInput[3] = $0
                self.timerVM.updateArrayOfInputsAndTimersArray()
            }
        )
        //        func detectAnyChanges() {
        //            // save all the indexes changed in an array
        //
        //            // i have an array of false values and they will be changed how to detect them?
        //            // just toggle the last 2
        //            // check if myarr is different than myarr previus
        //            if myArr != MyPreviousArr {
        //
        //                // it is changed
        //                // detect which one is changed
        //                // print ("detected a change")
        //                // i want to know which one is changed
        //
        //                for i in 0...3 {
        //                    if myArr[i] != MyPreviousArr[i] {
        //                        arrayOfIndexesOfChangedValues.append(i)
        //                    }
        //
        //                }
        //                // print (arrayOfIndexesOfChangedValues)
        //
        //
        //                if arrayOfIndexesOfChangedValues.count >= 3 {
        //
        //                //  print ("ok now i toggle this index:", (arrayOfIndexesOfChangedValues.count - 3) )
        //
        //                    myArr[arrayOfIndexesOfChangedValues[arrayOfIndexesOfChangedValues.count - 3]].toggle()
        //                }
        //                // here I save the chaged value in the "previusArr"
        //                 MyPreviousArr = myArr
        //
        //            }
        //
        //        }
        
        
        return
            
            ScrollView(.vertical) {
                
                ZStack {
                        
                        VStack {
                            
                            HStack {
                                
                                Text("Settings")
                                    .foregroundColor(Color(timerVM.firstColorText))
                                    .font(.system(size: timerVM.firstSizeFont))
                                    .modifier(ShadowLightModifier())
                                    .padding()
                                
                                Spacer()
                                
                                Button(action: {
                                    
                                    self.timerVM.indexOfTimersArray = 0;
                                    
                                    //                                self.timerVM.changeColorCircleBar(Sequence: self.arrayOfIndexesOfChangedValues);
                                    
                                    self.timerVM.reset()
                                    self.animateSave.toggle()
                                    
                                    print (self.timerVM.arrayOfInput)
                                    
                                }) {
                                    ZStack{
                                        
                                        WaveAnimationView(animate: animateSave, lineWidth: 4, repetitions: 1)
                                            .frame(width:70, height:70)
                                        
                                        ButtonView(width: 50, height: 50, cornerRadius: 90, showImage: false)
                                        
                                        Text("Save")
                                            .foregroundColor(Color(timerVM.firstColorText))
                                            .modifier(ShadowLightModifier())
                                        
                                    }
                                    
                                }
                                
                            }
                            .padding(.top, 30)
                            .padding(.trailing, 30)
                            
                            //                        ZStack {
                            //                            AntiRilievoView(width: screen.width - 50, height: textPressed ? 420 : 120, cornerRadious: 30)
                            //
                            //
                            //
                            //                            Text("Our focus is limited and precious\(textPressed ? ". There are many research out there that proved a person need about 10 to 25 minutes to achieve high focus, and you also cannot effectively do something really intensive for much longer that 25-30 minutes. Foocus app help to reduce that loosing focus effect. And you only need 5 minutes of break to recover your high focus." : ". (tap here) ")")
                            //
                            //                                .font(.system(size: 23, weight: .regular))
                            //                                .fixedSize(horizontal: false, vertical: true)
                            //                                .padding(27)
                            //                                .padding(.horizontal, 10)
                            //                                .foregroundColor(textPressed ? Color(timerVM.firstColorText) :  Color(#colorLiteral(red:0.89, green:0.90, blue:0.93, alpha:1.00)))
                            //                                .modifier(ShadowLightModifier())
                            //                                .onTapGesture {
                            //                                    self.textPressed.toggle()
                            //                                    self.timerVM.classicVibration()
                            //                            }
                            //
                            //                        }
                            Spacer()
                                .frame(height: spaceInTheSpacer)
                            
                            ZStack {
                                
                                Button {
                                    self.showPayWall = true
                                } label: {
                                    ButtonView(width: 190, height: 60, cornerRadius: 30, showImage: false)
                                }
                                .sheet(isPresented: $showPayWall) {
                                    PayWallView().environmentObject(TimerViewModel())
                                        }
                                
                                
                                Text("Go Premium 💎")
                                    .modifier(ShadowLightModifier())
                                    .font(.system(size: timerVM.secondSizeFont))
                                    .foregroundColor(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                                
                                
                                
                            }
                            .padding(.horizontal, 33)
                            .padding(.bottom, 10)
                            
                            HStack {
                                
                                Text("No-stop timers:")
                                    .font(.system(size: 23, weight: .regular))
                                    .foregroundColor(Color(timerVM.firstColorText))
                                    .modifier(ShadowLightModifier())  
                                
                                Spacer()
                                
                                ToggleButton(toggle: enableNoStop)
                                
                                
                            }
                            .padding(.horizontal, 33)
                            .padding(.bottom, 10)
                            
                            
                            
                            
                            
                            
                            //                        HStack {
                            //
                            //                                Text("Custom colors circle bar:")
                            //                                    .font(.system(size: 23, weight: .regular))
                            //                                    .foregroundColor(Color(#colorLiteral(red:0.89, green:0.90, blue:0.93, alpha:1.00)))
                            //                                    .modifier(ShadowLightModifier())
                            //                                    .padding(.leading, 33)
                            //
                            //                            Spacer()
                            //
                            //                        }
                            
                            
                            //                        HStack {
                            //
                            //
                            //                            ColorButtonView(isPressed: activateYellow, color: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))
                            //
                            //
                            //                            Spacer()
                            //
                            //                            ColorButtonView(isPressed: activateRed, color: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0.7845141267))
                            //
                            //
                            //
                            //                            Spacer()
                            //
                            //
                            //                            ColorButtonView(isPressed: activateGreen, color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
                            //
                            //
                            //
                            //
                            //                            Spacer()
                            //
                            //
                            //                            ColorButtonView(isPressed: activateBlue, color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
                            //
                            //
                            //                        }
                            //                        .padding(.horizontal, 20)
                            
                            
                            VStack {
                                Spacer()
                                    .frame(height: spaceInTheSpacer)
                                
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("Focus time:")
                                        
                                        Text("\(self.timerVM.arrayOfInput[0]) min")
                                    }
                                    .foregroundColor(Color(timerVM.firstColorText))
                                    .font(.system(size: 23))
                                    .modifier(ShadowLightModifier())
                                    .padding(.horizontal)
                                    .padding(.leading)
                                    .animation(.none)
                                    
                                    BarPreferenceView(lowerBound: 10,
                                                      upperBound: 99,
                                                      output: focusTime,
                                                      movingWheelState: inputBarValue(input: self.timerVM.arrayOfInput[0], lowerBound: 10, upperBound:99),
                                                      accumulatedMoving: inputBarValue(input: self.timerVM.arrayOfInput[0], lowerBound: 10, upperBound:99))
                                    
                                }
                                .frame(height:100)
                                
                                
                                
                                Spacer()
                                    .frame(height: spaceInTheSpacer)
                                
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("Break time:")
                                        
                                        Text("\(self.timerVM.arrayOfInput[1]) min")
                                    }
                                    .foregroundColor(Color(timerVM.firstColorText))
                                    .font(.system(size: 23))
                                    .modifier(ShadowLightModifier())
                                    .padding(.horizontal)
                                    .padding(.leading)
                                    
                                    BarPreferenceView(lowerBound: 1, upperBound: 15, output: breakTime, movingWheelState: inputBarValue(input: self.timerVM.arrayOfInput[1], lowerBound: 1, upperBound:15),
                                                      accumulatedMoving: inputBarValue(input: self.timerVM.arrayOfInput[1], lowerBound: 1, upperBound:15))
                                    
                                }
                                .frame(height:100)
                                
                                
                                Spacer()
                                    .frame(height: spaceInTheSpacer)
                                
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("Long break time:")
                                        
                                        Text("\(self.timerVM.arrayOfInput[3]) min")
                                    }
                                    .foregroundColor(Color(timerVM.firstColorText))
                                    .font(.system(size: 23))
                                    .modifier(ShadowLightModifier())
                                    .padding(.horizontal)
                                    .padding(.leading)
                                    
                                    
                                    BarPreferenceView(lowerBound: 15, upperBound: 60, output: longBreak, movingWheelState: inputBarValue(input: self.timerVM.arrayOfInput[3], lowerBound: 15, upperBound:60),
                                                      accumulatedMoving: inputBarValue(input: self.timerVM.arrayOfInput[3], lowerBound: 15, upperBound:60))
                                    
                                }
                                .frame(height:100)
                                
                                
                                Spacer()
                                    .frame(height: spaceInTheSpacer)
                                
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("How many times?")
                                        
                                        Text("\(self.timerVM.arrayOfInput[2]) times")
                                    }
                                    .foregroundColor(Color(timerVM.firstColorText))
                                    .font(.system(size: 23))
                                    .modifier(ShadowLightModifier())
                                    .padding(.horizontal)
                                    .padding(.leading)
                                    
                                    BarPreferenceView(lowerBound: 1, upperBound: 10, output: cycles, movingWheelState: inputBarValue(input: self.timerVM.arrayOfInput[2], lowerBound: 1, upperBound:10),
                                                      accumulatedMoving: inputBarValue(input: self.timerVM.arrayOfInput[2], lowerBound: 1, upperBound:10))
                                    
                                }
                                .frame(height:100)
                                
                                
                                Spacer()
                                    .frame(height: spaceInTheSpacer)
                            }
                            
                            ZStack {
                                ButtonView(width: 170, height: 70, cornerRadius: 25, showImage: false)
                                    .onTapGesture {
                                        
                                        self.timerVM.settingsOnDefault()
                                        self.timerVM.isPressedTomatoTimer = 0
                                        self.timerVM.enableNoStop = false
                                    }
                                
                                Text("Default Set-Up")
                                    .foregroundColor(Color(timerVM.firstColorText))
                                    .font(.system(size: timerVM.secondSizeFont))
                                    .modifier(ShadowLightModifier())
                                
                            }
                            
                        }
                        //                    .animation(.none)
                        //this work for disactivate the all animation linear for the bar preference view
                        
                    }
                    .animation(.linear)
                    
                
            }
            .background(Color(#colorLiteral(red:0.89, green:0.90, blue:0.93, alpha:1.00)))
            .edgesIgnoringSafeArea(.all)
        
        
    }
    
    
    func inputBarValue(input:Int, lowerBound:Int, upperBound:Int ) -> CGSize {
        
        //10...60 range50 (upper - lower) -> input 11 - lowerbound = 1 /50 = 2%
        let a = input - lowerBound
        //(( 1:50 = x : 100 100/50 = 2
        let percentageOfRangeX = a * 100 / 50
        
        //find 2% of a 300 range =
        // 2 : 100 = X : 300
        let percentageOfRange300 = percentageOfRangeX*300/100
        // 2*300/100 = 6
        
        // 6-150 = -144
        let outputOfRange300 = percentageOfRange300 - 150
        // -150...150 range300 (upper - lower)
        
        
        return (CGSize(width: outputOfRange300, height: 0))
    }
    
    
}

struct SettingsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsScreenView().environmentObject(TimerViewModel())
                .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
                .previewDisplayName("iPhone SE")
            
            //            SettingsScreenView(showView: .constant(true), ballActive: .constant(true)).environmentObject(TimerViewModel())
            //                .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch)"))
            //            .previewDisplayName("iPad pro")
            
            SettingsScreenView().environmentObject(TimerViewModel())
                .previewDevice(PreviewDevice(rawValue: "iPhone XR"))
                .previewDisplayName("iPhone XR")
            
            
        }
        
    }
}



struct ShadowLightModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.black.opacity(0.25), radius: 1, x: 1, y: 1)
            .shadow(color: Color.white.opacity(1), radius: 1, x: -1, y: -1)
            .shadow(color: Color.black.opacity(0.25), radius: 1, x: 1, y: 1)
            .shadow(color: Color.white.opacity(1), radius: 1, x: -1, y: -1)
    }
}

