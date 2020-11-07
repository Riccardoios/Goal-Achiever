//
//  WaveAnimationView.swift
//  Goals
//
//  Created by Riccardo Carlotto on 05/11/2020.
//

import SwiftUI

struct WaveAnimationView : View {
    
    var animate = false
    var lineWidth: CGFloat = 5
    
    var body: some View {
       
                Circle()
                    .stroke(lineWidth: lineWidth)
                    .foregroundColor(Color(#colorLiteral(red:0.89, green:0.90, blue:0.93, alpha:1.00)))
                    .scaleEffect(animate ? 1 : 0)
                    .opacity(animate ? 0 : 1)
                    .animation(Animation.easeInOut(duration: 1.5).repeatCount(15, autoreverses: false))
                    .modifier(ShadowLightModifier())

        
    }
}

struct WaveAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        WaveAnimationView()
    }
}
