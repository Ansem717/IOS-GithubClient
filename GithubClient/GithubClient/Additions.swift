//
//  Additions.swift
//  GithubClient
//
//  Created by Andy Malik on 2/23/16.
//  Copyright © 2016 AndyMalik. All rights reserved.
//

import Foundation

extension NSMutableURLRequest {
    class func requestWithAPIRequest(apiRequest: APIRequest) -> NSMutableURLRequest {
        let request = NSMutableURLRequest()
        var reqURL = NSURL(string: "\(apiRequest.url())?")!
        
        // If there is an HTTPBody, add it to the request
        if let httpBody = apiRequest.httpBody() {
            request.HTTPBody = httpBody
        }
        
        // If parameters in URL, handle them. MARK: Refactor me please!
        if let apiQuery = apiRequest.queryStringParam() {
            var queryArray = [String]()
            var queryString = String()
            
            for (key, value) in apiQuery {
                queryArray.append("\(key)=\(value)")
            }
            
            queryString = queryArray.joinWithSeparator("&")
            
            if let encodedHost = queryString.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet()) {
                reqURL = NSURL(string: "\(apiRequest.url())?".stringByAppendingString(encodedHost))!
            }
        }
        
        if let apiHeaders = apiRequest.httpHeaders() {
            for (key, value) in apiHeaders {
                request.setValue(value, forKey: key)
            }
        }
        
        request.URL = reqURL
        request.HTTPMethod = apiRequest.httpMethod
        
        return request
    }
}