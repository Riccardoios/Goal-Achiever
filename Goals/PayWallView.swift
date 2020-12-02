//
//  SwiftUIView.swift
//  Goals
//
//  Created by Riccardo Carlotto on 28/11/2020.
//

// ad on everNote the .sheet thingy
// system the layout
// center the antirilievo view
// set the color without timerVM
// make better expereice when you touch it
// implement the real logic for the revenueCat

import SwiftUI

struct PayWallView: View {
    
    @EnvironmentObject var timerVM : TimerViewModel
    @Binding var showPayWallView: Bool
    
    var arrOfDetails = [["1.99", "3.99", "35.00", "45.00"], [" / Week = 🍬", " / Month = ☕️", " / Year = 🥮", " / Lifetime = 🍱"]]
    
    var body: some View {
        ScrollView {
            
            ZStack{
                
                Color(#colorLiteral(red: 0.8937353492, green: 0.9016036391, blue: 0.9264202714, alpha: 1))//(timerVM.backgroundColor)
                
                VStack{
                    
                    //                    Text("Go Premium")
                    //                        .foregroundColor(.blue)//(timerVM.backgroundColor))
                    //                        .modifier(ShadowLightModifier())
                    //                        .font(.system(size: 35))
                    
                    Text("Go Premium")
                        .font(.system(size: 40, weight:.semibold))
                        .foregroundColor(Color(#colorLiteral(red: 0.2393075824, green: 0.6728859544, blue: 0.9679804444, alpha: 1)))
                        .modifier(ShadowLightModifier())
                    
                    
                    Circle()
                        .foregroundColor(Color(#colorLiteral(red: 0.2393075824, green: 0.6728859544, blue: 0.9679804444, alpha: 1)))
                        .mask(Image("goal")
                                .resizable()
                                .padding(9)
                                .aspectRatio(contentMode: .fill))
                        .frame(width: 200, height: 200)
                        .modifier(ShadowLightModifier())
                        .padding(-20)
                    
                    
                    ZStack{
                        
                        AntiRilievoView(width: screen.width - 40, height: 430, cornerRadious: 40)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            
                            Text("📊 Unlock More Charts")
                                .padding(.leading, 30)
                            
                            HStack {
                                
                                Spacer()
                                    .frame(width:60)
                                
                                Text("To display data and invite further explorations")
                                    .font(.system(size: 17))
                                    .foregroundColor(Color(timerVM.secondColorText))
                                    .padding(.bottom, 20)
                                    .padding(.trailing, 40)
                            }
                            
                            Text("🍅 Tomato Method")
                                .padding(.leading, 30)
                            
                            
                            HStack {
                                
                                Spacer()
                                    .frame(width:60)
                                
                                Text("A time management method that enhance your focus towards your goals")
                                    .font(.system(size: 17))
                                    .foregroundColor(Color(timerVM.secondColorText))
                                    .padding(.bottom, 20)
                                    .padding(.trailing, 40)
                                
                            }
                            
                            Text("🔴 Set notifications at specific time")
                                .padding(.leading, 30)
                            
                            HStack {
                                
                                Spacer()
                                    .frame(width:60)
                                
                                Text("To precisely set a reminder for your goal")
                                    .font(.system(size: 17))
                                    .foregroundColor(Color(timerVM.secondColorText))
                                    .padding(.bottom, 20)
                                    .padding(.trailing, 40)
                            }
                            Text("🎨 Personalise the app colour")
                                .padding(.leading, 30)
                            
                            HStack {
                                
                                Spacer()
                                    .frame(width:60)
                                
                                Text("Make Goal Achiever even prettier")
                                    .font(.system(size: 17))
                                    .foregroundColor(Color(timerVM.secondColorText))
                                    .padding(.bottom, 20)
                                    .padding(.trailing, 40)
                            }
                        }
                        .modifier(ShadowLightModifier())
                        .font(.system(size: 21))
                        
                        
                        
                        
                        
                    }
                    
                    //                    Spacer()
                    
                    ForEach(0..<4, id: \.self) { i in
                        
                        Button(action: {print(i, "action")}, label: {
                            
                            ZStack{
                                
                                ButtonView(width: screen.width - 150, height: 60, cornerRadius: 30, showImage: false)
                                
                                HStack {
                                    Text("$" + arrOfDetails[0][i] + arrOfDetails[1][i])
                                    
                                }
                                .modifier(ShadowLightModifier())
                                
                            }
                        })
                        
                    }
                }
                .ignoresSafeArea(.all)
                .foregroundColor(Color(#colorLiteral(red: 0.2393075824, green: 0.6728859544, blue: 0.9679804444, alpha: 1)))
                
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        PayWallView(showPayWallView: .constant(true))
        
    }
}
