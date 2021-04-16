//
//  PremiumOnlyView.swift
//  Goals
//
//  Created by Riccardo Carlotto on 13/12/2020.
//

import SwiftUI

struct PremiumOnlyView: View {
    
//    @State var showPayWall = false
//    @State var showSettingView = false
    
    var width:CGFloat = 80
    var height:CGFloat = 80
    var opacity:Double = 0.55
    var cornerRadius:CGFloat = 24
    
    var body: some View {
        
        VStack() {
            
            Text("Premium \nOnly")
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                
        }
        .frame(width: width, height: height)
        .background(Color.white.opacity(opacity))
        .cornerRadius(cornerRadius)
//        .onTapGesture {
//            showPayWall = true
//
//        }
        
//        .sheet(isPresented: $showPayWall) {
//            PayWallView(showPayWall: $showPayWall, showSettingView: $showSettingView)
//                .environmentObject(TimerViewModel())
//                .environmentObject(SubscriptionManager())
//                }
        
    }
}

//struct PremiumOnlyView_Previews: PreviewProvider {
//    static var previews: some View {
//        PremiumOnlyView(showPayWall: .constant(false), showSettingView: .constant(false))
//    }
//}
