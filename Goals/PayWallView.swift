//
//  SwiftUIView.swift
//  Goals
//
//  Created by Riccardo Carlotto on 28/11/2020.
//

/*
 - show the name of the app, the name of the subscritpion group, the name of the subscription ("all access or go premium")
 - A link to the Terms of Use in your app
 – A link to the privacy policy in your app
 - Personalise the app colour (here i need to create a view where you can access the color (using the old one and see)
 */

import SwiftUI
import Purchases

struct PayWallView: View {
    
    @EnvironmentObject var timerVM : TimerViewModel
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var subManager: SubscriptionManager
    
    @Binding var showPayWall: Bool
    @Binding var showSettingView: Bool
    
    var arrOfDetails2 = [["1.99", "3.99", "35.00", "45.00"], [" / Week = 🍬", " / Month = ☕️", " / Year = 🥮", " / Lifetime = 🍱"]]
    
    var body: some View {
      
        // check the legend of the 2d arr
        
        var arrOfPackage: [Purchases.Package]{
            
            var result = [Purchases.Package]()
            let packages = subManager.offeringObj?.availablePackages
            
            guard packages != nil else {
                return result
            }
            
            for i in 0..<packages!.count {
                let package = packages![i]
                result.append(package)
            }
            
            return result
        }
        
        var arrOfDetails: [[String]] {
            var arrOfDuration = [String]()              //arrOfDetail[0]
            var arrOfPrice = [String]()                 //arrOfDetail[1]
            var arrOfIdentifier = [String]()            //arrOfDetail[2]
            
            let packages = subManager.offeringObj?.availablePackages
            
            guard packages != nil else {
                return [arrOfPrice, arrOfDuration]
            }
            
            var duration = ""
            
            for i in 0..<packages!.count {
            
                let product = packages![i].product
                let subscriptionPeriod = product.subscriptionPeriod
                let price = packages![i].localizedPriceString
                var titleProduct = packages![i].identifier.description.capitalized
                
                for _ in 1...4 { //remove firat three characters
                    titleProduct.remove(at: titleProduct.startIndex)
                }
                
                switch subscriptionPeriod!.unit {
                
                case SKProduct.PeriodUnit.week:
                    duration = " per Week = 🍬"
                case SKProduct.PeriodUnit.month:
                    duration = " per Month = ☕️"
                case SKProduct.PeriodUnit.year:
                    duration = " per Year = 🥮"
                    //before it was like so inside the "" \(subscriptionPeriod!.numberOfUnits) per Year = 🥮
//                case SKProduct.PeriodUnit:
//                    duration = " / \(subscriptionPeriod!.numberOfUnits) Lifetime = 🍱"
                default:
                    duration = ""
                }
                
                arrOfPrice.append(price)
                arrOfDuration.append(duration)
                arrOfIdentifier.append(titleProduct)
                
                
            }
            
            return [arrOfPrice, arrOfDuration, arrOfIdentifier]
        }
        
        return ScrollView(showsIndicators: true) {
            
            ZStack{
                
                Color(#colorLiteral(red: 0.8937353492, green: 0.9016036391, blue: 0.9264202714, alpha: 1))
                    .ignoresSafeArea(.all)
                
                LazyVStack(spacing:40){
                    
                    ZStack {
                    
                    HStack{
                        
                        
                        Spacer()
                        
                        Button(action: {
//                            self.presentationMode.wrappedValue.dismiss()
                            showPayWall = false
                            showSettingView = true
                        }) {
                            ZStack{
                                
                                ButtonView(width: 50, height: 50, cornerRadius: 90, showImage: false)
                                
                                Image(systemName:"xmark")
                                    .foregroundColor(Color(timerVM.firstColorTextDarker))
//                                    .modifier(ShadowLightModifier())
                                
                                 
                            }
                            .padding()
                            .offset(y: -15)
                            
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
                        
//                    Text("\(subManager.offeringObj?.serverDescription ?? "Unkown")")
//                    Text("\(subManager.offeringObj?.identifier ?? "Unkown") + identifier")
//                    Text("\(subManager.offeringObj.debugDescription)")
                    
                    
//                    ZStack{
                        
                        
                        
                        VStack(alignment: .leading, spacing: 20) {
                            
                            Text("📊 Unlock More Charts")
                                .padding(.leading, 30)
                                .modifier(ShadowLightModifier())
                            
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
                                .modifier(ShadowLightModifier())
                            
                            
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
                                .modifier(ShadowLightModifier())
                            
                            HStack {
                                
                                Spacer()
                                    .frame(width:60)
                                
                                Text("To precisely set a reminder for your goal")
                                    .font(.system(size: 17))
                                    .foregroundColor(Color(timerVM.secondColorText))
                                    .padding(.bottom, 20)
                                    .padding(.trailing, 40)
                                
                            }
//                            Text("🎨 Personalise the app colour")
//                                .padding(.leading, 30)
//                            
//                            HStack {
//                                
//                                Spacer()
//                                    .frame(width:60)
//                                
//                                Text("Make Goal Achiever even prettier")
//                                    .font(.system(size: 17))
//                                    .foregroundColor(Color(timerVM.secondColorText))
//                                    .padding(.bottom, 20)
//                                    .padding(.trailing, 40)
//                            }
                        }
                        .font(.system(size: 21))
                        
                        
//                    }
                    
                   
                    
                    ForEach((0..<arrOfDetails[0].count).reversed(), id: \.self) { i in
                        
                        Button(action: {
                            
                            purchase(package: arrOfPackage[i])
                            
                        }, label: {
                            
                            ZStack{
                                
                                ButtonView(width: screen.width - 150, height: 90, cornerRadius: 30, showImage: false)
                                //height was 60
                                VStack {
                                    Text(arrOfDetails[2][i])
                        
                                    HStack {
                                        Text(arrOfDetails[0][i] + arrOfDetails[1][i])
                                    }
                                }
                                .modifier(ShadowLightModifier())
                                .font(.system(size: timerVM.secondSizeFont - 4))
                                .frame(width: screen.width - 160, height: 60)
                            }
                        })
                    }
                    
//                    Spacer().frame(height:50)
                    
                    if subManager.subscriptionStatus == false {
                        
                        Button(action: {
                            Purchases.shared.restoreTransactions { (purchaserInfo, error) in
                                
                                if let purchaserInfo = purchaserInfo {
                                    if purchaserInfo.entitlements["pro"]?.isActive == true {
                                        
                                        self.subManager.subscriptionStatus = true
                                        self.presentationMode.wrappedValue.dismiss()
                                        
                                    }
                                }
                                //... check purchaserInfo to see if entitlement is now active
                            }
                        }) {
                            Text("Restore Purchase")
                                .underline()
                                .font(.system(size: 15))
                                .modifier(ShadowLightModifier())
                                .foregroundColor(Color(timerVM.firstColorText))
                            
                        }
                        
                    }
                    
//                    Text("Payment will be charged to your iTunes account at confirmation of purchase - Subscription automatically renews bla bla bla ")
//                        .fixedSize(horizontal: false, vertical: true)
//                        .lineLimit(nil)
//                        .font(.system(size: 15))
//                        .modifier(ShadowLightModifier())
//                        .foregroundColor(Color(timerVM.secondColorText))
//                        .padding()
                    
                    HStack {
                        
                        Link("Privacy Policy", destination: URL(string: "https://riccardoios.github.io/goal-achiever")!)
                            .font(.system(size: 15))
                            .modifier(ShadowLightModifier())
                            .foregroundColor(Color(timerVM.firstColorText))
                        
                        Divider()
                        
                        Link("Terms of Use", destination: URL(string: "https://riccardoios.github.io/goal-achiever-Terms-of-Use")!)
                            .font(.system(size: 15))
                            .modifier(ShadowLightModifier())
                            .foregroundColor(Color(timerVM.firstColorText))
                    }
                    .padding()
                    
                        
                    
                }
                .ignoresSafeArea(.all)
                .foregroundColor(Color(#colorLiteral(red: 0.2393075824, green: 0.6728859544, blue: 0.9679804444, alpha: 1)))
                .animation(.linear)
                .padding(.bottom, 50)
                .padding(.top, 10)
                
               
                
                
            }
        }
    }
    
    func purchase(package: Purchases.Package) {
      
            Purchases.shared.purchasePackage(package) { (transaction, purchaserInfo, error, userCancelled) in
                if purchaserInfo?.entitlements["pro"]?.isActive == true {
                    self.subManager.subscriptionStatus = true
                self.presentationMode.wrappedValue.dismiss()
                
              }
            }
    }
    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        PayWallView(showPayWall: .constant(true), showSettingView: .constant(false))
        
    }
}
