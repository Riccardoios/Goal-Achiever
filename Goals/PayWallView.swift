//
//  SwiftUIView.swift
//  Goals
//
//  Created by Riccardo Carlotto on 28/11/2020.
//

// INFO: Purchases instance already set. Did you mean to configure two Purchases objects?

import SwiftUI
import Purchases

struct PayWallView: View {
    
    @EnvironmentObject var timerVM : TimerViewModel
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var subManager: SubscriptionManager
    
    var arrOfDetails2 = [["1.99", "3.99", "35.00", "45.00"], [" / Week = 🍬", " / Month = ☕️", " / Year = 🥮", " / Lifetime = 🍱"]]
    
    var body: some View {
        
//        var nOfProducts:Int {
//            return subManager.offeringObj?.availablePackages.count ?? 0
//        }
        
        var arrOfDetails: [[String]] {
            var arrOfDuration = [String]()
            var arrOfPrice = [String]()
            let packages = subManager.offeringObj?.availablePackages
            
            guard packages != nil else {
                return [arrOfPrice, arrOfDuration]
            }
            
            var duration = ""
            
            for i in 0..<packages!.count {
                
                let product = packages![i].product
                let subscriptionPeriod = product.subscriptionPeriod
                let price = packages![i].localizedPriceString
            
                
                switch subscriptionPeriod!.unit {
                
//                case SKProduct.PeriodUnit.week:
//                    duration = " / \(subscriptionPeriod!.numberOfUnits) Week = 🍬"
                case SKProduct.PeriodUnit.month:
                    duration = " / \(subscriptionPeriod!.numberOfUnits) Month = ☕️"
                case SKProduct.PeriodUnit.year:
                    duration = " / \(subscriptionPeriod!.numberOfUnits) Year = 🥮"
//                case SKProduct.PeriodUnit:
//                    duration = " / \(subscriptionPeriod!.numberOfUnits) Lifetime = 🍱"
                default:
                    duration = ""
                }
                
                arrOfPrice.append(price)
                arrOfDuration.append(duration)
                
            }
            
            return [arrOfPrice, arrOfDuration]
        }
        
        return ScrollView(showsIndicators: true) {
            
            ZStack{
                
                Color(#colorLiteral(red: 0.8937353492, green: 0.9016036391, blue: 0.9264202714, alpha: 1))
                    .ignoresSafeArea(.all)
                
                VStack{
                    
                    //                    Text("Go Premium")
                    //                        .foregroundColor(.blue)//(timerVM.backgroundColor))
                    //                        .modifier(ShadowLightModifier())
                    //                        .font(.system(size: 35))
                    
                    ZStack {
                    
                    HStack{
                        
                        
                        Spacer()
                        
                        Button(action: {
                             
                            self.presentationMode.wrappedValue.dismiss()
                            
                        }) {
                            ZStack{
                                
                                ButtonView(width: 50, height: 50, cornerRadius: 90, showImage: false)
                                
                                Image(systemName:"xmark")
                                    .foregroundColor(Color(timerVM.firstColorText))
                                    .modifier(ShadowLightModifier())
                                 
                            }
                            .padding()
                            .offset(x: 15, y: -15)
                            
                        }
                        
                    }
                    
                    
                    Text("Go Premium")
                        .font(.system(size: 40, weight:.semibold))
                        .foregroundColor(Color(#colorLiteral(red: 0.2393075824, green: 0.6728859544, blue: 0.9679804444, alpha: 1)))
                        .modifier(ShadowLightModifier())
                    
                    }
                        
                    Circle()
                        .foregroundColor(Color(#colorLiteral(red: 0.2393075824, green: 0.6728859544, blue: 0.9679804444, alpha: 1)))
                        .mask(Image("goal")
                                .resizable()
                                .padding(9)
                                .aspectRatio(contentMode: .fill))
                        .frame(width: 200, height: 200)
                        .modifier(ShadowLightModifier())
                        .padding(.horizontal, -20)
                        .padding(.top, -20)
                        
                    
                    
                    ZStack{
                        
                        AntiRilievoView(width: screen.width - 30, height: 400, cornerRadious: 40)
                            .offset(x:7.5, y:-15)
                        
                        
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
                            
                            Text("⏰ Set notifications at specific time")
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
                    
                   
                    
                    ForEach(0..<arrOfDetails[0].count, id: \.self) { i in
                        
                        Button(action: {print(i, "action")}, label: {
                            
                            ZStack{
                                
                                ButtonView(width: screen.width - 150, height: 60, cornerRadius: 30, showImage: false)
                                
                                HStack {
                                    Text(arrOfDetails[0][i] + arrOfDetails[1][i])
                                }
                                .modifier(ShadowLightModifier())
                                .font(.system(size: timerVM.secondSizeFont - 4))
                                .frame(width: screen.width - 160, height: 60)
                                
                            }
                        })
                        
                    }
                    
                   
                    
                }
                .ignoresSafeArea(.all)
                .foregroundColor(Color(#colorLiteral(red: 0.2393075824, green: 0.6728859544, blue: 0.9679804444, alpha: 1)))
                .padding(.bottom, 50)
                .padding(.top, 10)
                
                
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        PayWallView()
        
    }
}
