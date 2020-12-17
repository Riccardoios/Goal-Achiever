//
//  AntiRilievoView.swift
//  Foocus
//
//  Created by Riccardo Carlotto on 20/04/2020.
//  Copyright © 2020 Riccardo Carlotto. All rights reserved.
//

import SwiftUI

struct AntiRilievoView: View {
    
    var width: CGFloat = 220
    var height: CGFloat = 275
    var cornerRadius: CGFloat = 50
    
    var body: some View {
        
            VStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundColor(Color(#colorLiteral(red:0.89, green:0.90, blue:0.93, alpha:1.00)))
                    .frame(width: width, height: height)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(Color(#colorLiteral(red:0.89, green:0.90, blue:0.93, alpha:1.00)), lineWidth: 10)
                            //to add more light increase linewith and x y second shadow
                            .shadow(color: Color(#colorLiteral(red: 0.681924929, green: 0.6859496321, blue: 0.7170756985, alpha: 1)), radius: 2.5, x: 4, y: 4)
                            //to add more shadow increase x y
                            .clipShape(
                                RoundedRectangle(cornerRadius: cornerRadius)
                        )
                            .shadow(color: Color.white.opacity(0.9), radius: 2, x: -4, y: -4)
                            .clipShape(
                                RoundedRectangle(cornerRadius: cornerRadius)
                        )
                )
               
            
        }
    }
}


struct AntiRilievoView_Previews: PreviewProvider {
    static var previews: some View {
        AntiRilievoView()
    }
}
