//
//  ColumView.swift
//  Foocus
//
//  Created by Riccardo Carlotto on 10/09/2020.
//  Copyright © 2020 Riccardo Carlotto. All rights reserved.
//

import SwiftUI


struct BarView: View {
    @Binding var value: Float
    @Binding var tag: String
    @EnvironmentObject var timerVM : TimerViewModel
    var width:CGFloat = 200
    var height:CGFloat = 20
    
    var body: some View {
        HStack{
            
            Text(tag)
                .foregroundColor(Color(timerVM.firstColorText))
                .modifier(ShadowLightModifier())
                .lineLimit(1)
            
            
            ZStack (alignment:.leading) {
                AntiRilievoView(width: width, height: height, cornerRadius: 45)
                
                HStack{
                    
                    Spacer().frame(width:5)
                    
                    LinearGradient(gradient: Gradient(colors: [Color(self.timerVM.colorBar2), Color(self.timerVM.colorBar1)]), startPoint: .leading, endPoint: .trailing)
                        .modifier(ShadowLightModifier())
                        .cornerRadius(30)
                        .frame(width: (CGFloat(self.value)*width)/1.05, height: height/2.6)
                        
                }
            }
        }
        
        
        
        
        
    }
    //        .frame(width:280, height:50)
    
    
    
}

struct BarView_Previews: PreviewProvider {
    static var previews: some View {
        BarView(value: .constant(1), tag: .constant("big titles asdf")).environmentObject(TimerViewModel())
            .padding() // title can be 15 chars max
    }
}
