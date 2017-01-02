//
//  StockCheckerItem.swift
//  AppleStockChecker
//
//  Created by Brendan Boyle on 12/31/16.
//  Copyright © 2016 Brendan Boyle. All rights reserved.
//

import Cocoa

class StockCheckerItem: NSObject {
    
    //Apple model number (ex MMEF2AM/A)
    var model:String
    //Zip code to search for product in
    var zipCode:Int
    //Product name (optional)
    var productName:String
    
    init(model:String, zipCode:Int, productName:String = "Apple Product") {
        self.model = model
        self.zipCode = zipCode
        self.productName = productName
        
        if (self.zipCode <= 10000) {
            print("Invalid zip code! \(self.model)")
        }
        
        super.init()
    }
    
    func modelURL() -> String {
        return model.replacingOccurrences(of: "/", with: "%2F")
    }
}
