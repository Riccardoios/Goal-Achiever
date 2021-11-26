//
//  ButtonView.swift
//  Foocus
//
//  Created by Riccardo Carlotto on 26/04/2020.
//  Copyright © 2020 Riccardo Carlotto. All rights reserved.
//

import SwiftUI

struct ButtonView: View {
    
    var width : CGFloat = 90
    var height : CGFloat = 60
    var image : Image = Image(uiImage: #imageLiteral(resourceName: "ppppddddfff"))
    var imageSize : CGFloat = 1.2
    var offsetX : CGFloat = 0
    var offsetY : CGFloat = 0
    var cornerRadius : CGFloat = 15
    var showImage = true
    var colorImage = #colorLiteral(red:0.89, green:0.90, blue:0.93, alpha:1.00)
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .frame(width:width, height:height)
                .foregroundColor(Color(#colorLiteral(red:0.89, green:0.90, blue:0.93, alpha:1.00)))
                .brightness(-0.3)
                .opacity(0.6)
                .blur(radius: 2)
                .offset(x: 3, y: 3)
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .frame(width:width, height:height)
                .foregroundColor(Color(#colorLiteral(red:0.89, green:0.90, blue:0.93, alpha:1.00)))
                .brightness(0.1)
                .opacity(0.6)
                .blur(radius: 2)
                .offset(x: -3, y: -3)
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .frame(width:width, height:height)
                .foregroundColor(Color(#colorLiteral(red:0.89, green:0.90, blue:0.93, alpha:1.00)))
            
            
            Color(colorImage)
                .mask(
                    image
                        .resizable()
                        .padding(9)
                        .aspectRatio(contentMode: .fit)
            )
            .modifier(ShadowLightModifier())
//                .shadow(color: Color.black.opacity(0.25), radius: 1, x: 1, y: 1)
//                .shadow(color: Color.white.opacity(0.9), radius: 1, x: -1, y: -1)
                
                
                .frame(width:width * imageSize , height: height * imageSize)
                .offset(x:offsetX, y:offsetY)
                .opacity(showImage ? 1 : 0)
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
       ButtonView()
    }
}
