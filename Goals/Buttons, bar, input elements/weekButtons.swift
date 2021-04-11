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
    let antiRiSize: CGFloat = 45
    let antiRiCorner: CGFloat = 11
    let rectSize:CGFloat = 35
    let rectCorner: CGFloat = 6
    
    
    var body: some View {
            
        LazyHStack(spacing:0) {
                        
                    ColorButtonView(isPressed: $weekArray[0], orText: true, textValue: "SU", antiRiSize: antiRiSize, antiRiCorner: antiRiCorner, rectSize: rectSize, rectCorner: rectCorner)
                    
                    
                    ColorButtonView(isPressed: $weekArray[1], orText: true, textValue: "MO", antiRiSize: antiRiSize, antiRiCorner: antiRiCorner, rectSize: rectSize, rectCorner: rectCorner )
                    
                    ColorButtonView(isPressed: $weekArray[2], orText: true, textValue: "TU", antiRiSize: antiRiSize, antiRiCorner: antiRiCorner, rectSize: rectSize, rectCorner: rectCorner )
                    
                
                    ColorButtonView(isPressed: $weekArray[3], orText: true, textValue: "WE", antiRiSize: antiRiSize, antiRiCorner: antiRiCorner, rectSize: rectSize, rectCorner: rectCorner )
                   
                    ColorButtonView(isPressed: $weekArray[4], orText: true, textValue: "TH", antiRiSize: antiRiSize, antiRiCorner: antiRiCorner, rectSize: rectSize, rectCorner: rectCorner )
                    
                    ColorButtonView(isPressed: $weekArray[5], orText: true, textValue: "FR", antiRiSize: antiRiSize, antiRiCorner: antiRiCorner, rectSize: rectSize, rectCorner: rectCorner )
                    
                    ColorButtonView(isPressed: $weekArray[6], orText: true, textValue: "SA", antiRiSize: antiRiSize, antiRiCorner: antiRiCorner, rectSize: rectSize, rectCorner: rectCorner )
                  
                
            }
            .padding(.vertical, 15)
            
        
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
