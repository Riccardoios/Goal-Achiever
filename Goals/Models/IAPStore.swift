//
//  IAPStore.swift
//  InsomniOwl
//
//  Created by Riccardo Carlotto on 29/10/21.
//

/*
 Riccardo.rich@libero.it
 Gennaro12!
 */

import Foundation
import StoreKit
import SwiftyStoreKit

class IAPStore: NSObject, ObservableObject {
    
    private let productIdentifiers: Set<String>
    
    private var productsRequest: SKProductsRequest? = nil // it starts with a product request that will return SKProducts
    
    public private(set) var purchasedProducts = Set<String>()
    
    private var arrOfExpiryDates = [Date]()
    
    @Published var isSubscribed: Bool
    
    @Published private(set) var product = [SKProduct]() // skproduct are returned products from the store
    
    init(productsIDs: Set<String>) { // we will get the products ids from owl products
        
        self.isSubscribed = UserDefaults.standard.bool(forKey: "isSubscribed")
        productIdentifiers = productsIDs
        
       // load the product identifiers that return true from userdefalts
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
    
    func veryfingReceipt() {
        
        for productIdentifer in productIdentifiers {
           
            let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: "10c714aa8d2741d2920f6335b7dabf7f")
            
            SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
                switch result {
                case .success(let receipt):
                    
                    let purchaseResult = SwiftyStoreKit.verifySubscription(
                        ofType: .autoRenewable, // or .nonRenewing (see below)
                        productId: productIdentifer,
                        inReceipt: receipt)
                        
                    switch purchaseResult {
                    // you can add a let items after expiryDate, to get more property about from the receipt
                    case .purchased(let expiryDate, _):
                        print ("iap .purchased expiry: \(expiryDate)")
                        self.arrOfExpiryDates.append(expiryDate)
                        UserDefaults.standard.set(true, forKey: productIdentifer)
                        
                    case .expired(let expiryDate, _):
                        print("iap .expired expired: \(expiryDate)")
                        self.arrOfExpiryDates.append(expiryDate)
                        UserDefaults.standard.set(false, forKey: productIdentifer)
                        
                    case .notPurchased:
                        print("iap .notPurchased id: \(productIdentifer)")
                        UserDefaults.standard.set(false, forKey: productIdentifer)
                    }

                case .error(let error):
                    print("iap Receipt verification failed: \(error)")
                }
            }
            
        }
        
        setPremiumOrFree()
       
    }
    
    
    func setPremiumOrFree() {
        
        // when want a loop that always return the latest date no matter the order
        var lastExpiryDate: Date! = nil

        //get the latest expiryDate from array that cointains all (could have 2 one for each productIdentifier)
        for expirationDate in arrOfExpiryDates {
            if lastExpiryDate == nil || expirationDate > lastExpiryDate {
                lastExpiryDate = expirationDate
            }
        }
        
        guard let expiryDate = lastExpiryDate else {
            // set all app in free version
            isSubscribed = false
            UserDefaults.standard.set(false, forKey: "isSubscribed")
            
            return
        }
        
        if expiryDate > Date() {
            print ("iap yes subscirbed")
            
            isSubscribed = true
            UserDefaults.standard.set(true, forKey: "isSubscribed")
            
        } else {
            print ("iap not subscribed")
            
            isSubscribed = false
            UserDefaults.standard.set(false, forKey: "isSubscribed")

        }
        objectWillChange.send()
        
        
    }
}

