//
//  IAPManager.swift
//  HistoryCards
//
//  Created by Normand Martin on 2020-05-19.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import StoreKit
import SwiftUI
import UIKit
import Combine

class IAPManager: NSObject{
    let purchasePublisher = PassthroughSubject<(String, Bool), Never>()
    var coins = UserDefaults.standard.integer(forKey: "coins")
    var totalRestoredPurchases = 0
    static let shared = IAPManager()
    override init() {
        super.init()
    }
    func returnProductIDs() -> [String]? {
        return ["2021RecipeBook"]
    }
    func getProductsV5(){
        let productIDs = returnProductIDs()
        let request = SKProductsRequest(productIdentifiers: Set(productIDs!))
        request.delegate = self
        request.start()
    }
    
    func getPriceFormatted(for product: SKProduct) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = product.priceLocale
        return formatter.string(from: product.price)
    }
    func startObserving() {
        print("observe")
        SKPaymentQueue.default().add(self)
    }
    func stopObserving() {
        print("stop observing")
        SKPaymentQueue.default().remove(self)
    }
    func restorePurchasesV5() {
        totalRestoredPurchases = 0
        print()
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        if totalRestoredPurchases != 0 {
            purchasePublisher.send((NSLocalizedStringFunc(key:"Your purchase was restored!"),true))
        } else {
            purchasePublisher.send((NSLocalizedStringFunc(key:"There is no purchase to restore"), false))
        }
    }
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        if let error = error as? SKError {
            if error.code != .paymentCancelled {
                purchasePublisher.send(("Restore Error: " + error.localizedDescription,false))
            } else {
                purchasePublisher.send(("Error: " + error.localizedDescription,false))
            }
        }
    }
    func canMakePayments() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    func purchaseV5(product: SKProduct) -> Bool {
        if !IAPManager.shared.canMakePayments() {
            return false
        } else {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        }
        return true
    }
}
final class productsDB: ObservableObject, Identifiable {
    static let shared = productsDB()
    var items:[SKProduct] = []
    {
        willSet {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
}
extension IAPManager: SKProductsRequestDelegate, SKRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let badProducts = response.invalidProductIdentifiers
        let goodProducts = response.products
        if goodProducts.count > 0 {
            productsDB.shared.items = response.products
            print("bon ",productsDB.shared.items)
        }
        func request(_ request: SKRequest, didFailWithError error: Error) {
            print("didFailWithError ",error)
            purchasePublisher.send((NSLocalizedStringFunc(key:"Purchase request failed"),true))
        }
        
        print("badProducts ",badProducts)
    }
}

extension IAPManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction:AnyObject in transactions {
            if let trans = transaction as? SKPaymentTransaction {
                switch trans.transactionState {
                
                case .purchasing:
                    break
                case .purchased:
                    purchasePublisher.send((NSLocalizedStringFunc(key:"Your recipe Book is unlocked"), true))
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                case .failed:
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    self.purchasePublisher.send((NSLocalizedStringFunc(key:"The transaction could not be completed"), false))

                case .restored:
                    print("restore")
                    totalRestoredPurchases += 1
                    print(totalRestoredPurchases)
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break
                case .deferred:
                    break
                @unknown default:
                    break
                }}}
    }
}
struct Purchased {
    static let shared = Purchased()
    var isPurchased: Bool?
    private init() { }
}
