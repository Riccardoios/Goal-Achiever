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
    @Binding var isTomatoTimer: Bool
    
    var body: some View {
        Text(isTomatoTimer ? "\(timerVM.timeString(time: TimeInterval(timerVM.timersArray[timerVM.indexOfTimersArray])))" : "\(timerVM.timeString(time: TimeInterval(timerVM.normalTimer)))")
            .font(.system(size: 45 * myCoef, weight: .semibold))
            .foregroundColor(Color(timerVM.firstColorText))
            .modifier(ShadowLightModifier())
            .onTapGesture {
                self.timerVM.playPauseTomatoTimer()
        }
        .animation(.none)
        .frame(width:300)
    }
}
