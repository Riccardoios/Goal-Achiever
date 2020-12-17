//
//  ColumView.swift
//  Foocus
//
//  Created by Riccardo Carlotto on 10/09/2020.
//  Copyright © 2020 Riccardo Carlotto. All rights reserved.
//

import SwiftUI


struct ColumView: View {
    @Binding var value: Float
    @Binding var tag: String
    @EnvironmentObject var timerVM : TimerViewModel
    
    var body: some View {
        VStack{
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    
                    AntiRilievoView(width: geometry.size.width, height: geometry.size.height, cornerRadius: 45)
                    
                    VStack {
                        Spacer()
                        
                        LinearGradient(gradient: Gradient(colors: [Color(self.timerVM.colorBar2), Color(self.timerVM.colorBar1)]), startPoint: .bottom, endPoint: .top)
                            .modifier(ShadowLightModifier())
                            .cornerRadius(30)
                            .frame(width: geometry.size.width / 1.8, height:min(CGFloat(self.value)*geometry.size.height, geometry.size.height) - (CGFloat(self.value)*15))
                            .animation(.linear)
                        
                        Spacer().frame(height:7.5)
                        
                    }
                }
            }
            
            Text(tag)
                .foregroundColor(Color(timerVM.firstColorText))
                .modifier(ShadowLightModifier())
            
            
        }
        .frame(width:30, height:200)
        
        
    }
    
}

struct ColonViewx_Previews: PreviewProvider {
    static var previews: some View {
        ColumView(value: .constant(0.2), tag: .constant("MO")).environmentObject(TimerViewModel())
            .padding()
    }
}
