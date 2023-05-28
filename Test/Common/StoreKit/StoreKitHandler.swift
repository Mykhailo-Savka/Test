//
//  StoreKitHandler.swift
//  Test
//
//  Created by Savka Mykhailo on 26.05.2023.
//

import Foundation
import StoreKit

// MARK: - StoreKitHandler
class StoreKitHandler: NSObject {
    
    static let shared = StoreKitHandler()
    
    // MARK: - Public properties
    let productIdentifier = "ProductIdentifier1"
    var products: [SKProduct]?
    
    // MARK: - Public methods
    func getProducts() {
        let request = SKProductsRequest(productIdentifiers: [productIdentifier])
        request.delegate = self
        request.start()
    }
    
    func purchase(productParam : SKProduct) -> Bool {
        guard let products = products, products.count > 0 else {
            return false
        }
        let payment = SKPayment(product: productParam)
        SKPaymentQueue.default().add(payment)
        return true
    }
    
    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}

// MARK: - SKProductsRequestDelegate implementation
extension StoreKitHandler: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        response.invalidProductIdentifiers.forEach({ assert($0.count > 0, "Invalid product identifier \($0)")})
        products = response.products
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("StoreKitHandler: \(error.localizedDescription)")
    }
}

// MARK: - SKPaymentTransactionObserver implementation
extension StoreKitHandler: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.error != nil {
                print("error: \(String(describing: transaction.error?.localizedDescription))")
            }
            switch transaction.transactionState {
            case .purchasing:
                print("handle purchasing state")
                break;
            case .purchased:
                print("handle purchased state")
                break;
            case .restored:
                print("handle restored state")
                break;
            case .failed:
                print("handle failed state")
                break;
            case .deferred:
                print("handle deferred state")
                break;
            @unknown default:
                print("Fatal Error");
            }
        }
    }
}
