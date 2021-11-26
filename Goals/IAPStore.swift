//
//  IAPStore.swift
//  InsomniOwl
//
//  Created by Riccardo Carlotto on 29/10/21.
//

import Foundation
import StoreKit
import SwiftyStoreKit

class IAPStore: NSObject, ObservableObject {
    
    private let productIdentifiers: Set<String>
    
    private var productsRequest: SKProductsRequest? = nil // it starts with a product request that will return SKProducts
    
    public private(set) var purchasedProducts = Set<String>()
    
    @Published var isSubscribed = false
    
    @Published private(set) var product = [SKProduct]() // skproduct are returned products from the store
    
    init(productsIDs: Set<String>) { // we will get the products ids from owl products
        productIdentifiers = productsIDs
        
        //load the product identifiers that return true from userdefalts
        purchasedProducts = Set(productIdentifiers.filter {
            UserDefaults.standard.bool(forKey: $0)
        })
        super.init()
    }
    
    func requestProducts() {
        productsRequest?.cancel()
        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        productsRequest?.delegate = self
        productsRequest?.start()
    }
    
    func buyProduct(product: SKProduct) {
        let payment = SKPayment(product: product) // first call this
        SKPaymentQueue.default().add(payment) // then add the payment in the que
        
    }
    
    func addPurchase(purchaseIdentifier: String) {
        if productIdentifiers.contains(purchaseIdentifier) {
            purchasedProducts.insert(purchaseIdentifier)
            //save the id.. in userdefaults
            UserDefaults.standard.set(true, forKey: purchaseIdentifier)
            objectWillChange.send()
        }
    }
    
    func isPurchased(_ productIdentifier: String) -> Bool {
        purchasedProducts.contains(productIdentifier)
    }
    
    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func addConsumable(productIdentifier: String, amount: Int) {
       var currentTotal = consumableAmountFor(productIdentifier: productIdentifier)
        currentTotal += amount
        UserDefaults.standard.set(currentTotal, forKey: productIdentifier)
        objectWillChange.send()
    }
    
    func consumableAmountFor(productIdentifier: String) -> Int {
        return UserDefaults.standard.integer(forKey: productIdentifier)
        // this return 1 or 0: true = 1, false = 0
    }
    
    func decrementConsumable(productIdentifier: String) {
        var currentTotal = consumableAmountFor(productIdentifier: productIdentifier)
        if currentTotal > 0 {
            currentTotal -= 1
        }
        UserDefaults.standard.set(currentTotal, forKey: productIdentifier)
        objectWillChange.send()
    }
    
    
    
}

extension IAPStore: SKProductsRequestDelegate {
    // to get this request we inherit from SKProductsRequestDelegate and the request need to be asyncronous as it takes time and we don't want to freeze the app for the time being
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        //it needs to go in the main Thread
        DispatchQueue.main.async { [weak self] in
            self?.product = response.products //set the product
            self?.objectWillChange.send() // we need to update the changes with this method inherited from ObserbaleObject
        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print ("the SKRequest has failed \(error) ")
    }
    
    
}

extension IAPStore {
    
    func veryfingReceipt(productIdentifer: String) {
        
        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: "a0c6b541557d40ca9df1ec08666cff0a")
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            switch result {
            case .success(let receipt):
                
                // Verify the purchase of a Subscription
                let purchaseResult = SwiftyStoreKit.verifySubscription(
                    ofType: .autoRenewable, // or .nonRenewing (see below)
                    productId: productIdentifer,
                    inReceipt: receipt)
                    
                switch purchaseResult {
                case .purchased(let expiryDate, let items):
                    print ("user is subscirbed unitl \(expiryDate)")
//                    print("\(productIdentifer) is valid until \(expiryDate)\n\(items)\n")
                    
                    UserDefaults.standard.set(expiryDate, forKey: "expiryDate")
                    // enable or keep the subscribed status
                
                case .expired(let expiryDate, let items):
                    print("user is not subscribed \(expiryDate)")
//                    print("\(productIdentifer) is expired since \(expiryDate)\n\(items)\n")
                    
                    UserDefaults.standard.set(expiryDate, forKey: "expiryDate")
                    // disable the subscribed status
                
                case .notPurchased:
                    print("The user has never purchased \(productIdentifer)")
                }

            case .error(let error):
                print("Receipt verification failed: \(error)")
            }
        }

    }
    
    func getSubscirbedState() {
        let expiryDate = UserDefaults.standard.object(forKey: "expiryDate") as? Date
        
        print (expiryDate, "today is ", Date())
        
        guard let finalDateSubscription = expiryDate else {
            return
        }
        
        if finalDateSubscription > Date() {
            print ("yes subscirbed")
            isSubscribed = true
            
        } else {
            print ("not subscribed")
            isSubscribed = false
        }
        objectWillChange.send()
    }
}
