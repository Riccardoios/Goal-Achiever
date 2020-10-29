//
//  weekButtons.swift
//  Foocus
//
//  Created by Riccardo Carlotto on 09/08/2020.
//  Copyright © 2020 Riccardo Carlotto. All rights reserved.
//

import SwiftUI

struct weekButtons: View {
    
    
    @EnvironmentObject var timerVM : TimerViewModel
    @Binding var weekArray : [Bool]
    let antiRiSize: CGFloat = 50
    let antiRiCorner: CGFloat = 11
    let rectSize:CGFloat = 35
    let rectCorner: CGFloat = 6
    var spaceInTheSpacer: CGFloat = 1
    
    
    var body: some View {
        ZStack {
            
//            Color(#colorLiteral(red:0.89, green:0.90, blue:0.93, alpha:1.00))
            
            HStack {
                Group {
                    Spacer()
                        .frame(width: spaceInTheSpacer)
                    ColorButtonView(isPressed: $weekArray[0], color: timerVM.firstColorText, orText: true, textValue: "SU", antiRiSize: antiRiSize, antiRiCorner: antiRiCorner, rectSize: rectSize, rectCorner: rectCorner )
                    Spacer()
                    .frame(width: spaceInTheSpacer)
                    ColorButtonView(isPressed: $weekArray[1], color: timerVM.firstColorText, orText: true, textValue: "MO", antiRiSize: antiRiSize, antiRiCorner: antiRiCorner, rectSize: rectSize, rectCorner: rectCorner )
                    Spacer()
                    .frame(width: spaceInTheSpacer)
                    ColorButtonView(isPressed: $weekArray[2], color: timerVM.firstColorText, orText: true, textValue: "TU", antiRiSize: antiRiSize, antiRiCorner: antiRiCorner, rectSize: rectSize, rectCorner: rectCorner )
                    Spacer()
                    .frame(width: spaceInTheSpacer)
                }
                Group {
                    ColorButtonView(isPressed: $weekArray[3], color: timerVM.firstColorText, orText: true, textValue: "WE", antiRiSize: antiRiSize, antiRiCorner: antiRiCorner, rectSize: rectSize, rectCorner: rectCorner )
                    Spacer()
                    .frame(width: spaceInTheSpacer)
                    ColorButtonView(isPressed: $weekArray[4], color: timerVM.firstColorText, orText: true, textValue: "TH", antiRiSize: antiRiSize, antiRiCorner: antiRiCorner, rectSize: rectSize, rectCorner: rectCorner )
                    Spacer()
                    .frame(width: spaceInTheSpacer)
                    ColorButtonView(isPressed: $weekArray[5], color: timerVM.firstColorText, orText: true, textValue: "FR", antiRiSize: antiRiSize, antiRiCorner: antiRiCorner, rectSize: rectSize, rectCorner: rectCorner )
                    Spacer()
                    .frame(width: spaceInTheSpacer)
                    ColorButtonView(isPressed: $weekArray[6], color: timerVM.firstColorText, orText: true, textValue: "SA", antiRiSize: antiRiSize, antiRiCorner: antiRiCorner, rectSize: rectSize, rectCorner: rectCorner )
                    Spacer()
                    .frame(width: spaceInTheSpacer)
                }
                
            }
            .padding(.vertical, 15)
        }
    }
}

struct weekButtons_Previews: PreviewProvider {
    static var previews: some View {
        
        //        let week = ["monday" : false, "tuesday" : false, "wednsday" : false, "thursday" : false, "friday" : false, "saturnday" : false, "sunday" : false ]
        let week = [true, false, true, false, true, false, false]
        
        return
            
            weekButtons(weekArray: .constant(week)).environmentObject(TimerViewModel())
    }
}
