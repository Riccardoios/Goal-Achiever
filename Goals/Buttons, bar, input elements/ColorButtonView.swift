//
//  ColorButtonView.swift
//  Foocus
//
//  Created by Riccardo Carlotto on 27/04/2020.
//  Copyright © 2020 Riccardo Carlotto. All rights reserved.
//

import SwiftUI

struct ColorButtonView: View {
    
    @EnvironmentObject var timerVM: TimerViewModel
    @Binding var isPressed : Bool
    @State var color:UIColor //= #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    var orText : Bool = false
    var textValue = "MON"
    var textSize : CGFloat = 15
    var antiRiSize : CGFloat = 65
    var antiRiCorner : CGFloat = 14
    var rectSize : CGFloat = 50
    var rectCorner : CGFloat = 10

    
    var body: some View {
        
         ZStack {
            
//            Color(#colorLiteral(red:0.89, green:0.90, blue:0.93, alpha:1.00))
            
            AntiRilievoView(width: antiRiSize, height: antiRiSize, cornerRadius: antiRiCorner)
                .opacity(isPressed ? 1 : 0)
            
            Group {
                RoundedRectangle(cornerRadius: rectCorner)
                    .frame(width:rectSize, height:rectSize)
                    .foregroundColor(Color(#colorLiteral(red:0.89, green:0.90, blue:0.93, alpha:1.00)))
                    .brightness(-0.3)
                    .opacity(0.6)
                    .blur(radius: 2)
                    .offset(x: 3, y: 3)
                
                RoundedRectangle(cornerRadius: rectCorner)
                    .frame(width:rectSize, height:rectSize)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .opacity(1.5)
                    .blur(radius: 2)
                    .offset(x: -3, y: -3)
                
                RoundedRectangle(cornerRadius: rectCorner)
                    .frame(width:rectSize, height:rectSize)
                    .foregroundColor(Color(#colorLiteral(red:0.89, green:0.90, blue:0.93, alpha:1.00)))
            }
            .opacity(isPressed ? 0 : 1)
            
            
            if !orText {
                Color(color)
                .clipShape(RoundedRectangle(cornerRadius: 9))
                .frame(width:47, height:47)
                .onTapGesture {
                    self.isPressed.toggle()
                    self.timerVM.classicVibration()
            }
            } else {
                Text(textValue)
                    .font(.system(size: textSize))
                .foregroundColor(Color(color))
                .modifier(ShadowLightModifier())
                .onTapGesture {
                        self.isPressed.toggle()
                        self.timerVM.classicVibration()
                }
                
            }
            
            
        }
        .animation(.linear)
        
         
    }
    
  
    
}

//struct ColorButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        ColorButtonView(isPressed: .constant(false))
//    }
//}
