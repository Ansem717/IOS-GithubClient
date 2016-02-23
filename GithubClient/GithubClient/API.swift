//
//  API.swift
//  GithubClient
//
//  Created by Andy Malik on 2/23/16.
//  Copyright © 2016 AndyMalik. All rights reserved.
//

import Foundation

typealias APICompletionHandler = (success: Bool, json: [[String : AnyObject]]) -> ()

class API {
    
    static let shared = API()
    private init() {}
    
    let session = NSURLSession.sharedSession()
    
    func enqueue(apiRequest: APIRequest, completion: APICompletionHandler) {
        let request = NSMutableURLRequest.requestWithAPIRequest(apiRequest)
        self.session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if error == nil {
                if let data = data {
                    do {
                        if let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [[String: AnyObject]] {
                            print(json[0])
                            completion(success: true, json: json)
                        }
                        if let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String : AnyObject] {
                            completion(success: true, json: [json])
                        }
                    } catch _ {}
                }
            }
        }.resume()
    }
}