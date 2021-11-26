//
//  AddSessionView.swift
//  Goals
//
//  Created by Riccardo Carlotto on 29/12/2020.
//



import SwiftUI

struct AddSessionButton: View {
    
    @EnvironmentObject var timerVM : TimerViewModel
    
    var hours = ["1","2","3","4","5"]
    var minutes = Array(0...59)
    @State private var selectedIndex = 0
    let image = Image(uiImage: #imageLiteral(resourceName: "add"))
    
    
    var body: some View {
        
        ZStack{
            
//            Circle()
//                .frame(width: 100, height: 100)
//                .modifier(ShadowLightModifier())
//                .foregroundColor(Color(timerVM.backgroundColor))
            
            VStack {
                
                ButtonView(width: 50, height: 50, image: image, imageSize: 1, offsetX: 1, offsetY: 3, cornerRadius: 50, showImage: true)
                    
                
                Text("Add Session")
                    .font(.system(size: 16))
                    .foregroundColor(Color(timerVM.firstColorText))
                    .modifier(ShadowLightModifier())
                    
                
            }
        }
        
        
    }
}

struct AddSessionButton_Previews: PreviewProvider {
    static var previews: some View {
        AddSessionButton()
            .environmentObject(TimerViewModel())
    }
}
