//
//  main.swift
//  AppleStockChecker
//
//  Created by Brendan Boyle on 12/30/16.
//  Copyright © 2016 Brendan Boyle. All rights reserved.
//

import Foundation

//Attribution
print("Apple Stock Checker by @brendancboyle")

let manager:StockCheckerManager = StockCheckerManager()

//Check command line arguments
switch CommandLine.argc {
case 3:
    //Create item from command line args
    let product:StockCheckerItem = StockCheckerItem(model: CommandLine.arguments[1], zipCode: Int(CommandLine.arguments[2])!)
    manager.addItem(item: product)
    print("Searching for \(product.model) in \(product.zipCode)...")
    break
default:
    print("Usage: \(CommandLine.arguments[0]) MMEF2AM/A 27606")
    exit(ERR_SUCCESS)
    break
}

//Run main thread until app is quit
RunLoop.main.run()
