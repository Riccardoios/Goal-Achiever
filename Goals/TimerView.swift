//
//  TimerView.swift
//  Foocus
//
//  Created by Riccardo Carlotto on 20/04/2020.
//  Copyright © 2020 Riccardo Carlotto. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    
    @EnvironmentObject var timerVM : TimerViewModel
    
    var body: some View {
        Text("\(timerVM.timeString(time: TimeInterval(timerVM.timersArray[timerVM.indexOfTimersArray])))")
            .font(.system(size: 45 * myCoef, weight: .semibold))
            .foregroundColor(Color(timerVM.firstColorText))
            .modifier(ShadowLightModifier())
//            .shadow(color: Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)), radius: 1, x: 2, y: 2)
//            .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 1, x: -2, y: -2)
            
            .onTapGesture {
                self.timerVM.playPause()
        }
        .animation(.none)
        .frame(width:300)
    }
}
