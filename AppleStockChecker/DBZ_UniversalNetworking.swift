//
//  DBZ_UniversalNetworking.swift
//  Universal Presenter Remote
//
//  Created by Brendan Boyle on 4/25/16.
//  Copyright © 2016 DBZ Technology. All rights reserved.
//
import Cocoa

struct DBZ_NetworkResponse {
    var page:Any
    var htmlData:String
    var response:URLResponse
}

class DBZ_UniversalNetworking: NSObject {
    
    static func httpGet(_ url: String, callback: @escaping (DBZ_NetworkResponse) -> Void, page:Any) {
        let request = NSMutableURLRequest(url: URL(string: url)!)
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        httpRequest(request, session: session, callback: callback, page: page)
    }
    
    static func httpRequest(_ request: NSMutableURLRequest, session: URLSession, callback: @escaping (DBZ_NetworkResponse) -> Void, page:Any) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "ReloadingDataStart"), object: nil)
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) -> Void in
            NotificationCenter.default.post(name: Notification.Name(rawValue: "ReloadingDataStop"), object: nil)
            if error != nil {
                print(error!.localizedDescription)
            } else {
                let result = NSString(data: data!, encoding: String.Encoding.ascii.rawValue)!
                let callbackResponse:DBZ_NetworkResponse = DBZ_NetworkResponse(page: page, htmlData: result as String, response: response!)
                callback(callbackResponse)
            }
        })
        
        task.resume()
        
        session.finishTasksAndInvalidate()
    }
    
}
