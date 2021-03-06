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
import StoreKit


struct PayWallView: View {
    
    @EnvironmentObject var timerVM : TimerViewModel
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var store: IAPStore
    
    @Binding var showPayWall: Bool
    @Binding var showSettingView: Bool
    
    var arrOfDetails2 = [["1.99", "3.99", "35.00", "45.00"], [" / Week = 🍬", " / Month = ☕️", " / Year = 🥮", " / Lifetime = 🍱"]]
    
    var body: some View {
        
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
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        Text("👨🏻‍💻 Support the developer")
                            .modifier(ShadowLightModifier())
                        
//                        HStack {
//
//                            Spacer()
//                                .frame(width:60)
//
//                            Text("To display data and invite further explorations")
//                                .font(.system(size: 17))
//                                .foregroundColor(Color(timerVM.secondColorText))
//                                .padding(.bottom, 20)
//                                .padding(.trailing, 40)
//                        }
                        
                        Text("🎉 No more Adverts!")
                            .modifier(ShadowLightModifier())
                        
                        
//                        HStack {
//
//                            Spacer()
//                                .frame(width:60)
//
//                            Text("A time management method that enhance your focus towards your goals")
//                                .font(.system(size: 17))
//                                .foregroundColor(Color(timerVM.secondColorText))
//                                .padding(.bottom, 20)
//                                .padding(.trailing, 40)
//
//                        }
                        
//                        Text("⏰ Set notifications at specific time")
//                            .padding(.leading, 30)
//                            .modifier(ShadowLightModifier())
//
//                        HStack {
//
//                            Spacer()
//                                .frame(width:60)
//
//                            Text("To precisely set a reminder for your goal")
//                                .font(.system(size: 17))
//                                .foregroundColor(Color(timerVM.secondColorText))
//                                .padding(.bottom, 20)
//                                .padding(.trailing, 40)
                            
//                        }
                    }
                    .font(.system(size: 30))
                    
                    Spacer()
                    
                        ForEach(store.product, id:\.self) { product in
                            
                            ProductRow(product: product)
                                .padding(.horizontal, 40)
                            
                        }
                        .foregroundColor(Color(timerVM.firstColorText))
                    
                    
                    
                   
                    Button {
                        store.restorePurchases()
                        
                    } label: {
                            Text("Restore Purchase")
                                .underline()
                                .font(.system(size: 15))
                                .modifier(ShadowLightModifier())
                                .foregroundColor(Color(timerVM.firstColorText))
                    }

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
                .onAppear{
                    store.requestProducts()
                }
                .ignoresSafeArea(.all)
//                .foregroundColor(Color(#colorLiteral(red: 0.2393075824, green: 0.6728859544, blue: 0.9679804444, alpha: 1)))
                .animation(.linear)
                .padding(.bottom, 50)
                .padding(.top, 10)
                
                
                
                
            }
        }
    }
    
    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        PayWallView(showPayWall: .constant(true), showSettingView: .constant(false))
            .environmentObject(TimerViewModel())
        
    }
}

struct ProductRow: View {
    
    @EnvironmentObject var store: IAPStore
    @State var isPresented = false
    let product: SKProduct
    let price: String
    
    init(product: SKProduct) {
        self.product = product
        let formatter = NumberFormatter()
        formatter.locale = product.priceLocale
        formatter.numberStyle = .currency
        price = formatter.string(from: product.price) ?? ""
    }
    
    var body: some View {
        HStack(alignment:.center) {
            VStack(alignment: .leading, spacing: nil) {
                Text("\(product.localizedTitle) - \(price)")
                Text(product.localizedDescription)
            }
            
            Spacer()
            
            if store.isPurchased(product.productIdentifier) {
                CheckedView()
            } else {
                PurchaseButton(product: product)
            }
            
        }
        .modifier(ShadowLightModifier())
//        .padding()
    }
}

struct PurchaseButton: View {
    
    @EnvironmentObject var store: IAPStore
    let product: SKProduct
    
    var body: some View {
        HStack {
            Image(systemName: "cart")
            Text("Buy")
        }
        .onTapGesture {
            store.buyProduct(product: product)
        }
        .padding(10)
        .foregroundColor(.yellow)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.yellow, lineWidth: 2)
        )
        
    }
    
}

struct CheckedView: View {
    
    var body: some View {
        Image(systemName: "checkmark")
            .padding(10)
            .foregroundColor(.black)
            .overlay(
                Circle()
                    .stroke(Color.black, lineWidth: 2)
            )
    }
    
}
