//
//  GoalIconView.swift
//  Foocus
//
//  Created by Riccardo Carlotto on 05/08/2020.
//  Copyright © 2020 Riccardo Carlotto. All rights reserved.
//

import SwiftUI

struct GoalIconView: View {
    
    var emoji : String
    var isSelected : Bool
    var body: some View {
        
        ZStack {
            
            Circle()
                .fill(Color(#colorLiteral(red:0.89, green:0.90, blue:0.93, alpha:1.00)))
                .frame(width: isSelected ? 120 : 80,
                       height: isSelected ? 120 : 80)
                .modifier(ShadowLightModifier())
                .animation(.linear)
            
            Text(emoji)
                .font(.system(size: 40))
//                .modifier(ShadowLightModifier())
//                .modifier(ShadowLightModifier())
            
            
        }
    }
}

struct GoalIconView_Previews: PreviewProvider {
    static var previews: some View {
        GoalIconView(emoji:"📚", isSelected: .init(false))
    }
}


