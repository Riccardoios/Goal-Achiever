//
//  ToggleButton.swift
//  Foocus
//
//  Created by Riccardo Carlotto on 01/06/2020.
//  Copyright © 2020 Riccardo Carlotto. All rights reserved.
//

import SwiftUI

struct ToggleButton: View {
    
    @EnvironmentObject var timerVM : TimerViewModel
    @Binding var toggle : Bool
    
    var body: some View {
        ZStack {
            
            AntiRilievoView(width: 80, height: 42, cornerRadious: 30)
            
            Text("ON   OFF")
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(Color(timerVM.firstColorText))
                .modifier(ShadowLightModifier())
            
            
            Circle()
                .frame(width:28, height:28)
                .foregroundColor(Color(#colorLiteral(red:0.89, green:0.90, blue:0.93, alpha:1.00)))
                .modifier(ShadowLightModifier())
                .offset(x:toggle ? 17 : -17, y:1)
                
            
        }
        .onTapGesture {
                self.toggle.toggle()
                self.timerVM.classicVibration()
        }
        
    }
}


struct ToggleButton_Previews: PreviewProvider {
    static var previews: some View {
        ToggleButton(toggle: .constant(false)).environmentObject(TimerViewModel())
    }
}
