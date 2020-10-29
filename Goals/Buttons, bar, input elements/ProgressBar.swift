//
//  ProgressBar.swift
//  Foocus
//
//  Created by Riccardo Carlotto on 09/09/2020.
//  Copyright © 2020 Riccardo Carlotto. All rights reserved.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var value: Double
    @Binding var label: String
    @EnvironmentObject var timerVM : TimerViewModel
    
    var body: some View {
        VStack{
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    
                    AntiRilievoView(width: geometry.size.width, height: geometry.size.height, cornerRadious: 45)
                    
                    
                    HStack{
                        
                        Spacer().frame(width:6)
                        
                        Rectangle()
                            .modifier(ShadowLightModifier())
                            .cornerRadius(30)
                            .frame(width: min(CGFloat(self.value)*geometry.size.width/1.025, geometry.size.width/1.025), height: geometry.size.height / 2)
                            .foregroundColor(Color(self.timerVM.firstColorText))
                            .animation(.linear)
                        
                        Spacer().frame(width:6)
                    }
                }
            }
            
            Text(label)
                .font(.system(size: timerVM.secondSizeFont))
                .foregroundColor(Color(timerVM.secondColorText))
                .modifier(ShadowLightModifier())
            
            //asdf
        }
    }
    
    struct ProgressBar_Previews: PreviewProvider {
        static var previews: some View {
            ProgressBar(value: .constant(1), label: .constant("15 hours "))
                .frame(height:60)
                .environmentObject(TimerViewModel())
        }
    }
}
