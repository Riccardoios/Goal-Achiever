//
//  RingView.swift
//  designCourse
//
//  Created by Riccardo Carlotto on 04/04/2020.
//  Copyright © 2020 Riccardo Carlotto. All rights reserved.
//

import SwiftUI

struct RingView: View {
    
    @EnvironmentObject var timerVM : TimerViewModel
    
    var color1 = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    var color2 = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
    var width: CGFloat  = 300
    var height: CGFloat = 300
    var lineWidth: CGFloat = 3
    
    @Binding var show : Bool
    //binding for being controleld outside and it need the type not the value
    var body: some View {
         
        let multiplier = width / 44
        
        let progress : CGFloat = 1 - (timerVM.percentage/100)
        
        return ZStack {

            Circle()
                .trim(from: show ? progress : 1, to: 1)
                .stroke(LinearGradient(gradient: Gradient(colors: [Color(color1), Color(color2)]), startPoint: .topTrailing, endPoint: .bottomLeading),
                        style: StrokeStyle(
                            lineWidth: lineWidth * multiplier,
                            lineCap: .round,
                            lineJoin: .round,
                            miterLimit: .infinity,
                            dash: [20, 0],
                            dashPhase: 0))
                .rotationEffect(Angle(degrees: 90.0))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1 , y: 0, z: 0))
                .frame(width: width, height: height)
                .shadow(color: Color(color2).opacity(0.1), radius: 3 * multiplier, x: 0, y: 3 * multiplier)
                
//            Text("\(Int(percent))%")
//                .font(.system(size: 14 ))// * multiplier))
//                .fontWeight(.bold)
//                .onTapGesture {
//                    self.show.toggle()
//            }
        }
        
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView(show: .constant(true))
    }
}
