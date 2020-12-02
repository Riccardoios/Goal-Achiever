//
//  SubscriptionProductButtons.swift
//  Goals
//
//  Created by Riccardo Carlotto on 17/11/2020.
//

import SwiftUI
import Purchases

struct SubscriptionProductButtons: View {
    
    @EnvironmentObject var timerVM: TimerViewModel
    @EnvironmentObject var subManager: SubscriptionManager
    
    var body: some View {
        
        var nOfProducts:Int {
            return subManager.offeringObj?.availablePackages.count ?? 0
        }
        var arrayOfProducts : [Purchases.Package]? {
            return subManager.offeringObj?.availablePackages
        }
        
        var arrayOfdurations: [String] {
            var result = [String]()
            let packages = subManager.offeringObj?.availablePackages
            
            guard packages != nil else {
                return result
            }
            
            var duration = ""
            for i in 0..<packages!.count {
                
                let product = packages![i].product
                let subscriptionPeriod = product.subscriptionPeriod
                
                switch subscriptionPeriod!.unit {
                case SKProduct.PeriodUnit.month:
                    duration = "\(subscriptionPeriod!.numberOfUnits) Month"
                case SKProduct.PeriodUnit.year:
                    duration = "\(subscriptionPeriod!.numberOfUnits) Year"
                default:
                    duration = ""
                }
                
                result.append(duration)
                
            }
            
            return result
        }
        
        return HStack(spacing:30){
       
            ForEach(0..<nOfProducts, id: \.self) { i in
                
                Button(action: {print(i, "action")}, label: {
                    
                    ZStack{
                        
                        ButtonView(width: 120, height: 75, cornerRadius: 30, showImage: false)
                        
                        VStack {
                            Text("\(arrayOfdurations[i])")
                            
                            Text("\(arrayOfProducts?[i].localizedPriceString ?? "Unknown")").bold()
                        }
                        .foregroundColor(Color(timerVM.firstColorText))
                        .font(.system(size: timerVM.secondSizeFont))
                        .modifier(ShadowLightModifier())
                        
                        
                        
                    }
                })
                
                
            }
            
        }
        
    }
    
    
    
    
    
    
}





struct SubscriptionProductButtons_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionProductButtons()
    }
}
