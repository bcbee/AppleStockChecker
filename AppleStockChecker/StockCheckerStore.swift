//
//  StockCheckerStore.swift
//  AppleStockChecker
//
//  Created by Brendan Boyle on 1/1/17.
//  Copyright © 2017 Brendan Boyle. All rights reserved.
//

import Cocoa

class StockCheckerStore: NSObject {
    //Name of the store
    var name:String
    //List of available stock items
    var available:[StockCheckerItem:Bool] = [StockCheckerItem:Bool]()
    
    //TODO: Location
    
    init(name:String) {
        self.name = name
        super.init()
    }
    
    func addAvailability(item:StockCheckerItem, available:Bool) {
        self.available[item] = available
    }
}
