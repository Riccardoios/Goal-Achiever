//
//  settingsButtonView.swift
//  Foocus
//
//  Created by Riccardo Carlotto on 26/04/2020.
//  Copyright © 2020 Riccardo Carlotto. All rights reserved.
//

import SwiftUI

struct IconView: View {
    
    var image : Image = Image(uiImage: #imageLiteral(resourceName: "noun_setting_196307"))
    var color : Color = Color(#colorLiteral(red: 0.2393075824, green: 0.6728859544, blue: 0.9679804444, alpha: 1))
    
    
    var body: some View {
        
//        var mutableCoefScreen : CGFloat {
//            UIDevice.current.hasNotch ? 50 : 60
//        }
        
        return
            Circle()
            .foregroundColor(color)
            
            .mask(image
                    .resizable()
                    .padding(9)
                    .aspectRatio(contentMode: .fill))
            
            .shadow(color: Color.black.opacity(0.25), radius: 1, x: 1, y: 1)
            .shadow(color: Color.white.opacity(0.9), radius: 1, x: -1, y: -1)
            .shadow(color: Color.black.opacity(0.25), radius: 1, x: 2, y: 2)
            .shadow(color: Color.white.opacity(0.9), radius: 1, x: -2, y: -2)
            .frame(width: 50 * myCoef, height: 50 * myCoef)
        
    }
}

struct settingsButtonView_Previews: PreviewProvider {
    static var previews: some View {
        IconView()
    }
}
