//
//  APIRequest.swift
//  GithubClient
//
//  Created by Andy Malik on 2/23/16.
//  Copyright © 2016 AndyMalik. All rights reserved.
//

import UIKit

enum MIMEType: String {
    case ApplicationXWWWFormUrlEncoded = "application/x-www.form-urlencoded"
    case ApplicationJSON = "application/json"
}

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case DELETE = "DELETE"
    case PUT = "PUT"
}

protocol APIRequest {
    var httpMethod: HTTPMethod { set get }
    var headerContentType: MIMEType { set get }
    
    func url() -> String
    
    func httpHeaders() -> [String : String]?
    func httpBody() -> NSData?
    func queryStringParam() -> [String : String]?
}

extension APIRequest {
    func httpHeaders() -> [String : String]? { return nil }
    func httpBody() -> NSData? { return nil }
    func queryStringParam() -> [String : String]? { return nil }
}