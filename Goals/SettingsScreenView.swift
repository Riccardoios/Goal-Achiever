//
//  SettingsScreenView.swift
//  Foocus
//
//  Created by Riccardo Carlotto on 26/04/2020.
//  Copyright © 2020 Riccardo Carlotto. All rights reserved.

import SwiftUI


struct SettingsScreenView: View {
    
    @Binding var showPlanView: Bool
    @Binding var showDoView: Bool
    @Binding var showChartsView: Bool
    @Binding var showSettingView: Bool
    @Binding var showPayWallView: Bool
    //@State var textPressed = false
    @EnvironmentObject var timerVM : TimerViewModel
    @EnvironmentObject var store: IAPStore
    //    var spaceInTheSpacer: CGFloat = 25
    @State var animateSave = false
    @State var showPayWall = false
    
    //    @State var myArr = [true, true, false, false] // for the logic of the color Buttons
    //    @State var MyPreviousArr = [true, true, false, false] // same
    //    @State var arrayOfIndexesOfChangedValues = [0,1] // same
    
    
    fileprivate func extractedFunc() -> ZStack<TupleView<(Button<ButtonView>, Text)>> {
        return ZStack {
            
            Button {
                
                self.showSettingView = false
                self.showPayWallView = true
                
            } label: {
                ButtonView(width: 190, height: 60, cornerRadius: 30, showImage: false)
            }
            //                                .sheet(isPresented: $showPayWall) {
            //                                    PayWallView().environmentObject(TimerViewModel())
            //                                }
            
            
            Text("Remove Ads 🎉")
                //                                    .modifier(ShadowLightModifier())
                .font(.system(size: timerVM.secondSizeFont))
                .foregroundColor(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
            
            
            
        }
    }
    
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
        
        
        return
        
            ScrollView(.vertical, showsIndicators:false) {
                
                    
                    LazyVStack(spacing: 45) {
                        
                        HStack {
                            Text("🍅 Timer Setup")
                                .lineLimit(1)
                                .foregroundColor(Color(timerVM.firstColorText))
                                .font(.system(size: 35))
                                .modifier(ShadowLightModifier())
                                .padding()
                            
                            Spacer()
                            
                            Button(action: {
                                
                                self.timerVM.indexOfTimersArray = 0;
                                
                                // self.timerVM.changeColorCircleBar(Sequence: self.arrayOfIndexesOfChangedValues);
                                
                                self.timerVM.reset()
                                self.animateSave.toggle()
                                self.timerVM.classicVibration()
                                
//                                print (self.timerVM.arrayOfInput)
                                
                                showPlanView = false
                                showDoView = true
                                showChartsView = false
                                showSettingView = false
                                
                            }) {
                                ZStack{
                                    
                                    ButtonView(width: 50, height: 50, cornerRadius: 90, showImage: false)
                                    
                                    Text("Save")
                                        .foregroundColor(Color(timerVM.firstColorTextDarker))
//                                        .modifier(ShadowLightModifier())
                                    
                                }
                                
                            }
                            
                        }
                        .padding(.top, 30)
                        
                       
                        ZStack {
                            
                            Button {
                                
                                self.showSettingView = false
                                self.showPayWallView = true
                                
                            } label: {
                                ButtonView(width: 190, height: 60, cornerRadius: 30, showImage: false)
                            }
                            //                                .sheet(isPresented: $showPayWall) {
                            //                                    PayWallView().environmentObject(TimerViewModel())
                            //                                }
                            
                            
                            Text("Remove Ads 🎉")
                                //                                    .modifier(ShadowLightModifier())
                                .font(.system(size: timerVM.secondSizeFont))
                                .foregroundColor(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                            
                            
                            
                        }
                        
//                            .padding(.leading, 40)
                           
                        
                        
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
                        
                        
//                        LazyVStack(alignment: .leading, spacing:30) {
                            //                                Spacer()
                            //                                    .frame(height: spaceInTheSpacer)
                        
                        
                            Text("No-stop timers:")
                                .font(.system(size: 25, weight: .regular))
                                .foregroundColor(Color(timerVM.firstColorText))
                                .modifier(ShadowLightModifier())
                            
                            ToggleButton(toggle: enableNoStop)
                            
                            Group {
                                HStack {
                                    Text("Focus time:")
                                    
                                    Text("\(self.timerVM.arrayOfInput[0]) min")
                                }
                                .foregroundColor(Color(timerVM.firstColorText))
                                .font(.system(size: 25))
                                .modifier(ShadowLightModifier())
//                                .padding(.horizontal)
//                                .padding(.leading)
//                                .animation(.none)
                            
                                
                                BarPreferenceView(lowerBound: 10,
                                                  upperBound: 99,
                                                  output: focusTime,
                                                  movingWheelState: inputBarValue(input: self.timerVM.arrayOfInput[0], lowerBound: 10, upperBound:99),
                                                  accumulatedMoving: inputBarValue(input: self.timerVM.arrayOfInput[0], lowerBound: 10, upperBound:99))
                                
                                
                            }
                            //                                .frame(height:100)
                            
                            
                            
                            //                                Spacer()
                            //                                    .frame(height: spaceInTheSpacer)
                            
                            Group {
                                HStack {
                                    Text("Break time:")
                                    
                                    Text("\(self.timerVM.arrayOfInput[1]) min")
                                }
                                .foregroundColor(Color(timerVM.firstColorText))
                                .font(.system(size: 25))
                                .modifier(ShadowLightModifier())
//                                .padding(.horizontal)
//                                .padding(.leading)
//
                                BarPreferenceView(lowerBound: 1, upperBound: 15, output: breakTime, movingWheelState: inputBarValue(input: self.timerVM.arrayOfInput[1], lowerBound: 1, upperBound:15),
                                                  accumulatedMoving: inputBarValue(input: self.timerVM.arrayOfInput[1], lowerBound: 1, upperBound:15))
                                
                                
                            }
                            //                                .frame(height:100)
                            
                            
                            //                                Spacer()
                            //                                    .frame(height: spaceInTheSpacer)
                            
                            Group {
                                HStack {
                                    Text("Long break time:")
                                    
                                    Text("\(self.timerVM.arrayOfInput[3]) min")
                                }
                                .foregroundColor(Color(timerVM.firstColorText))
                                .font(.system(size: 25))
                                .modifier(ShadowLightModifier())
//                                .padding(.horizontal)
//                                .padding(.leading)
                                
                                
                                BarPreferenceView(lowerBound: 15, upperBound: 60, output: longBreak, movingWheelState: inputBarValue(input: self.timerVM.arrayOfInput[3], lowerBound: 15, upperBound:60),
                                                  accumulatedMoving: inputBarValue(input: self.timerVM.arrayOfInput[3], lowerBound: 15, upperBound:60))
                                
                                
                            }
                            //                                .frame(height:100)
                            
                            
                            //                                Spacer()
                            //                                    .frame(height: spaceInTheSpacer)
                            
                            Group {
                                HStack {
                                    Text("How many times?")
                                    
                                    Text("\(self.timerVM.arrayOfInput[2]) times")
                                }
                                .foregroundColor(Color(timerVM.firstColorText))
                                .font(.system(size: 25))
                                .modifier(ShadowLightModifier())
//                                .padding(.horizontal)
//                                .padding(.leading)
                                
                                BarPreferenceView(lowerBound: 1, upperBound: 10, output: cycles, movingWheelState: inputBarValue(input: self.timerVM.arrayOfInput[2], lowerBound: 1, upperBound:10),
                                                  accumulatedMoving: inputBarValue(input: self.timerVM.arrayOfInput[2], lowerBound: 1, upperBound:10))
//                                Spacer()
//                                    .frame(height:100)
                                
                            }
                        Group {
                            HStack{
                                Spacer()
                                ZStack{
                                    ButtonView(width: 170, height: 70, cornerRadius: 25, showImage: false)
                                        .onTapGesture {
                                            self.timerVM.settingsOnDefault()
                                            self.timerVM.isPressedTomatoTimer = 0
                                            self.timerVM.enableNoStop = false
                                        }
                                    
                                    Text("Default Set-Up")
                                        .foregroundColor(Color(timerVM.firstColorTextDarker))
                                        .font(.system(size: timerVM.secondSizeFont))
                                    //                                    .modifier(ShadowLightModifier())
                                }
                                Spacer()
                            }
                        }
                        
//                        PayWallView(showPayWall: .constant(true), showSettingView: .constant(true))
                        
                        Group {
                            
                            Text("Subscriptions")
                                .font(.system(size: 35, weight: .regular))
                                .foregroundColor(Color(timerVM.firstColorText))
                                .modifier(ShadowLightModifier())
                            
                            VStack(alignment: .leading, spacing: 20) {
                                
                                Text("👨🏻‍💻 Support the developer")
                                    .modifier(ShadowLightModifier())
                                
                                Text("🎉 No more Adverts!")
                                    .modifier(ShadowLightModifier())
                                
                                
       
                            }
                            .font(.system(size: 30))


                            ForEach(store.product, id:\.self) { product in

                                ProductRow(product: product)
                                    .padding(.horizontal, 40)
                                    .foregroundColor(Color(timerVM.firstColorText))

                            }

                            Spacer()

                            HStack(alignment: .center) {
                                Button {
                                    store.restorePurchases()

                                } label: {
                                    Text("Restore Purchase")
                                        .underline()
                                        .font(.system(size: 15))
                                        .modifier(ShadowLightModifier())
                                        .foregroundColor(Color(timerVM.firstColorText))
                                }
                            }


                            HStack {

                                Link("Privacy Policy", destination: URL(string: "https://riccardoios.github.io/goal-achiever")!)
                                    .font(.system(size: 15))
                                    .modifier(ShadowLightModifier())
                                    .foregroundColor(Color(timerVM.firstColorText))

                                Divider()

                                Link("Terms of Use", destination: URL(string: "https://riccardoios.github.io/goal-achiever-Terms-of-Use")!)
                                    .font(.system(size: 15))
                                    .modifier(ShadowLightModifier())
                                    .foregroundColor(Color(timerVM.firstColorText))
                            }
                            .padding()

                        }
                    
                    

                    
                    
                    
                }
                .onAppear{
                    store.requestProducts()
                }
                        
                    }
                    .padding(.horizontal)
                    
            
            
        
        
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
            //            SettingsScreenView().environmentObject(TimerViewModel())
            //                .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
            //                .previewDisplayName("iPhone SE")
            
            //            SettingsScreenView(showView: .constant(true), ballActive: .constant(true)).environmentObject(TimerViewModel())
            //                .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch)"))
            //            .previewDisplayName("iPad pro")
            
            SettingsScreenView(showPlanView: .constant(false),
                               showDoView: .constant(false),
                               showChartsView: .constant(false),
                               showSettingView: .constant(true),
                               showPayWallView: .constant(false))
                .environmentObject(TimerViewModel())
                .previewDevice(PreviewDevice(rawValue: "iPhone XR"))
                .previewDisplayName("iPhone XR")
            
            
        }
        
    }
}



struct ShadowLightModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.black.opacity(0.35), radius: 2, x: 1, y: 1)
            .shadow(color: Color.white.opacity(1), radius: 1, x: -2, y: -2)
        //            .shadow(color: Color.black.opacity(0.25), radius: 1, x: 1, y: 1)
        //            .shadow(color: Color.white.opacity(1), radius: 1, x: -1, y: -1)
    }
}

