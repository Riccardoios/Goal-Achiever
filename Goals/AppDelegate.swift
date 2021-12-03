//
//  AppDelegate.swift
//  InsomniOwl
//
//  Created by Riccardo Carlotto on 01/11/21.
//
// this entire file is created by me in order to add an observer for the SKPaymentQue object, this appdelegate can be created when using swiftui when is needed like in this case, it's advice from apple to add the observer of the SKPaymentQue here.

import Foundation
import StoreKit
import Firebase


class AppDelegate: NSObject {
    var store: IAPStore!
}

extension AppDelegate: UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        SKPaymentQueue.default().add(self)  // this method add an observer which is appdelegate but appdelegate needs to conform to SKPaymentTRansactionObserver
        
        DispatchQueue.main.async {
            self.store.veryfingReceipt()
        }
        
        FirebaseApp.configure()
        
        return true
    }
    
}

extension AppDelegate: SKPaymentTransactionObserver {
    // add this default method
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        // it returns an array of transactions
        // loop over the transactions and for each transactionstate run some different methods
        
        for transaction in transactions {
            
            switch transaction.transactionState {
            case .purchased:
                completeTransaction(transaction)
            case .failed:
                failedTransaction(transaction)
            case .deferred:
                print ("the transaction is deferred")
            case .purchasing:
                print ("the transaction is purchasing")
            case .restored:
                completeTransaction(transaction)
            default:
            print ("unhandled transaction state")
            }
        }
        
    }
    
    private func completeTransaction(_ transaction: SKPaymentTransaction) {
        //receipt validation logic (to be sure it's a genuine apple receipts
        
        
        //deliverNotification
        deliverPurchasedNotification(for: transaction.payment.productIdentifier)
        
        //trigger finishTransaction method otherwise apple will send it again
        SKPaymentQueue.default().finishTransaction(transaction)
        
    }
    
    private func failedTransaction(_ transaction: SKPaymentTransaction) {
        // handle the error chekc is not canceled and print the error
        if let transactionError = transaction.error as NSError?, let localisedDescription = transaction.error?.localizedDescription, transactionError.code != SKError.paymentCancelled.rawValue {
            print ("transaction error \(localisedDescription)")
        }
        
        //trigger finishTransaction method otherwise apple will send it again
        SKPaymentQueue.default().finishTransaction(transaction)
        
        
    }
    
    private func deliverPurchasedNotification(for identifier: String?) {
        // here we process the succesful transaction
        //check for proper identifier
        
        guard let identifier = identifier else { return }
        
        store.addPurchase(purchaseIdentifier: identifier)
        
        store.isSubscribed = true
        UserDefaults.standard.set(true, forKey:"isSubscribed")
    }
    
}
