//
//  AddSessionView.swift
//  Goals
//
//  Created by Riccardo Carlotto on 30/12/2020.
//

import SwiftUI

struct AddSessionView: View {
    
    @Binding var showPlanView: Bool
    @Binding var showDoView: Bool
    @Binding var showChartsView: Bool
    
    @EnvironmentObject var timerVM : TimerViewModel
    @State var sessionTimeMinutes:Int = 1
    @State var isPressed = false
    @Binding var rectangularize:Bool
    @Binding var isAddSessionPressed: Bool
    var saveFunction: (Int32) -> Void
    
    
    var body: some View {
        
        ZStack{
            
//            Rectangle()
//                .cornerRadius(30)
//                .foregroundColor(Color(timerVM.backgroundColor))
//                .modifier(ShadowLightModifier())
            
            VStack(alignment:.center) {
                ZStack{
                    VStack {
                        
                        Text("Add a Session of :")
                            .foregroundColor(Color(timerVM.firstColorText))
                            .padding(.top)
                        
                        Text("\(timerVM.renameTheSec(seconds: Int32(sessionTimeMinutes*60)))")
                            .foregroundColor(Color(timerVM.secondColorText))
                    }
                    .font(.system(size: 23))
                    .modifier(ShadowLightModifier())
                    
                    HStack{
                        
                        Spacer()
                        
                        ButtonView(width: 40, height: 40, image: Image(systemName: "xmark"), imageSize: 0.8, cornerRadius: 90, showImage: true, colorImage: timerVM.firstColorText)
                            .padding()
                            .onTapGesture {
                                rectangularize.toggle()
                                isAddSessionPressed = false
                            }
                            .offset(x: 10.0, y: -10.0)
                    }
                    
                }
                
                BarPreferenceView(lowerBound: 1, upperBound: 600, output: $sessionTimeMinutes, movingWheelState: CGSize(width: -150, height: 0), accumulatedMoving:CGSize(width: -150, height: 0))
                    .scaledToFill()
                    
                
                ZStack{
                    ButtonView(width: 150, height: 50, cornerRadius: 30, showImage: false)
                        .padding()
                    
                    Text("Save")
                        .foregroundColor(Color(timerVM.firstColorText))
                        .font(.system(size: 23))
                        .modifier(ShadowLightModifier())
                        .onTapGesture {
                            timerVM.secondForSession = Int32(sessionTimeMinutes*60)
                            self.saveFunction(timerVM.secondForSession)
                            rectangularize.toggle()
                            isAddSessionPressed = false
                            showPlanView = false
                            showDoView = false
                            showChartsView = true
                        }
                }
                
                
            }
        }
        .frame(width: 340, height: 270)
    }
}

// struct AddSessionView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddSessionView(rectangularize: .constant(false), isAddSessionPressed: .constant(true), saveFunction: () -> Void)
//            .environmentObject(TimerViewModel())
//    }
//}
