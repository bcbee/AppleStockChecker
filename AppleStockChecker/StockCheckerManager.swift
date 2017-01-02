//
//  StockCheckerManager.swift
//  AppleStockChecker
//
//  Created by Brendan Boyle on 12/31/16.
//  Copyright © 2016 Brendan Boyle. All rights reserved.
//

import Cocoa

class StockCheckerManager: NSObject {
    
    var items:[StockCheckerItem] = [StockCheckerItem]()
    var stores:[StockCheckerStore] = [StockCheckerStore]()
    var timer:Timer?
    
    func addItem(item:StockCheckerItem) -> Void {
        if ((timer) != nil) {
            timer?.invalidate()
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerTick), userInfo: nil, repeats: false)
        items.append(item)
    }
    
    func timerTick() {
        for stockItem in items {
            let url:String = "http://www.apple.com/shop/retail/pickup-message?parts.0=\(stockItem.modelURL())&location=\(stockItem.zipCode)"
            DBZ_UniversalNetworking.httpGet(url, callback: processResponse, page: stockItem)
        }
    }
    
    func processResponse(response:DBZ_NetworkResponse) {
        let product = response.page as! StockCheckerItem
        print("\(product.productName) stock as of \(Date())")
        let dictionary:[String: Any] = convertToDictionary(text: response.htmlData)!
        let body:[String: Any] = dictionary["body"] as! [String: Any]
        let stores:NSArray = body["stores"] as! NSArray
        
        for store in stores {
            let currentStore = store as! [String: Any]
            let storeName:String = currentStore["storeName"] as! String
            let partsAvailability:[String: Any] = currentStore["partsAvailability"] as! [String: Any]
            let part:[String: Any] = partsAvailability["MMEF2AM/A"] as! [String: Any]
            let pickupDisplay = part["pickupDisplay"] as! String
            if pickupDisplay == "available" {
                print("\(storeName): \(pickupDisplay)");
            } else {
                print("\(storeName): \(pickupDisplay)");
            }
        }
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func getStoreByName(name:String) -> StockCheckerStore? {
        for store in stores {
            if store.name == name {
                return store
            }
        }
        return nil
    }

}
