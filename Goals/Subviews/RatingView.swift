//
//  RatingView.swift
//  CoreData and SwiftUI
//
//  Created by Riccardo Carlotto on 27/08/2020.
//  Copyright © 2020 Riccardo Carlotto. All rights reserved.
//

import SwiftUI

struct RatingView: View {
    
    @Binding var rating : Int
    @EnvironmentObject var timerVM : TimerViewModel
    
    var label = ""
    var maximumRating = 5
    
    var offImage : Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach (1..<maximumRating + 1) { number in
                self.image(for: number)
                    .foregroundColor(number > self.rating ? self.offColor : self.onColor)
                    .font(.system(size: self.timerVM.firstSizeFont / 1.5))
            }
        }
    }
    
    func image(for number:Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
